require('telescope').setup {
  extensions = {
    media_files = {
      -- filetypes whitelist
      filetypes = {"png", "jpg", "mp4", "webm", "pdf"},
      -- find command (default is `fd`)
      find_cmd = "rg"
    }
  },
}

-- To load the extension when telescope is loaded
require('telescope').load_extension('media_files')
