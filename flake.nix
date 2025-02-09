{
  description = "My attempt at nightly neovim";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
  };

  outputs = { self, nixpkgs, neovim-nightly-overlay }: let
    pkgs = import nixpkgs {
      system = "x86_64-linux";
      overlays = [ neovim-nightly-overlay.overlays.default ];
    };

    langs = with pkgs; [
      pkgs.python3
    ];

    deps = with pkgs; [
      # pkgs.curl
      pkgs.fzf
      pkgs.gcc
      pkgs.ripgrep
      pkgs.file
    ];

    lsp_servers = with pkgs; [
      pkgs.basedpyright
      pkgs.lua-language-server
      pkgs.nil
    ];

    formatters = with pkgs; [
      # pkgs.pretter
    ];

    linters = with pkgs; [
      # pkgs.shellcheck
    ];

    plugins = with pkgs; [
      # pkgs.neovimPlugins.treesitter  # Example: Treesitter plugin for Neovim
      # pkgs.neovimPlugins.nvim-lspconfig  # Example: LSP configuration plugin
    ];

  in {
    packages.x86_64-linux.default = pkgs.buildEnv {
      name = "neovim-with-deps";
      paths = [
        pkgs.neovim  # Use the nightly version from the overlay
      ] ++ langs ++ deps ++ lsp_servers ++ formatters ++ linters ++ plugins;
    };
  };
}

