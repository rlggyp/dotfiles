return {
  "michaelrommel/nvim-silicon",
  lazy = true,
  cmd = "Silicon",
  main = "nvim-silicon",
  opts = {
    -- Configuration here, or leave empty to use defaults
    line_offset = function(args)
    	return args.line1
    end,
    debug = false,
    no_round_corner = true,
    -- the theme to use, depends on themes available to silicon
    theme = "tokyonight_night",
    output = function()
      return "/home/rlggyp/Pictures/code_screenshot/" .. os.date("!%Y-%m-%dT%H-%M-%SZ") .. "_code.png"
    end,
  }
}
