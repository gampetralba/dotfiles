local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local d = ls.dynamic_node
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local rep = require("luasnip.extras").rep

-- LuaFormatter off
return {
    s("fn", fmta([[
        function <>(<>) {
          <>
        };
     ]], {i(1), i(2), i(0)})),

    s("cfn", fmta([[
        const <> = (<>) =>> {
          <>
        };
     ]], {i(1), i(2), i(0)})),

    s("cl", fmta([[
        console.log(<>);
     ]], {i(1)})),

    s("comp", fmta([[
        export default function<>(<>) {
          <>
        };
     ]], {i(1), i(2), i(0)})),

    s("comp2", fmta([[
        const <> = (<>) =>> {
          <>
        };

        export default <>;
     ]], {i(1), i(2), i(0), rep(1)})),
}
-- LuaFormatter on
