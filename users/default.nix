{users, ...}: {
  imports = map (u: ./${u}) users;
}
