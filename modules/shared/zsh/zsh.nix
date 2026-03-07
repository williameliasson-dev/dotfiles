{
  config,
  lib,
  pkgs,
  ...
}:
{
  home.file.".zshrc".text = ''
    export OMP_THEME_DIR="${pkgs.oh-my-posh}/share/oh-my-posh/themes"
    ${builtins.readFile ./zshrc}

    # Load zsh plugins
    source ${pkgs.zsh-autosuggestions}/share/zsh-autosuggestions/zsh-autosuggestions.zsh
    source ${pkgs.zsh-syntax-highlighting}/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
    source ${pkgs.zsh-history-substring-search}/share/zsh-history-substring-search/zsh-history-substring-search.zsh

    # Source Lemur CLI aliases
    for file in ~/.lemur/cli/*.zsh; do source $file; done
  '';

  home.packages = with pkgs; [
    oh-my-posh
    zsh-autosuggestions
    zsh-syntax-highlighting
    zsh-history-substring-search
  ];
}
