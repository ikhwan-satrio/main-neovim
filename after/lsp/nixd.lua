local flake_path = vim.fn.getcwd()

return {
  cmd = { 'nixd' },
  filetypes = { 'nix' },
  settings = {
    nixd = {
      nixpkgs = {
        expr = 'import (builtins.getFlake "' .. flake_path .. '").inputs.nixpkgs { }',
      },
      options = {
        -- Pakai nixosConfigurations langsung, semua module sudah ter-include otomatis
        nixos = {
          expr = '(builtins.getFlake "' .. flake_path .. '").nixosConfigurations.nixos-btw.options',
        },
        -- Home manager diambil dari nixos config juga
        home_manager = {
          expr = '(builtins.getFlake "' .. flake_path .. '").nixosConfigurations.nixos-btw.options.home-manager',
        },
      },
    },
  },
}
