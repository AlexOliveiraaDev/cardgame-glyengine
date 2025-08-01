local ui_jsx = require('source_engine_api_draw_ui_jsx')
local ui_grid = require('source_engine_api_draw_ui_grid')
local ui_slide = require('source_engine_api_draw_ui_slide')
local ui_style = require('source_engine_api_draw_ui_style')
local util_decorator = require('source_shared_functional_decorator')
local function install(std, engine, application)
    std.ui = std.ui or {}
    std.h = util_decorator.prefix2(std, engine, ui_jsx.h)
    std.ui.grid = util_decorator.prefix2(std, engine, ui_grid.component)
    std.ui.slide = util_decorator.prefix2(std, engine, ui_slide.component)
    std.ui.style = util_decorator.prefix2(std, engine, ui_style.component)
end
local P = {
    install=install
}
return P
