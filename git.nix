{ ... }:

{
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "Ma1y0";
        email = "matyas.barr@gmail.com";
      };
      init.defaultBranch = "main";
    };
  };
}
