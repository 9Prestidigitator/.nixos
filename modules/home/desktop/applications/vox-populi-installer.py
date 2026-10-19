#!/usr/bin/env python3
"""Manage CivFanatics multiplayer modpacks on Linux (Proton) or Windows.

Standalone usage: Python 3, gdown >= 6 (for Drive discovery), and curl on PATH.
Method: https://forums.civfanatics.com/threads/685164/
"""

import argparse
import json
import os
import platform
from pathlib import Path, PurePosixPath
import re
import shutil
import stat
import subprocess
import sys
import tempfile
import zipfile

MODPACKS = {"ZMP_MODPACK", "MP_MODPACK", "VP_MODPACK"}
FOLDERS = MODPACKS | {"VPUI", "UI_bc1"}
DRIVE_FOLDER = (
    "https://drive.google.com/drive/folders/1Sv2p7jq2TaZNqtuuVFf3bJc_bCPgIEW_"
)


def fail(message):
    raise RuntimeError(message)


def detect_platform():
    system = platform.system()
    if system not in {"Linux", "Windows"}:
        fail(
            f"Unsupported platform: {system}. Vox Populi requires the Windows game; "
            "use Windows or Linux with Proton. Native macOS Civ V is not supported."
        )
    return system


def steam_roots(system):
    if system == "Windows":
        import winreg

        roots = []
        for hive, key, value in (
            (winreg.HKEY_CURRENT_USER, r"Software\Valve\Steam", "SteamPath"),
            (winreg.HKEY_LOCAL_MACHINE, r"SOFTWARE\Valve\Steam", "InstallPath"),
        ):
            for view in (winreg.KEY_WOW64_32KEY, winreg.KEY_WOW64_64KEY):
                try:
                    with winreg.OpenKey(hive, key, 0, winreg.KEY_READ | view) as handle:
                        roots.append(Path(winreg.QueryValueEx(handle, value)[0]))
                except OSError:
                    pass
        for variable in ("ProgramFiles(x86)", "ProgramFiles"):
            if os.environ.get(variable):
                roots.append(Path(os.environ[variable]) / "Steam")
        return roots
    roots = [
        Path.home() / p
        for p in (
            ".local/share/Steam",
            ".steam/steam",
            ".steam/root",
            ".var/app/com.valvesoftware.Steam/.local/share/Steam",
        )
    ]
    if os.environ.get("XDG_DATA_HOME"):
        roots.append(Path(os.environ["XDG_DATA_HOME"]) / "Steam")
    return roots


def windows_documents():
    # Ask Windows for Documents, including redirected/OneDrive locations.
    import ctypes

    buffer = ctypes.create_unicode_buffer(32768)
    result = ctypes.windll.shell32.SHGetFolderPathW(None, 5, None, 0, buffer)
    if result != 0:
        fail("Windows could not locate your Documents folder.")
    return Path(buffer.value)


def lock_installation(lock, system):
    try:
        if system == "Windows":
            import msvcrt

            lock.seek(0, os.SEEK_END)
            if lock.tell() == 0:
                lock.write(b"\0")
                lock.flush()
            lock.seek(0)
            msvcrt.locking(lock.fileno(), msvcrt.LK_NBLCK, 1)
        else:
            import fcntl

            fcntl.flock(lock, fcntl.LOCK_EX | fcntl.LOCK_NB)
    except OSError as error:
        fail(f"Cannot lock installation (another installer may be running): {error}")


def latest_source(variant):
    print(f"Finding latest {variant} modpack on Google Drive...", flush=True)
    result = subprocess.run(
        ["gdown", "--json", DRIVE_FOLDER], check=True, capture_output=True, text=True
    )
    entries = json.loads(result.stdout)
    candidates = []
    for entry in entries:
        name = PurePosixPath(entry["path"]).name
        match = re.fullmatch(
            r"(\d+(?:\.\d+)+)_" + re.escape(variant) + r"\.zip", name, re.I
        )
        if match:
            version = tuple(int(part) for part in match[1].split("."))
            candidates.append((version, name, entry["url"]))
    if not candidates:
        fail(
            f"No versioned {variant} ZIP found; supply a ZIP path or file URL explicitly."
        )
    version = max(candidate[0] for candidate in candidates)
    newest = {(name, url) for number, name, url in candidates if number == version}
    if len(newest) != 1:
        fail("Multiple ZIPs match the latest version; supply an explicit file URL.")
    name, url = newest.pop()
    print(f"Selected {name}: {url}", flush=True)
    return url


def remove(path):
    if path.is_symlink() or path.is_file():
        path.unlink()
    elif path.exists():
        shutil.rmtree(path)


def discover(system):
    roots = steam_roots(system)
    libraries = set()
    for root in roots:
        libraries.add(root.resolve())
        vdf = root / "steamapps/libraryfolders.vdf"
        if vdf.is_file():
            for value in re.findall(r'"path"\s+"((?:\\.|[^"\\])*)"', vdf.read_text()):
                libraries.add(Path(value.replace(r"\\", "\\")).resolve())
    games = set()
    for library in libraries:
        manifest = library / "steamapps/appmanifest_8930.acf"
        if manifest.is_file():
            match = re.search(r'"installdir"\s+"([^"/]+)"', manifest.read_text())
            if match:
                games.add((library / "steamapps/common" / match[1]).resolve())
    if len(games) != 1:
        fail("Could not identify one Civ V installation; pass --game-dir PATH.")
    return games.pop()


def clear_cache(game, system):
    if system == "Windows":
        data_dirs = [windows_documents() / "My Games/Sid Meier's Civilization 5"]
    else:
        prefix = os.environ.get("STEAM_COMPAT_DATA_PATH")
        compat = Path(prefix) if prefix else game.parent.parent / "compatdata/8930"
        users = compat / "pfx/drive_c/users"
        data_dirs = [
            data
            for documents in ("Documents", "My Documents")
            for data in users.glob(f"*/{documents}/My Games/Sid Meier's Civilization 5")
        ]
    caches = set()
    for data in data_dirs:
        if data.is_dir():
            for child in data.iterdir():
                if child.name.lower() == "cache":
                    caches.add(child)
    for cache in caches:
        remove(cache)
        print(f"Removed cache: {cache}")
    if not caches:
        print("No Civ V cache found (launch the game once to create it).")


def unpack(source, destination):
    with zipfile.ZipFile(source) as archive:
        for entry in archive.infolist():
            path = PurePosixPath(entry.filename)
            mode = entry.external_attr >> 16
            if (
                path.is_absolute()
                or ".." in path.parts
                or "\\" in entry.filename
                or ":" in entry.filename
                or stat.S_ISLNK(mode)
            ):
                fail(f"Unsafe archive entry: {entry.filename}")
        archive.extractall(destination)
    # Accept either DLC folders at the ZIP root or one enclosing directory.
    root = destination
    while True:
        children = list(root.iterdir())
        if (
            len(children) == 1
            and children[0].is_dir()
            and children[0].name not in FOLDERS
        ):
            root = children[0]
        else:
            break
    names = {p.name for p in root.iterdir() if p.is_dir()}
    if len(names & MODPACKS) != 1 or names - FOLDERS:
        fail(
            "Expected one VP_MODPACK, ZMP_MODPACK or MP_MODPACK, plus optional VPUI/UI_bc1."
        )
    return root, names


def main():
    parser = argparse.ArgumentParser(
        description=__doc__,
        epilog="""
Download a ZIP from https://forums.civfanatics.com/threads/685164/.
Use English and DirectX 10/11; on Linux enable Proton. Close Civ V first.
Play from the normal game menu, not MODS. All players need the same ZIP
and map scripts. Run clear-cache before every multiplayer session.
Google Drive sharing links are supported; folder links are not.
""",
    )
    parser.add_argument(
        "--game-dir", type=Path, help="Civ V directory in steamapps/common"
    )
    sub = parser.add_subparsers(dest="command", required=True)
    install = sub.add_parser(
        "install", help="download latest modpack, or install a supplied ZIP/URL"
    )
    install.add_argument(
        "source",
        nargs="?",
        help="ZIP path or HTTPS file URL (default: latest version on Drive)",
    )
    install.add_argument(
        "--variant",
        choices=["VP-EUI", "VP", "CP", "VP-EUI_SSEM"],
        default="VP-EUI",
        help="modpack to download when source is omitted (default: VP-EUI)",
    )
    sub.add_parser(
        "uninstall", help="remove modpack folders and restore backed-up maps"
    )
    sub.add_parser("clear-cache", help="clear Civ V's cache for the detected platform")
    args = parser.parse_args()

    system = detect_platform()
    if system == "Linux" and os.geteuid() == 0:
        fail("Run as your Steam user, without sudo.")

    game = args.game_dir.expanduser().resolve() if args.game_dir else discover(system)
    dlc = game / "Assets/DLC"
    if not dlc.is_dir() or not (game / "CivilizationV.exe").is_file():
        hint = (
            "Enable Proton in Steam and install/launch Civ V first."
            if system == "Linux"
            else "Install/launch Civ V through Steam first."
        )
        fail(f"Windows Civ V not found. {hint}")
    print(f"Platform: {system}; game: {game}")

    with (game / ".vox-populi.lock").open("a+b") as lock:
        lock_installation(lock, system)
        if args.command == "clear-cache":
            clear_cache(game, system)
            return

        maps = game / "Assets/Maps"
        backup = game / "Assets/.vox-populi-original-maps"
        if maps.is_symlink() or backup.is_symlink():
            fail("Refusing to replace symlinked map directories.")

        with tempfile.TemporaryDirectory(prefix=".vox-populi-", dir=game) as tmp:
            temp = Path(tmp)
            names = set()
            if args.command == "install":
                source = args.source or latest_source(args.variant)
                if source.startswith("https://"):
                    download = temp / "modpack.zip"
                    if re.match(r"https://drive\.google\.com/", source):
                        subprocess.run(
                            ["gdown", source, "-O", str(download)], check=True
                        )
                    else:
                        subprocess.run(
                            [
                                "curl",
                                "--fail",
                                "--location",
                                "--proto",
                                "=https",
                                "--proto-redir",
                                "=https",
                                "--output",
                                str(download),
                                source,
                            ],
                            check=True,
                        )
                    source = download
                root, names = unpack(source, temp / "extracted")
                if not maps.is_dir():
                    fail(
                        "Assets/Maps is missing; verify the game files in Steam first."
                    )

            # Snapshot all affected paths before changing the installation.
            targets = [dlc / name for name in sorted(FOLDERS)] + [maps, backup]
            saved = temp / "saved"
            saved.mkdir()
            for index, target in enumerate(targets):
                if target.is_symlink():
                    fail(f"Refusing to replace symlink: {target}")
                if target.exists():
                    shutil.copytree(target, saved / str(index))

            try:
                for name in FOLDERS:
                    remove(dlc / name)
                if backup.exists():
                    remove(maps)
                    shutil.copytree(backup, maps)
                if args.command == "install":
                    if not backup.exists():
                        shutil.copytree(maps, backup)
                    for name in names:
                        shutil.copytree(root / name, dlc / name)
                    for name in names & MODPACKS:
                        for scripts in (dlc / name).rglob("Mapscripts"):
                            if scripts.is_dir():
                                shutil.copytree(scripts, maps, dirs_exist_ok=True)
                else:
                    remove(backup)
            except BaseException:
                for index, target in enumerate(targets):
                    remove(target)
                    if (saved / str(index)).exists():
                        shutil.copytree(saved / str(index), target)
                raise

            clear_cache(game, system)
            print(f"Vox Populi {args.command} complete: {game}")


if __name__ == "__main__":
    try:
        main()
    except (
        RuntimeError,
        OSError,
        ValueError,
        zipfile.BadZipFile,
        subprocess.CalledProcessError,
    ) as error:
        if isinstance(error, subprocess.CalledProcessError) and error.stderr:
            print(error.stderr, file=sys.stderr)
        raise SystemExit(f"civ5-vox-populi: {error}")
