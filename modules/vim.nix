{ inputs, ... }:

{
programs.nixvim = {
  enable = true;
  defaultEditor = true;
  colorschemes.gruvbox.enable = true;
  globals.mapleader = " ";

  plugins = {
   telescope = {
	enable = true;
	keymaps = {


   


  "<leader>ff" = {
    action = "find_files";
    options = {
      desc = "Telescope Files";
    };
  };
  "<leader>fg" = "live_grep";
};

   };
  };

};
}
