-- Go LSP Configuration
return {
  cmd = { 'gopls' },
  filetypes = { 'go', 'gomod', 'gowork', 'gotmpl' },
  root_markers = { 'go.mod', 'go.work' },
  settings = {
    gopls = {
      usePlaceholders = true,
      completeUnimported = true,
      gofumpt = true,
      staticcheck = true,
    },
  },
}
