{lib, ...}: {
  options.owner = {
    username = lib.mkOption {type = lib.types.str;};
    fullName = lib.mkOption {type = lib.types.str;};
    email = lib.mkOption {type = lib.types.str;};
  };

  config.owner = {
    username = "dawn";
    fullName = "Donn Jayson Quinto";
    email = "djayson.work@proton.me";
  };
}
