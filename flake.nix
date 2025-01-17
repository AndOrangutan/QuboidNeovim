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

    deps = with pkgs; [
      # pkgs.curl
      pkgs.ripgrep
    ];


    lsp_servers = with pkgs; [
      # pkgs.lua-language-server
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
      ] ++ deps ++ lsp_servers ++ formatters ++ linters ++ plugins;
    };
  };
}

