return {
  cmd = {
    'arduino-language-server',
    '-clangd', vim.fn.exepath('clangd'),
    '-cli', vim.fn.exepath('arduino-cli'),
    '-cli-config', vim.fn.expand('~/.arduino15/arduino-cli.yaml'),
    '-fqbn', 'arduino:avr:uno',  -- sesuaikan board kamu
  },
  filetypes = { 'arduino' },
}
