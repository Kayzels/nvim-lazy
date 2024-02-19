local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
return {
  s({
    trig = "HEL",
    desc = "An autotriggering snippet that expands HEL into Hello World",
    regTrig = false,
    priority = 100,
    snippetType = "autosnippet",
  }, { t("Hello world!") }),
  s({
    trig = "hi",
    desc = "A snippet that expands hi into Hello World",
    regTrig = false,
    priority = 100,
  }, { t("Hello world!") }),
}
