{ pkgs ? import <nixpkgs> { } }:

{ url, destination, branch ? "main" }:
let
  repoName =
    builtins.baseNameOf (builtins.replaceStrings [ ".git" ] [ "" ] url);
  syncScript = pkgs.writeShellScript "sync-${repoName}" ''
    set -e

    REPO_URL="${url}"
    DEST_DIR="${destination}"
    BRANCH="${branch}"
    TIMESTAMP=$(date +%Y%m%d_%H%M%S)

    mkdir -p "$(dirname "$DEST_DIR")"

    if [ -d "$DEST_DIR/.git" ]; then
        cd "$DEST_DIR"

        if ! ${pkgs.git}/bin/git diff --quiet || ! ${pkgs.git}/bin/git diff --cached --quiet; then
            BACKUP_DIR="$DEST_DIR.backup_$TIMESTAMP"
            echo "Unstaged changes detected! Creating backup at: $BACKUP_DIR"
            cp -r "$DEST_DIR" "$BACKUP_DIR"
            echo "Backup created successfully"
        fi

        # Check for untracked files
        if [ -n "$(${pkgs.git}/bin/git ls-files --others --exclude-standard)" ]; then
            BACKUP_DIR="$DEST_DIR.backup_$TIMESTAMP"
            if [ ! -d "$BACKUP_DIR" ]; then
                echo "Unstaged changes detected! Creating backup at: $BACKUP_DIR"
                cp -r "$DEST_DIR" "$BACKUP_DIR"
                echo "Backup created successfully"
            fi
        fi

        # Stash any changes and pull
        ${pkgs.git}/bin/git stash push -u -m "Auto-stash before NixOS rebuild at $TIMESTAMP" || true
        ${pkgs.git}/bin/git fetch origin
        ${pkgs.git}/bin/git checkout "$BRANCH"
        ${pkgs.git}/bin/git pull origin "$BRANCH"
    else
        echo "Cloning repository to $DEST_DIR..."
        ${pkgs.git}/bin/git clone --branch "$BRANCH" "$REPO_URL" "$DEST_DIR"
        echo "Repository cloned successfully: $DEST_DIR"
    fi

    echo "Repository synced successfully: $DEST_DIR"
  '';

in syncScript
