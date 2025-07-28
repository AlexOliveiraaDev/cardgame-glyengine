local math = ((function() local x, y = pcall(require, 'math'); return x and y end)()) or _G.math
local source_version_1c9c98 = nil
local source_shared_functional_decorator_1abfc0 = nil
local source_shared_engine_loadcore_1969c8 = nil
local source_shared_engine_loadgame_1c6ee0 = nil
local source_engine_api_draw_fps_1c2968 = nil
local source_engine_api_draw_poly_2b3fb8 = nil
local source_engine_api_draw_text_1c4258 = nil
local source_engine_api_draw_ui_1ea668 = nil
local source_engine_api_data_array_1d6f80 = nil
local source_engine_api_data_encoder_2007c0 = nil
local source_engine_api_data_hash_20ecb8 = nil
local source_engine_api_data_i18n_24a558 = nil
local source_engine_api_debug_log_210c78 = nil
local source_engine_api_io_http_24a3c0 = nil
local source_engine_api_io_media_1e9990 = nil
local source_engine_api_io_storage_1cae18 = nil
local source_engine_api_raw_bus_1caca0 = nil
local source_engine_api_raw_memory_1d8328 = nil
local source_engine_api_raw_node_220970 = nil
local source_engine_api_system_color_1c65a0 = nil
local source_engine_api_system_app_1d81a8 = nil
local source_engine_api_system_key_1d86c0 = nil
local source_engine_api_system_math_2a9c98 = nil
local source_engine_protocol_http_callback_10ec00 = nil
local source_shared_var_object_root_1dcec8 = nil
local source_shared_var_object_std_1d7be8 = nil
local source_shared_functional_pipeline_2b3f50 = nil
local source_shared_string_dsl_requires_1f67b0 = nil
local source_shared_string_eval_file_29c410 = nil
local source_shared_string_eval_code_21e1f8 = nil
local source_engine_api_draw_ui_jsx_1e95e8 = nil
local source_engine_api_draw_ui_grid_10e628 = nil
local source_engine_api_draw_ui_slide_1cab98 = nil
local source_engine_api_draw_ui_style_296170 = nil
local source_shared_var_object_node_1b58d0 = nil
local source_shared_string_encode_http_1cc2f0 = nil
local source_shared_string_encode_url_1c6918 = nil
local source_engine_api_draw_ui_common_1c0450 = nil
local function main_1c29b8()
local version = source_version_1c9c98()
local util_decorator = source_shared_functional_decorator_1abfc0()
local loadcore = source_shared_engine_loadcore_1969c8()
local loadgame = source_shared_engine_loadgame_1c6ee0()
local engine_draw_fps = source_engine_api_draw_fps_1c2968()
local engine_draw_poly = source_engine_api_draw_poly_2b3fb8()
local engine_draw_text = source_engine_api_draw_text_1c4258()
local engine_draw_ui = source_engine_api_draw_ui_1ea668()
local engine_array = source_engine_api_data_array_1d6f80()
local engine_encoder = source_engine_api_data_encoder_2007c0()
local engine_hash = source_engine_api_data_hash_20ecb8()
local engine_i18n = source_engine_api_data_i18n_24a558()
local engine_log = source_engine_api_debug_log_210c78()
local engine_http = source_engine_api_io_http_24a3c0()
local engine_media = source_engine_api_io_media_1e9990()
local engine_storage = source_engine_api_io_storage_1cae18()
local engine_raw_bus = source_engine_api_raw_bus_1caca0()
local engine_raw_memory = source_engine_api_raw_memory_1d8328()
local engine_raw_node = source_engine_api_raw_node_220970()
local engine_color = source_engine_api_system_color_1c65a0()
local engine_game = source_engine_api_system_app_1d81a8()
local engine_key = source_engine_api_system_key_1d86c0()
local engine_math = source_engine_api_system_math_2a9c98()
local callback_http = source_engine_protocol_http_callback_10ec00()
local application_default = source_shared_var_object_root_1dcec8()
local std = source_shared_var_object_std_1d7be8()
local application = application_default
local engine = {
current = application_default,
root = application_default,
offset_x = 0,
offset_y = 0
}
local cfg_system = {
exit = native_system_exit,
reset = native_system_reset,
title = native_system_title,
get_fps = native_system_get_fps,
get_secret = native_system_get_secret,
get_language = native_system_get_language
}
local cfg_media = {
bootstrap=native_media_bootstrap,
position=native_media_position,
resize=native_media_resize,
resume=native_media_resume,
source=native_media_source,
pause=native_media_pause,
play=native_media_play,
stop=native_media_stop
}
local cfg_poly = {
repeats = {
native_cfg_poly_repeat_0 or false,
native_cfg_poly_repeat_1 or false,
native_cfg_poly_repeat_2 or false
},
triangle = native_draw_triangle,
poly2 = native_draw_poly2,
poly = native_draw_poly,
line = native_draw_line
}
local cfg_http = {
install = native_http_install,
handler = native_http_handler,
has_ssl = native_http_has_ssl,
has_callback = native_http_has_callback,
force = native_http_force_protocol
}
local cfg_log = {
fatal = native_log_fatal,
error = native_log_error,
warn = native_log_warn,
info = native_log_info,
debug = native_log_debug
}
local cfg_base64 = {
decode = native_base64_decode,
encode = native_base64_encode
}
local cfg_json = {
decode = native_json_decode,
encode = native_json_encode
}
local cfg_xml = {
decode = native_xml_decode,
encode = native_xml_encode
}
local cfg_text = {
font_previous = native_text_font_previous
}
local cfg_storage = {
install = native_storage_install and function() native_storage_install() end,
get = native_storage_get,
set = native_storage_set
}
local function clear(tint)
local x, y = engine.offset_x, engine.offset_y
local width, height = engine.current.data.width, engine.current.data.height
native_draw_clear(tint, x, y, width, height)
end
function native_callback_loop(dt)
std.milis = std.milis + dt
std.delta = dt
std.bus.emit('loop')
end
function native_callback_draw()
native_draw_start()
std.bus.emit('draw')
native_draw_flush()
end
function native_callback_resize(width, height)
engine.root.data.width = width
engine.root.data.height = height
std.app.width = width
std.app.height = height
std.bus.emit('resize', width, height)
end
function native_callback_keyboard(key, value)
std.bus.emit('rkey', key, value)
end
function native_callback_http(id, key, data)
if cfg_http.has_callback then
return callback_http.func(engine['http_requests'][id], key, data, std)
end
return nil
end
function native_callback_init(width, height, game_lua)
application = loadgame.script(game_lua, application_default)
if application then
application.data.width = width
application.data.height = height
std.app.width = width
std.app.height = height
end
std.draw.color=native_draw_color
std.draw.clear=clear
std.draw.rect=util_decorator.offset_xy2(engine, native_draw_rect)
std.draw.line=util_decorator.offset_xyxy1(engine, native_draw_line)
std.draw.image=util_decorator.offset_xy2(engine, native_image_draw)
std.image.load=native_image_load
std.image.draw=util_decorator.offset_xy2(engine, native_image_draw)
std.text.print = util_decorator.offset_xy1(engine, native_text_print)
std.text.mensure=native_text_mensure
std.text.font_size=native_text_font_size
std.text.font_name=native_text_font_name
std.text.font_default=native_text_font_default
loadcore.setup(std, application, engine)
:package('@bus', engine_raw_bus)
:package('@node', engine_raw_node)
:package('@memory', engine_raw_memory)
:package('@game', engine_game, cfg_system)
:package('@math', engine_math)
:package('@array', engine_array)
:package('@key', engine_key, {})
:package('@draw.ui', engine_draw_ui)
:package('@draw.fps', engine_draw_fps)
:package('@draw.text', engine_draw_text, cfg_text)
:package('@draw.poly', engine_draw_poly, cfg_poly)
:package('@color', engine_color)
:package('@log', engine_log, cfg_log)
:package('math', engine_math.clib)
:package('math.wave', engine_math.wave)
:package('math.random', engine_math.clib_random)
:package('http', engine_http, cfg_http)
:package('base64', engine_encoder, cfg_base64)
:package('json', engine_encoder, cfg_json)
:package('xml', engine_encoder, cfg_xml)
:package('i18n', engine_i18n, cfg_system)
:package('media.video', engine_media, cfg_media)
:package('media.music', engine_media, cfg_media)
:package('mock.video', engine_media)
:package('mock.music', engine_media)
:package('storage', engine_storage, cfg_storage)
:package('hash', engine_hash, cfg_system)
:run()
application.data.width, std.app.width = width, width
application.data.height, std.app.height = height, height
std.node.spawn(application)
std.app.title(application.meta.title..' - '..application.meta.version)
engine.root = application
engine.current = application
std.bus.emit_next('load')
std.bus.emit_next('init')
end
local P = {
meta={
title='gly-engine',
author='RodrigoDornelles',
description='native core',
version=version
}
}
return P
end
source_version_1c9c98 = function()
return '0.1.2'
end
--
source_shared_functional_decorator_1abfc0 = function()
local function decorator_prefix3(zig, zag, zom, func)
return function (a, b, c, d, e, f)
return func(zig, zag, zom, a, b, c, d, e, f)
end
end
local function decorator_prefix2(zig, zag, func)
return function (a, b, c, d, e, f)
return func(zig, zag, a, b, c, d, e, f)
end
end
local function decorator_prefix1(zig, func)
return function (a, b, c, d, e, f)
return func(zig, a, b, c, d, e, f)
end
end
local function decorator_offset_xy2(object, func)
return function(a, b, c, d, e, f)
local x = object.offset_x + (b or 0)
local y = object.offset_y + (c or 0)
return func(a, x, y, d, e, f)
end
end
local function decorator_offset_xyxy1(object, func)
return function(a, b, c, d, e, f)
local x1 = object.offset_x + a
local y1 = object.offset_y + b
local x2 = object.offset_x + c
local y2 = object.offset_y + d
return func(x1, y1, x2, y2, e, f)
end
end
local function decorator_offset_xy1(object, func)
return function(a, b, c, d, e, f)
local x = object.offset_x + a
local y = object.offset_y + b
return func(x, y, c, d, e, f)
end
end
local function table_prefix1(prefix, fn_table)
local new_table = {}
for name, fn in pairs(fn_table) do
new_table[name] = decorator_prefix1(prefix, fn)
end
return new_table
end
local P = {
offset_xy1 = decorator_offset_xy1,
offset_xy2 = decorator_offset_xy2,
offset_xyxy1 = decorator_offset_xyxy1,
prefix3 = decorator_prefix3,
prefix2 = decorator_prefix2,
prefix1 = decorator_prefix1,
prefix1_t = table_prefix1
}
return P
end
--
source_shared_engine_loadcore_1969c8 = function()
local zeebo_pipeline = source_shared_functional_pipeline_2b3f50()
local requires = source_shared_string_dsl_requires_1f67b0()
local function step_install_libsys(self, lib_name, library, custom, is_system)
if not is_system then return end
local ok, msg = pcall(function()
library.install(self.std, self.engine, custom, lib_name)
end)
if ok then
self.libsys[lib_name] = true
else
self.error('sys', lib_name, msg)
end
end
local function step_check_libsys(self, lib_name, library, custom, is_system)
if not is_system then return end
if not self.libsys[lib_name] then
self.error('sys', lib_name, 'is missing!')
end
end
local function step_install_libusr(self, lib_name, library, custom, is_system)
if is_system then return end
if self.libusr[lib_name] then return end
if not requires.should_import(self.spec, lib_name) then return end
self.libusr[lib_name] = pcall(function()
library.install(self.std, self.engine, custom, lib_name)
end)
end
local function step_check_libsys_all(self)
local missing = requires.missing(self.spec, self.libusr)
if #missing > 0 then
self.error('usr', '*', 'missing libs: '..table.concat(missing, ' '))
end
end
local function package(self, lib_name, library, custom)
self.pipeline[#self.pipeline + 1] = function()
local is_system = lib_name:sub(1, 1) == '@'
local name = is_system and lib_name:sub(2) or lib_name
self:step(name, library, custom, is_system)
end
return self
end
local function setup(std, application, engine)
if not application then
error('game not found!')
end
local spec = requires.encode((application.config or application).require or '')
local self = {
std = std,
spec = spec,
errmsg = '',
engine = engine,
package = package,
libusr = {},
libsys = {},
pipeline = {},
pipe = zeebo_pipeline.pipe
}
self.error = function (prefix, lib_name, message) 
self.errmsg = self.errmsg..'['..prefix..':'..lib_name..'] '..message..'\n'
end
self.run = function()
self.step = step_install_libsys
zeebo_pipeline.reset(self)
zeebo_pipeline.run(self)
self.step = step_check_libsys
zeebo_pipeline.reset(self)
zeebo_pipeline.run(self)
self.step = step_install_libusr
zeebo_pipeline.reset(self)
zeebo_pipeline.run(self)
step_check_libsys_all(self)
if #self.errmsg > 0 then
error(self.errmsg, 0)
end
end
return self
end
local P = {
setup = setup
}
return P
end
--
source_shared_engine_loadgame_1c6ee0 = function()
local eval_file = source_shared_string_eval_file_29c410()
local eval_code = source_shared_string_eval_code_21e1f8()
local has_io_open = io and io.open
local function normalize(app, base)
if not app then return nil end
if not app.callbacks then
local old_app = app
app = {meta={},config={},callbacks={}, data={}}
for key, value in pairs(old_app) do
local is_function = type(value) == 'function'
if base.meta and base.meta[key] and not is_function then
app.meta[key] = value
elseif base.config and base.config[key] and not is_function then
app.config[key] = value
elseif is_function then
app.callbacks[key] = value
else
app.data[key] = value
end
end
end
local function defaults(a, b, key)
if type(a[key]) ~= "table" then a[key] = {} end
for k, v in pairs(b[key]) do
if a[key][k] == nil then
a[key][k] = b[key][k]
end
end
end
for field in pairs(base) do
defaults(app, base, field)
end
return app
end
local function script(src, base)
if type(src) == 'table' or type(src) == 'userdata' then
return normalize(src, base)
end
local application = type(src) == 'function' and src
if not src or #src == 0 then
src = 'game'
end
if not application and src and src:find('\n') then
local ok, app = eval_code.script(src)
application = ok and app
else
local ok, app = eval_file.script(src)
application = ok and app
end
if not application and has_io_open then
local app_file = io.open(src)
if app_file then
local app_src = app_file:read('*a')
local ok, app = eval_code.script(app_src)
application = ok and app
app_file:close()
end
end
return normalize(application, base)
end
local P = {
script = script
}
return P
end
--
source_engine_api_draw_fps_1c2968 = function()
local function draw_fps(std, engine, show, pos_x, pos_y)
if show < 1 then return end
local x = engine.current.config.offset_x + pos_x
local y = engine.current.config.offset_y + pos_y
local s = 4
std.draw.color(0xFFFF00FF)
if show >= 1 then
std.draw.rect(0, x, y, 40, 24)
end
if show >= 2 then
std.draw.rect(0, x + 48, y, 40, 24)
end
if show >= 3 then
std.draw.rect(0, x + 96, y, 40, 24)
end
std.draw.color(0x000000FF)
std.text.font_size(16)
if show >= 3 then
local floor = std.math.floor or math.floor or function() return 'XX' end
local fps =  floor((1/std.delta) * 1000)
std.text.print(x + s, y, fps)
s = s + 46
end
if show >= 1 then
std.text.print(x + s, y, engine.fps)
s = s + 46
end
if show >= 2 then
std.text.print(x + s, y, engine.root.config.fps_max)
s = s + 46
end
end
local function install(std, engine)
std.app = std.app or {}
std.app.fps_show = function(show)
engine.root.config.fps_show = show
end
std.bus.listen('post_draw', function()
engine.current = engine.root
draw_fps(std, engine, engine.root.config.fps_show, 8, 8)
end)
end
local P = {
install=install
}
return P
end
--
source_engine_api_draw_poly_2b3fb8 = function()
local function decorator_poo(object, func)
if not object or not func then return func end
return function(a, b, c, d)
return func(object, a, b, c, d)
end
end
local function decorator_line(func_draw_line)
return function(mode, verts)
local index = 4
while index <= #verts do
func_draw_line(verts[index - 3], verts[index - 2], verts[index - 1], verts[index])
index = index + 2
end
end
end
local function decorator_triangle(func_draw_poly, std, func_draw_triangle)
if not func_draw_triangle then
return func_draw_poly
end
local point = function(x, y, px, py, scale, angle, ox, oy)
local xx = x + ((ox - px) * -scale * std.math.cos(angle)) - ((ox - py) * -scale * std.math.sin(angle))
local yy = y + ((oy - px) * -scale * std.math.sin(angle)) + ((oy - py) * -scale * std.math.cos(angle))
return xx, yy
end
return function(engine_mode, verts, x, y, scale, angle, ox, oy)
if #verts ~= 6 then
return func_draw_poly(engine_mode, verts, x, y, scale, angle, ox, oy)
end
ox = ox or 0
oy = oy or ox or 0
local x1, y1 = point(x, y, verts[1], verts[2], scale, angle, ox, oy)
local x2, y2 = point(x, y, verts[3], verts[4], scale, angle, ox, oy)
local x3, y3 = point(x, y, verts[5], verts[6], scale, angle, ox, oy)
return func_draw_triangle(engine_mode, x1, y1, x2, y2, x3, y3)
end
end
local function decorator_poly(func_draw_poly, std, modes, repeats)
local func_repeat = function(verts, mode)
if repeats and repeats[mode + 1] then
verts[#verts + 1] = verts[1]
verts[#verts + 1] = verts[2]
end
end
return function (engine_mode, verts, x, y, scale, angle, ox, oy)
if #verts < 6 or #verts % 2 ~= 0 then return end
local mode = modes and modes[engine_mode + 1] or engine_mode
local rotated = std.math.cos and angle and angle ~= 0
ox = ox or 0
oy = oy or ox or 0
if x and y and not rotated then
local index = 1
local verts2 = {}
scale = scale or 1
while index <= #verts do
if index % 2 ~= 0 then
verts2[index] = x + (verts[index] * scale)
else
verts2[index] = y + (verts[index] * scale)
end
index = index + 1
end
func_repeat(verts2, engine_mode)
func_draw_poly(mode, verts2)
elseif x and y then
local index = 1
local verts2 = {}
while index < #verts do
local px = verts[index]
local py = verts[index + 1]
local xx = x + ((ox - px) * -scale * std.math.cos(angle)) - ((ox - py) * -scale * std.math.sin(angle))
local yy = y + ((oy - px) * -scale * std.math.sin(angle)) + ((oy - py) * -scale * std.math.cos(angle))
verts2[index] = xx
verts2[index + 1] = yy
index = index + 2
end
func_repeat(verts2, engine_mode)
func_draw_poly(mode, verts2)
else
func_draw_poly(mode, verts)
end
end
end
local function decorator_position(engine, func)
return function(mode, verts, pos_x, pos_y, scale, angle, ox, oy)
local x = engine.current.config.offset_x + (pos_x or 0)
local y = engine.current.config.offset_y + (pos_y or 0)
ox = ox or 0
oy = ox or oy or 0
scale = scale or 1
angle = angle or 0
return func(mode, verts, x, y, scale, angle, ox, oy)
end
end
local function install(std, engine, config)
local draw_line = decorator_poo(config.object, config.line)
local draw_poly = decorator_poo(config.object, config.poly) or decorator_line(draw_line)
local draw_poly2 = config.poly2 or decorator_poly(draw_poly, std, config.modes, config.repeats)
local draw_verts = decorator_triangle(draw_poly2, std, config.triangle)
std.draw.poly = decorator_position(engine, draw_verts)
end
local P = {
install=install
}
return P
end
--
source_engine_api_draw_text_1c4258 = function()
local util_decorator = source_shared_functional_decorator_1abfc0()
local function text_put(std, engine, font_previous, pos_x, pos_y, text, size)
size = size or 2
local hem = engine.current.data.width / 80
local vem = engine.current.data.height / 24
local font_size = hem * size
std.text.font_default(0)
std.text.font_size(font_size)
std.text.print(pos_x * hem, pos_y * vem, text)
font_previous()
end
local function text_print_ex(std, engine, x, y, text, align_x, align_y)
local w, h = std.text.mensure(text)
local aligns_x, aligns_y = {w, w/2, 0}, {h, h/2, 0}
std.text.print(x - aligns_x[(align_x or 1) + 2], y - aligns_y[(align_y or 1) + 2], text)
return w, h
end
local function install(std, engine, config)
std.text.print_ex = util_decorator.prefix2(std, engine, text_print_ex)
std.text.put = util_decorator.prefix3(std, engine, config.font_previous, text_put)
end
local P = {
install=install
}
return P
end
--
source_engine_api_draw_ui_1ea668 = function()
local ui_jsx = source_engine_api_draw_ui_jsx_1e95e8()
local ui_grid = source_engine_api_draw_ui_grid_10e628()
local ui_slide = source_engine_api_draw_ui_slide_1cab98()
local ui_style = source_engine_api_draw_ui_style_296170()
local util_decorator = source_shared_functional_decorator_1abfc0()
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
end
--
source_engine_api_data_array_1d6f80 = function()
local util_decorator = source_shared_functional_decorator_1abfc0()
local function array_map(array, func)
local res = {}
local index = 1
local length = #array
while index <= length do
res[#res + 1] = func(array[index], index)
index = index + 1
end
return res
end
local function array_filter(array, func)
func = func or (function(v) return v and v ~= 0 end)
local res = {}
local index = 1
local length = #array
while index <= length do
local value = array[index]
if func(value, index) then
res[#res + 1] = value
end
index = index + 1
end
return res
end
local function array_unique(array)
local res = {}
local index = 1
local length = #array
local setmap = {}
while index <= length do
local value = array[index]
if not setmap[value] then
res[#res + 1] = value
end
setmap[value] = true
index = index + 1
end
return res
end
local function array_foreach(array, func)
local index = 1
local length = #array
while index <= length do
func(array[index], index)
index = index + 1
end
end
local function array_reducer(array, func, value)
local index = value and 1 or 2
local length = #array
value = value or array[1]
while index <= length do
value = func(value, array[index], index)
index = index + 1
end
return value
end
local function array_index(array, func, reverse)
func = func or function() return true end
local index, inc, final = 1, 1, #array
if reverse then
index, inc, final = #array, -1, 1
end
repeat
if func(array[index], index) then
return index
end
index = index + inc
until (reverse and index < final) or (not reverse and index > final)
return nil
end
local function array_first(array, func)
local index = array_index(array, func)
if index then
return array[index]
end
return nil
end
local function array_last(array, func)
local index = array_index(array, func, true)
if index then
return array[index]
end
return nil
end
local function array_some(array, func, reverse)
local index, inc, final = 1, 1, #array
if reverse then
index, inc, final = #array, -1, 1
end
repeat
if func(array[index], index) then
return true
end
index = index + inc
until (reverse and index < final) or (not reverse and index > final)
return false
end
local function array_every(array, func)
local index = 1
local length = #array
while index <= length do
if not func(array[index], index) then
return false
end
index = index + 1
end
return true
end
local function array_pipeline(std, array)
local decorator_iterator = function(func) 
return function(self, func2, extra)
self.array = func(self.array, func2, extra)
return self
end
end
local decorator_reduce = function(func, return_self)
return function(self, func2, extra)
local res = func(self.array, func2, extra)
return (return_self and self) or res
end
end
local self = {
array = array,
map = decorator_iterator(array_map),
filter = decorator_iterator(array_filter),
unique = decorator_iterator(array_unique),
each = decorator_reduce(array_foreach, true),
reducer = decorator_reduce(array_reducer),
index = decorator_reduce(array_index),
first = decorator_reduce(array_first),
last = decorator_reduce(array_last),
some = decorator_reduce(array_some),
every = decorator_reduce(array_every),
table = function(self) return self.array end,
json = function(self) return std.json.encode(self.array) end
}
return self
end
local function install(std, engine, library, name)
local lib = std[name] or {}
lib.map = array_map
lib.filter = array_filter
lib.unique = array_unique
lib.each = array_foreach
lib.reducer = array_reducer
lib.index = array_index
lib.first = array_first
lib.last = array_last
lib.some = array_some
lib.every = array_every
lib.from = util_decorator.prefix1(std, array_pipeline)
std[name] = lib
end
local P = {
install = install
}
return P
end
--
source_engine_api_data_encoder_2007c0 = function()
local function install(std, engine, library, name)
std = std or {}
std[name] = {
encode=library.encode,
decode=library.decode
}
return {[name]=std[name]}
end
local P = {
install=install
}
return P
end
--
source_engine_api_data_hash_20ecb8 = function()
local function djb2(digest)
local index = 1
local hash = 5381
while index <= #digest do
local char = string.byte(digest, index)
hash = (hash * 33 + char) % 4294967296
index = index + 1
end
return hash
end
local function install(std, engine, cfg_system)
local id = djb2(cfg_system.get_secret())
std = std or {}
std.hash = std.hash or {}
std.hash.djb2 = djb2
std.hash.fingerprint = function() return id end
end
local P = {
install = install
}
return P
end
--
source_engine_api_data_i18n_24a558 = function()
local language = 'en-US'
local language_default = 'en-US'
local language_list = {}
local language_inverse_list = {}
local translate = {}
local function update_languages(texts)
local index = 1
translate = texts
language_list = {language_default}
language_inverse_list = {[language_default]=1}
repeat
local lang = next(texts)
if lang then
index = index + 1
language_inverse_list[lang] = index
language_list[#language_list + 1] = lang
end
until lang
end
local function get_text(old_text)
local new_text = translate[language] and translate[language][old_text]
return new_text or old_text
end
local function get_language()
return language
end
local function set_language(l)
if language_inverse_list[l] then
language = l
else 
language = language_default
end
end
local function next_language(to)
local index = language_inverse_list[language]
local incr = to or 1
if index then
index = index + incr
if index > #language_list then
index = 1
end
if index <= 0 then
index = #language_list
end
index = index == 0 and 1 or index
set_language(language_list[index])
end
end
local function back_language()
next_language(-1)
end
local function decorator_draw_text(func)
return function (x, y, text, a, b, c)
return func(x, y, get_text(text), a, b, c)
end
end
local function install(std, engine, cfg)
if not (std and std.text and std.text.print) then
error('missing draw text')
end
local old_put = std.text.put
local old_print = std.text.print
local old_print_ex = std.text.print_ex
local callback_lang = function(result)
update_languages(result)
if cfg and cfg.get_language then
set_language(cfg.get_language())
end
end
if not std.node and engine.root.callbacks.i18n then
callback_lang(engine.root.callbacks.i18n())
else
std.bus.listen('ret_i18n', callback_lang)
std.bus.emit_next('i18n')
end
std.text.put = decorator_draw_text(old_put)
std.text.print = decorator_draw_text(old_print)
std.text.print_ex = decorator_draw_text(old_print_ex)
std.i18n = {}
std.i18n.get_text = get_text
std.i18n.get_language = get_language
std.i18n.set_language = set_language
std.i18n.back = back_language
std.i18n.next = next_language
end
local P = {
install=install
}
return P
end
--
source_engine_api_debug_log_210c78 = function()
local util_decorator = source_shared_functional_decorator_1abfc0()
local logging_types = {
'none', 'fatal', 'error', 'warn', 'debug', 'info'
}
local function level(engine, lpf, lpn, level)
local l = lpf[level] or lpn[level] or level
if type(l) ~= 'number' or l <= 0 or l > #logging_types then
error('logging level not exist: '..tostring(level)) 
end
engine.loglevel = l
end
local function init(std, engine, printers)
local index = 1
local level_per_func = {}
local level_per_name = {}
while index <= #logging_types do
local ltype = logging_types[index]
local lfunc = function() end
if index > 1 and printers[ltype] then
lfunc = (function (level)
return function(message)
if engine.loglevel >= level then
printers[ltype](message)
end
end
end)(index - 1)
end
level_per_func[lfunc] = index - 1
level_per_name[ltype] = index - 1
std.log[ltype] = lfunc
index = index + 1
end
std.log.level = util_decorator.prefix3(engine, level_per_func, level_per_name, level)
end
local function install(std, engine, printers)
std.log = std.log or {}
engine.loglevel = #logging_types
std.log.init = util_decorator.prefix2(std, engine, init)
std.log.init(printers)
end
local P = {
install = install
}
return P
end
--
source_engine_api_io_http_24a3c0 = function()
local zeebo_pipeline = source_shared_functional_pipeline_2b3f50()
local function json(self)
self.options['json'] = true
return self
end
local function noforce(self)
self.options['noforce'] = true
return self
end
local function fast(self)
self.speed = '_fast'
return self
end
local function param(self, name, value)
local index = #self.param_list + 1
self.param_list[index] = tostring(name)
self.param_dict[name] = tostring(value)
return self
end
local function header(self, name, value)
local index = #self.header_list + 1
self.header_list[index] = tostring(name)
self.header_dict[name] = tostring(value)
return self
end
local function body(self, content, json_encode)
if type(content) == 'table' then
header(self, 'Content-Type', 'application/json')
content = json_encode(content)
end
self.body_content=content
return self
end
local function success(self, handler_func)
self.success_handler = handler_func
return self
end
local function failed(self, handler_func)
self.failed_handler = handler_func
return self
end
local function http_error(self, handler_func)
self.error_handler = handler_func
return self
end
local function request(method, std, engine, protocol)
local callback_handler = function()
if std.node then
std.node.emit(engine.current, 'http')
elseif engine.current.callbacks.http then
engine.current.callbacks.http(std, engine.current.data)
end
end
return function (url)
if protocol.has_callback then
engine.http_count = engine.http_count + 1
end
local json_encode = std.json and std.json.encode
local json_decode = std.json and std.json.decode
local http_body = function(self, content) return body(self, content, json_encode) end
local game = engine.current.data
local self = {
id = engine.http_count,
url = url,
speed = '',
options = {},
method = method,
body_content = '',
header_list = {},
header_dict = {},
param_list = {},
param_dict = {},
success_handler = function (std, game) end,
failed_handler = function (std, game) end,
error_handler = function (std, game) end,
fast = fast,
json = json,
noforce = noforce,
body = http_body,
param = param,
header = header,
success = success,
failed = failed,
error = http_error,
run = zeebo_pipeline.run,
}
self.promise = function()
zeebo_pipeline.stop(self)
end
self.resolve = function()
zeebo_pipeline.resume(self)
end
self.set = function (key, value)
std.http[key] = value
end
self.pipeline = {
function()
if not protocol.force or self.options['noforce'] then return end
self.url = url:gsub("^[^:]+://", protocol.force.."://")
end,
function()
if protocol.has_callback then engine.http_requests[self.id] = self end
protocol.handler(self, self.id)
end,
function()
if self.options['json'] and json_decode and std.http.body then
pcall(function()
local new_body = json_decode(std.http.body)
std.http.body = new_body
end)
end
end,
function()
callback_handler(std, game)
if std.http.ok then
self.success_handler(std, game)
elseif std.http.error then
self.error_handler(std, game)
elseif not std.http.status then
self.set('error', 'missing protocol response')
self.error_handler(std, game)
else
self.failed_handler(std, game)
end
end,
function ()
std.http.ok = nil
std.http.body = nil
std.http.error = nil
std.http.status = nil
std.http.body_is_table = nil
end,
function()
if protocol.has_callback then engine.http_requests[self.id] = nil end
zeebo_pipeline.reset(self)
end
}
return self
end
end
local function install(std, engine, protocol)
assert(protocol and protocol.handler, 'missing protocol handler')
if protocol.has_callback then
engine.http_count = 0
engine.http_requests = {}
end
std.http = std.http or {}
std.http.get=request('GET', std, engine, protocol)
std.http.head=request('HEAD', std, engine, protocol)
std.http.post=request('POST', std, engine, protocol)
std.http.put=request('PUT', std, engine, protocol)
std.http.delete=request('DELETE', std, engine, protocol)
std.http.patch=request('PATCH', std, engine, protocol)
if protocol.install then
protocol.install(std, engine)
end
end
local P = {
install=install
}
return P
end
--
source_engine_api_io_media_1e9990 = function()
local function media_create(node, channels, handler)
local decorator = function(func)
func = func or function() end
return function(self, a, b, c)
func(0, a, b, c)
return self
end
end
local self = { 
src = decorator(handler.source),
play = decorator(handler.play),
pause = decorator(handler.pause),
resume = decorator(handler.resume),
stop = decorator(handler.stop),
position = decorator(handler.position),
resize = decorator(handler.resize),
in_mutex = handler.mutex or function() return false end,
get_error = handler.error or function() return nil end,
node = node,
apply = function() end
}
return function()
return self
end
end
local function install(std, engine, handler, name)
std.media = std.media or {}
local mediatype = name:match('%w+%.(%w+)')
if handler.install then
handler.install(std, engine, mediatype, name)
end
if not std.media[mediatype] then
local channels = handler.bootstrap and handler.bootstrap(mediatype)
if (not channels or channels == 0) and handler.bootstrap then
error('media '..mediatype..' is not supported!')
end
local node = std.node and std.node.load({})
std.media[mediatype] = media_create(node, channels, handler)
end
end
local P = {
install=install
}
return P
end
--
source_engine_api_io_storage_1cae18 = function()
local zeebo_pipeline = source_shared_functional_pipeline_2b3f50()
local function storage_as(engine, self, name, cast)
if cast == nil then
cast = function(v) return v end
elseif type(cast) ~= 'function' then
local value = cast
cast = function() return value end
end
local node = engine.current
self.callbacks[#self.callbacks + 1] = function(value)
node.data[name] = cast(value)
end
return self
end
local function storage_callback(self, handler)
self.callbacks[#self.callbacks + 1] = handler
return self
end
local function storage_default(self, value)
self.default_value = tostring(value)
return self
end
local function storage_command(cmd, std, engine, handlers)
return function(name, value)
if type(value) == 'table' and std.json then
value = std.json.encode(value)
end
value = tostring(value or '')
local self = {
value = '',
default_value = '',
default = storage_default,
callback = storage_callback,
as = function(a, b, c) return storage_as(engine, a, b, c) end,
run = zeebo_pipeline.run,
callbacks = {}
}
self.promise = function() zeebo_pipeline.stop(self) end
self.resolve = function() zeebo_pipeline.resume(self) end
self.pipeline = {
function()
if cmd == 'set' then
handlers.set(name, value or '',  self.promise, self.resolve)
elseif cmd == 'get' then
local save = function(value) self.value = value end
handlers.get(name, save, self.promise, self.resolve)
end
end,
function()
if type(self.value) ~= 'string' or #self.value == 0 then
self.value = #self.default_value > 0 and self.default_value or nil
end
end,
function()
local index = 1
while index <= #self.callbacks do
self.callbacks[index](self.value)
index = index + 1
end
end
}
return self
end
end
local function install(std, engine, handlers)
if handlers.install then
handlers.install(std, engine)
end
if not handlers.set or not handlers.get then
error('missing handlers')
end
std.storage = std.storage or {}
std.storage.set = storage_command('set', std, engine, handlers)
std.storage.get = storage_command('get', std, engine, handlers)
end
local P = {
install=install
}
return P
end
--
source_engine_api_raw_bus_1caca0 = function()
local ev_prefixes = {
'pre_',
'',
'post_'
}
local buses = {
list = {},
dict = {},
queue = {},
pause = {},
all = {}
}
local must_abort = false
local function abort()
must_abort = true
end
local function emit_next(key, a, b, c, d, e, f)
buses.queue[#buses.queue + 1] = {key, a, b, c, d, e, f}
end
local function emit(prefixes, key, a, b, c, d, e, f)
local index1, index2, index3 = 1, 1, 1
while index1 <= #prefixes do
index2 = 1
local prefix = prefixes[index1]
local topic = prefix..key
local bus = buses.dict[topic]
while not must_abort and bus and index2 <= #bus do
local func = bus[index2]
if not buses.pause[func] then
func(a, b, c, d, e, f)
end
index2 = index2 + 1
end
index3 = 1
while index3 <= #buses.all do
buses.all[index3](topic, a, b, c, d, e, f)
index3 = index3 + 1
end
index1 = index1 + 1
end
must_abort = false
end
local function trigger(key)
return function (a, b, c, d, e, f)
emit(ev_prefixes, key, a, b, c, d, e, f)
end
end
local function listen(key, handler_func)
if not key or not handler_func then return end
if not buses.dict[key] then
buses.list[#buses.list + 1] = key
buses.dict[key] = {}
end
local index = #buses.dict[key] + 1
buses.dict[key][index] = handler_func 
end
local function listen_all(handler_func)
buses.all[#buses.all + 1] = handler_func
end
local function install(std, engine)
std.bus = std.bus or {}
std.bus.abort = abort
std.bus.listen = listen
std.bus.trigger = trigger
std.bus.emit_next = emit_next
std.bus.listen_all = listen_all
engine.bus_emit_ret = function(key, a)
emit({'ret_'}, key, a)
end
std.bus.emit = function(key, a, b, c, d, e, f)
emit(ev_prefixes, key, a, b, c, d, e, f)
end
std.bus.listen_std = function(key, handler_func)
listen(key, function(a, b, c, d, e, f)
handler_func(std, a, b, c, d, e, f)
end)
end
std.bus.listen_std_data = function(key, handler_func)
listen(key, function(a, b, c, d, e, f)
handler_func(std, engine.current.data, a, b, c, d, e, f)
end)
end
std.bus.listen_std_engine = function(key, handler_func)
listen(key, function(a, b, c, d, e, f)
handler_func(std, engine, a, b, c, d, e, f)
end)
end
listen('pre_loop', function()
local index = 1
while index <= #buses.queue do
local pid = buses.queue[index]
emit({''}, pid[1], pid[2], pid[3], pid[4], pid[5], pid[6])
index = index + 1
end
buses.queue = {}
end)
return {
bus=std.bus
}
end
local P = {
install=install
}
return P
end
--
source_engine_api_raw_memory_1d8328 = function()
local memory_dict_unload = {}
local memory_dict = {}
local memory_list = {}
local function cache_get(key)
return memory_dict[key]
end
local function cache_set(key, load_func, unload_func)
local value = load_func()
memory_list[#memory_list + 1] = key
memory_dict_unload[key] = unload_func
memory_dict[key] = value
end
local function cache(key, load_func, unload_func)
local value = cache_get(key)
if value == nil then
cache_set(key, load_func, unload_func)
value = cache_get(key)
end    
return value
end
local function unset(key)
if memory_dict_unload[key] then
memory_dict_unload[key](memory_dict[key])
end
memory_dict[key] = nil
end
local function gc_clear_all()
local index = 1
local items = #memory_list
while index <= items do
unset(memory_list[index])
index = index + 1
end
memory_list = {}
return items
end
local function install(std)
std = std or {}
std.mem = std.mem or {}
std.mem.cache = cache
std.mem.cache_get = cache_get
std.mem.cache_set = cache_set
std.mem.unset = unset
std.mem.gc_clear_all = gc_clear_all
return {
mem=std.mem
}
end
local P = {
install=install
}
return P
end
--
source_engine_api_raw_node_220970 = function()
local loadgame = source_shared_engine_loadgame_1c6ee0()
local node_default = source_shared_var_object_node_1b58d0()
local buses = {
list = {},
inverse_list = {},
pause = {},
}
local function emit(std, application, key, a, b, c, d, e, f)
local callback = application.callbacks[key]
if not buses.pause[key..tostring(application)] and callback then
return callback(std, application.data, a, b, c, d, e, f)
end
return nil
end
local function load(application)
return loadgame.script(application, node_default)
end
local function spawn(engine, application)
if not application or buses.inverse_list[application] then return application end
local depth = 1
local index = #buses.list + 1
buses.list[index] = application
buses.inverse_list[application] = index
if engine.current then
application.config.parent = engine.current
depth = (engine.current.config.depth or 0) + 1
end
application.config.depth = depth
return application
end
local function kill(application)
local index = application and buses.inverse_list[application]
local last_item = #buses.list
while index and index <= last_item do
buses.list[index] = buses.list[index + 1]
index = index + 1
end
if application then
buses.inverse_list[application] = nil
application.config.parent = nil
end
end
local function pause(application, key)
buses.pause[key..tostring(application)] = true
end
local function resume(application, key)
buses.pause[key..tostring(application)] = false
end
local function clear_bus()
local index = 1
while index <= #buses.list do
local application = buses.list[index]
buses.inverse_list[application] = nil
application.config.parent = nil
buses.list[index] = nil
index = index + 1
end
end
local function event_bus(std, engine, key, a, b, c, d, e, f)
local index = 1
local count = 0
local depth = 0
repeat
index = 1
count = 0
depth = depth + 1
while index <= #buses.list do
local application = buses.list[index]
if application.config.depth == depth then
count = count + 1
if engine.current ~= application then
local node = application
local safe_depth = 0
engine.current = application
engine.offset_x = 0
engine.offset_y = 0
while node and safe_depth < 100 do
if safe_depth > 50 then
error('fatal error parent three')
end
engine.offset_x = engine.offset_x + node.config.offset_x
engine.offset_y = engine.offset_y + node.config.offset_y
node = node.config.parent
safe_depth = safe_depth + 1
end
end
local ret = emit(std, application, key, a, b, c, d, e, f)
if ret ~= nil then
engine.bus_emit_ret(key, ret)
end
end
index = index + 1
end
until count == 0
end
local function install(std, engine)
std.node = std.node or {}
std.node.kill = kill
std.node.pause = pause
std.node.resume = resume
std.node.load = load
std.bus.listen('clear_all', clear_bus)
std.node.spawn = function (application)
spawn(engine, application)
end
std.bus.listen_all(function(key, a, b, c, d, e, f)
event_bus(std, engine, key, a, b, c, d, e, f)
end)
std.node.emit = function(application, key, a, b, c, d, e, f)
return emit(std, application, key, a, b, c, e, f)
end
std.node.emit_root = function(key, a, b, c, d, e, f)
return emit(std, engine.root, key, a, b, c, e, f)
end
std.node.emit_parent = function(key, a, b, c, d, e, f)
return emit(std, engine.current.config.parent, key, a, b, c, e, f)
end
end
local P = {
install=install
}
return P
end
--
source_engine_api_system_color_1c65a0 = function()
local function install(std)
std.color = std.color or {}
std.color.white = 0xFFFFFFFF
std.color.lightgray = 0xC8CCCCFF
std.color.gray = 0x828282FF
std.color.darkgray = 0x505050FF
std.color.yellow = 0xFDF900FF
std.color.gold = 0xFFCB00FF
std.color.orange = 0xFFA100FF
std.color.pink = 0xFF6DC2FF
std.color.red = 0xE62937FF
std.color.maroon = 0xBE2137FF
std.color.green = 0x00E430FF
std.color.lime = 0x009E2FFF
std.color.darkgreen = 0x00752CFF
std.color.skyblue = 0x66BFFFFF
std.color.blue = 0x0079F1FF
std.color.darkblue = 0x0052ACFF
std.color.purple = 0xC87AFFFF
std.color.violet = 0x873CBEFF
std.color.darkpurple = 0x701F7EFF
std.color.beige = 0xD3B083FF
std.color.brown = 0x7F6A4FFF
std.color.darkbrown = 0x4C3F2FFF
std.color.black = 0x000000FF
std.color.blank = 0x00000000
std.color.magenta = 0xFF00FFFF
end
local P = {
install = install
}
return P
end
--
source_engine_api_system_app_1d81a8 = function()
local util_decorator = source_shared_functional_decorator_1abfc0()
local function reset(std, engine)
if std.node then
std.bus.emit('exit')
std.bus.emit('init')
else
engine.root.callbacks.exit(std, engine.root.data)
engine.root.callbacks.init(std, engine.root.data)
end
end
local function exit(std)
std.bus.emit('exit')
std.bus.emit('quit')
end
local function title(func, window_name)
if func then
func(window_name)
end
end
local function install(std, engine, config)
std = std or {}
config = config or {}
std.app = std.app or {}
std.bus.listen('post_quit', function()
if config.quit then
config.quit()
end
end)
std.app.title = util_decorator.prefix1(config.set_title, title)
std.app.exit = util_decorator.prefix1(std, exit)
std.app.reset = util_decorator.prefix2(std, engine, reset)
std.app.get_fps = config.get_fps
return std.app
end
local P = {
install=install
}
return P
end
--
source_engine_api_system_key_1d86c0 = function()
local function real_key(std, engine, rkey, rvalue)
local value = rvalue == 1 or rvalue == true
local key = engine.key_bindings[rkey] or (std.key.axis[rkey] and rkey)
if key then
std.key.axis[key] = value and 1 or 0
std.key.press[key] = value
if key == 'right' or key == 'left' then
std.key.axis.x = std.key.axis.right - std.key.axis.left
end
if key == 'down' or key == 'up' then
std.key.axis.y = std.key.axis.down - std.key.axis.up
end
std.bus.emit('key')
end
local a = std.key.axis
std.key.press.any = (a.left + a.right + a.down + a.up + a.a + a.b + a.c + a.d + a.menu) > 0
end
local function real_keydown(std, engine, key)
real_key(std, engine, key, 1)
end
local function real_keyup(std, engine, key)
real_key(std, engine, key, 0)
end
local function install(std, engine, key_bindings)
engine.key_bindings = key_bindings or {}
engine.keyboard = real_key
std.bus.listen_std_engine('rkey', real_key)
std.bus.listen_std_engine('rkey1', real_keydown)
std.bus.listen_std_engine('rkey0', real_keyup)
end
local P = {
install = install
}
return P
end
--
source_engine_api_system_math_2a9c98 = function()
local function abs(value)
if value < 0 then
return -value
end
return value
end
local function clamp(value, value_min, value_max)
if value < value_min then
return value_min
elseif value > value_max then
return value_max
else
return value
end
end
local function clamp2(value, value_min, value_max)
return (value - value_min) % (value_max - value_min + 1) + value_min
end
local function dir(value, alpha)
alpha = alpha or 0
if value < -alpha then
return -1
elseif value > alpha then
return 1
else
return 0
end
end
local function dis(x1,y1,x2,y2)
local sqr = 1/2
return ((x2 - x1) ^ 2 + (y2 - y1) ^ 2) ^ (sqr ~= 0 and sqr or 1)
end
local function dis2(x1,y1,x2,y2)
return (x2 - x1) ^ 2 + (y2 - y1) ^ 2
end
local function dis3(x1,y1,x2,y2)
return abs(x1 - x2) + abs(x2 - y2)
end
local function lerp(a, b, alpha)
return a + alpha * ( b - a )
end 
local function map(value, in_min, in_max, out_min, out_max)
return (value - in_min) * (out_max - out_min) / (in_max - in_min) + out_min
end
local function max(...)
local args = {...}
local index = 1
local value = nil
local max_value = nil
if #args == 1 then
args = args[1]
end
while index <= #args do
value = args[index]
if max_value == nil or value > max_value then
max_value = value
end
index = index + 1
end
return max_value
end
local function min(...)
local args = {...}
local index = 1
local value = nil
local min_value = nil
if #args == 1 then
args = args[1]
end
while index <= #args do
value = args[index]
if min_value == nil or value < min_value then
min_value = value
end
index = index + 1
end
return min_value
end
local function sine(t, freq)
return math.pi and math.sin(2 * math.pi * freq * t) or 1
end
local function ramp(t, freq, ratio)
t = (t / 2) % (1 / freq) * freq
if t < ratio then
return 2 * t / ratio - 1
else
return (2 * t - ratio - 1) / (ratio - 1)
end
end
local function saw(t, freq)
return ramp(t, freq, 1)
end
local function triangle(t, freq)
return ramp(t, freq, 1/2)
end
local function rect(t, freq, duty)
duty = 1 - duty * 2
return saw(t, freq) > duty and 1 or -1
end
local function square(t, freq)
return rect(t, freq, 1/2)
end
local function install(std)
std.math = std.math or {}
std.math.abs=abs
std.math.clamp=clamp
std.math.clamp2=clamp2
std.math.dir=dir
std.math.dis=dis
std.math.dis2=dis2
std.math.dis3=dis3
std.math.lerp=lerp
std.math.map=map
std.math.max=max
std.math.min=min
end
local function install_wave(std)
std.math = std.math or {}
std.math.sine=sine
std.math.saw=saw
std.math.square=square
std.math.triangle=triangle
end
local function install_clib(std)
std.math = std.math or {}
std.math.acos=math.acos
std.math.asin=math.asin
std.math.atan=math.atan
std.math.atan2=math.atan2
std.math.ceil=math.ceil
std.math.cos=math.cos
std.math.cosh=math.cosh
std.math.deg=math.deg
std.math.exp=math.exp
std.math.floor=math.floor
std.math.fmod=math.fmod
std.math.frexp=math.frexp
std.math.huge=math.huge
std.math.ldexp=math.ldexp
std.math.log=math.log
std.math.log10=math.log10
std.math.modf=math.modf
std.math.pi=math.pi
std.math.pow=math.pow
std.math.rad=math.rad
std.math.sin=math.sin
std.math.sinh=math.sinh
std.math.sqrt=math.sqrt
std.math.tan=math.tan
std.math.tanh=math.tanh
end
local function install_clib_random(std)
std.math = std.math or {}
std.math.random = function(a, b)
a = a and math.floor(a)
b = b and math.floor(b)
return math.random(a, b)
end
end
local P = {
install = install,
wave = {
install = install_wave
},
clib = {
install = install_clib
},
clib_random = {
install = install_clib_random
}
}
return P;
end
--
source_engine_protocol_http_callback_10ec00 = function()
local str_http = source_shared_string_encode_http_1cc2f0()
local str_url = source_shared_string_encode_url_1c6918()
local callbacks = {
['async-promise'] = function(self)
return self:promise()
end,
['async-resolve'] = function(self)
return self:resolve()
end,
['get-url'] = function(self)
return self.url
end,
['get-fullurl'] = function(self)
return self.url..str_url.search_param(self.param_list, self.param_dict)
end,
['get-method'] = function(self)
return self.method
end,
['get-body'] = function(self)
return self.body_content
end,
['get-param-count'] = function(self)
return #self.param_list
end,
['get-param-name'] = function(self, data)
return self.param_list[self.data]
end,
['get-param-data'] = function(self, data)
return self.param_dict[self.data] or self.param_dict[self.param_list[self.data]]
end,
['get-header-count'] = function(self)
return #self.header_list
end,
['get-header-name'] = function(self, data)
return self.header_list[self.data]
end,
['get-header-data'] = function(self, data)
return self.heeader_dict[self.data] or self.heeader_dict[self.header_list[self.data]]
end,
['set-status'] = function(self, data)
self.set('status', data)
self.set('ok', str_http.is_ok(data))
end,
['set-error'] = function(self, data)
self.set('error', data)
end,
['set-ok'] = function(self, data)
self.set('ok', data)
end,
['set-body'] = function(self, data)
self.set('body', data)
end,
['add-body-data'] = function(self, data, std)
self.set('body', (std.http.body or '')..data)
end    
}
local function native_http_callback(self, evt, data, std)
if not callbacks[evt] then
error('http evt '..evt..' not exist!')
end
return callbacks[evt](self, data, std)
end
local P = {
func = native_http_callback
}
return P
end
--
source_shared_var_object_root_1dcec8 = function()
local P = {
data={
width=1280,
height=720
},
meta={
id='',
title='',
author='',
company='',
description='',
tizen_package='',
version=''
},
config = {
offset_x = 0,
offset_y = 0,
require = '',
fps_max = 60,
fps_show = 0,
fps_drop = 5,
fps_time = 5
},
callbacks={
}
}
return P;
end
--
source_shared_var_object_std_1d7be8 = function()
local P = {
milis = 0,
delta = 0,
math = {
},
draw = {
image = function() end,
clear = function () end,
color = function () end,
rect = function () end,
line = function () end,
poly = function () end,
tui_text = function() end
},
text = {
put = function() end,
print = function() end,
mensure = function() end,
font_size = function() end,
font_name = function() end,
font_default = function() end
},
image = {
load = function() end,
draw = function() end
},
app = {
width = 1280,
height = 720,
title = function() end,
reset = function () end,
load = function() end,
exit = function () end
},
key = {
axis = {
x = 0,
y = 0,
menu=0,
up=0,
down=0,
left=0,
right=0,
a = 0,
b = 0, 
c = 0,
d = 0
},
press = {
menu=false,
up=false,
down=false,
left=false,
right=false,
a=false,
b=false,
c=false,
d=false,
any=false
}
}
}
return P;
end
--
source_shared_functional_pipeline_2b3f50 = function()
local function pipe(self)
return function()
self:run()
end
end
local function stop(self)
if self.pipeline and not self.pipeline2 then
self.pipeline2 = self.pipeline
self.pipeline = nil
end
end
local function resume(self)
if not self.pipeline and self.pipeline2 then
self.pipeline = self.pipeline2
self.pipeline2 = nil
self:run()
end
end
local function run(self)
self.pipeline_current = self.pipeline_current or 1
while self.pipeline and self.pipeline_current and self.pipeline_current <= #self.pipeline do
self.pipeline[self.pipeline_current]()
if self.pipeline_current then
self.pipeline_current = self.pipeline_current + 1
end
end
return self
end
local function reset(self)
self.pipeline = self.pipeline or self.pipeline2
self.pipeline2 = nil
self.pipeline_current = nil
end
local function clear(self)
self.pipeline_current = nil
self.pipeline2 = nil
self.pipeline = nil
end
local P = {
reset=reset,
clear=clear,
pipe=pipe,
stop=stop,
resume=resume,
run=run
}
return P
end
--
source_shared_string_dsl_requires_1f67b0 = function()
local function encode(dsl_string)
local spec = {
list = {},
required = {},
all = false
}
for entry in (dsl_string or ''):gmatch("[^%s]+") do
if entry == "*" then
spec.all = true
else
local is_optional = entry:sub(-1) == "?"
local name = is_optional and entry:sub(1, -2) or entry
spec.list[#spec.list + 1] = name
spec.required[#spec.required + 1] = not is_optional
end
end
return spec
end
local function missing(spec, imported)
local result = {}
do
local index = 1
while spec.list[index] do
local name = spec.list[index]
if spec.required[index] and not imported[name] then
result[#result + 1] = name
end
index = index + 1
end
end
return result
end
local function should_import(spec, libname)
local index = 1
while spec.list[index] do
if spec.list[index] == libname then return true end
index = index + 1
end
return spec.all
end
local P = {
encode = encode,
missing = missing,
should_import = should_import
}
return P
end
--
source_shared_string_eval_file_29c410 = function()
local function script(src)
local ok, app = false, nil
if require then
ok, app = pcall(require, src:gsub('%.lua$', ''))
end
if not ok and dofile then
ok, app =  pcall(dofile, src)
end
if not ok and loadfile then
ok, app = pcall(loadfile, src)
end
if type(app) == 'function' then
ok, app = pcall(app)
end
if not ok then
return false, 'failed to eval file'
end
return ok, app
end
local P = {
script = script,
}
return P
end
--
source_shared_string_eval_code_21e1f8 = function()
local function script(src)
local loader = loadstring or load
if not loader then
error('eval not allowed')
end
local ok, chunk = pcall(loader, src)
if not ok then
return false, chunk
end
if type(chunk) ~= 'function' then
return false, 'failed to eval code'
end
return pcall(chunk)
end
local P = {
script = script,
}
return P
end
--
source_engine_api_draw_ui_jsx_1e95e8 = function()
local function h(std, engine, element, attribute, ...)
local childs = {...}
local el_type = type(element)
if element == std then
return error
elseif element == std.h then
return nil
elseif element == std.ui then
return childs
elseif element == 'node' then
return std.node.spawn(std.node.load(attribute))
elseif element == 'grid' then
return std.ui.grid(attribute.class):margin(attribute.margin):gap(attribute.gap):add_items(childs):apply().node
elseif el_type == 'function' then
return element(attribute, std)
elseif el_type == 'table' then
return element
else
error('[error] JSX invalid element type: '..el_type)
end
end
local P = {
h = h
}
return P
end
--
source_engine_api_draw_ui_grid_10e628 = function()
local ui_common = source_engine_api_draw_ui_common_1c0450()
local util_decorator = source_shared_functional_decorator_1abfc0()
local function dir(std, engine, self, mode)
self.direction = mode
return self
end
local function apply(std, engine, self)
local index = 1
local x, y = 0, 0
local index2 = 1
local pipeline = std.ui.style(self.classlist).pipeline
while index2 <= #pipeline do
pipeline[index2](std, self.node, self.node.config.parent, engine.root)
index2 = index2 + 1
end
local gap_x, gap_y = self.px_gap, self.px_gap
local offset_x, offset_y = (self.px_margin/2) + (gap_x/2), (self.px_margin/2) + (gap_y/2)
local width = self.node.data.width - self.px_margin
local height = self.node.data.height - self.px_margin
local hem = (width / self.rows) - gap_x
local vem = (height / self.cols) - gap_y
while self.direction == 1 and index <= #self.items_node do
local node = self.items_node[index]
local size = self.items_size[index]
local ui = self.items_ui[node]
node.config.offset_x = offset_x + (x * (hem + gap_x))
node.config.offset_y = offset_y + (y * (vem + gap_y))
node.data.width = hem
node.data.height = size * vem
y = y + size
if y >= self.cols then
x = x + 1
y = 0
end
if ui then
ui:apply()
end
index = index + 1
end    
while self.direction == 0 and index <= #self.items_node do
local node = self.items_node[index]
local size = self.items_size[index]
local ui = self.items_ui[node]
node.config.offset_x = offset_x + (x * (hem + gap_x))
node.config.offset_y = offset_y + (y * (vem + gap_y))
node.data.width = size * hem
node.data.height = vem
x = x + size
if x >= self.rows then
y = y + 1
x = 0
end
if ui then
ui:apply()
end
index = index + 1
end
return self
end
local function component(std, engine, layout)
local rows, cols = layout:match('(%d+)x(%d+)')
local node = std.node.load({
width = engine.current.data.width,
height = engine.current.data.height
})
local self = {
direction=0,
rows=tonumber(rows),
cols=tonumber(cols),
items_node = {},
items_size = {},
items_ui = {},
node=node,
px_gap=0,
px_margin=0,
classlist='',
gap=ui_common.gap,
margin=ui_common.margin,
dir=util_decorator.prefix2(std, engine, dir),
add=util_decorator.prefix2(std, engine, ui_common.add),
add_items=util_decorator.prefix2(std, engine, ui_common.add_items),
style=ui_common.style,
apply=util_decorator.prefix2(std, engine, apply),
get_item=ui_common.get_item
}
if self.rows == 1 and self.cols > 1 then
self.direction = 1
end
if engine.root == engine.current then
node.callbacks.resize = function()
if node.config.parent ~= engine.root then
node.callbacks.resize = nil
return
end
node.data.height = engine.root.data.height
node.data.width = engine.root.data.width
self:apply()
end
end
std.node.spawn(node)
node.config.depth = engine.current.depht
return self
end
local P = {
component = component
}
return P
end
--
source_engine_api_draw_ui_slide_1cab98 = function()
local ui_common = source_engine_api_draw_ui_common_1c0450()
local util_decorator = source_shared_functional_decorator_1abfc0()
local function slider_next(self, to)
local incr = to or 1
self.index = self.index + incr
if self.index == 0 then
self.index = #self.items_node
end
if self.index > #self.items_node then
self.index = 1
end
return self
end
local function slider_back(self)
return slider_next(self, -1)
end
local function apply(std, engine, self)
local index = 1
local x, y = 0, 0
local index2 = 1
local pipeline = std.ui.style(self.classlist).pipeline
while index2 <= #pipeline do
pipeline[index2](std, self.node, self.node.config.parent, engine.root)
index2 = index2 + 1
end
local hem = self.node.data.width / self.rows
local vem = self.node.data.height / self.cols
while index <= #self.items_node do
local node = self.items_node[index]
local size = self.items_size[index]
local ui = self.items_ui[node]
node.config.offset_x = x * hem
node.config.offset_y = y * vem
node.data.width = size * hem
node.data.height = vem
x = x + size
if x >= self.rows then
y = y + 1
x = 0
end
if index == self.index then
local index3 = 1
local pipeline2 = std.ui.style(self.classlist_selected).pipeline
while index3 <= #pipeline2 do
pipeline2[index3](std, node, node.config.parent, engine.root)
index3 = index3 + 1
end
end
if ui then
ui:apply()
end
index = index + 1
end
return self
end
local function component(std, engine, layout)
local rows, cols = layout:match('(%d+)x(%d+)')
if rows ~= '1' and cols ~= '1' then
error('invalid grid layout')
end
local node = std.node.load({
width = engine.current.data.width,
height = engine.current.data.height
})
local self = {
index = 1,
rows=tonumber(rows),
cols=tonumber(cols),
items_node = {},
items_size = {},
items_ui = {},
node=node,
classlist='',
classlist_selected='',
next=slider_next,
back=slider_back,
add=util_decorator.prefix2(std, engine, ui_common.add),
add_items=util_decorator.prefix2(std, engine, ui_common.add_items),
style_item_select=util_decorator.prefix1('classlist_selected', ui_common.style),
style=util_decorator.prefix1('classlist', ui_common.style),
apply=util_decorator.prefix2(std, engine, apply),
get_item=ui_common.get_item
}
if engine.root == engine.current then
node.callbacks.resize = function()
if node.config.parent ~= engine.root then
node.callbacks.resize = nil
return
end
node.data.height = engine.root.data.height
node.data.width = engine.root.data.width
self:apply()
end
end
std.node.spawn(node)
return self
end
local P = {
component = component
}
return P
end
--
source_engine_api_draw_ui_style_296170 = function()
local style = {
list = {},
dict = {}
}
local function decorate_style(namespace, attribute)
return function(self, value)
self.pipeline[#self.pipeline + 1] = function(std, node, parent, root)
local is_func = type(value) == 'function'
node[namespace][attribute] =  is_func and value(std, node, parent, root) or value
end
return self
end
end
local function component(std, engine, classname)
local self = style.dict[classname]
if not self then
self = {
pipeline = {},
width = decorate_style('data', 'width'),
height = decorate_style('data', 'height'),
pos_y = decorate_style('config', 'offset_y'),
pos_x = decorate_style('config', 'offset_x')
}
style.list[#style.list] = classname
style.dict[classname] = self
end
return self
end
local P = {
component = component
}
return P
end
--
source_shared_var_object_node_1b58d0 = function()
local P = {
data={
width=1280,
height=720
},
meta={
},
config = {
offset_x = 0,
offset_y = 0
},
callbacks={
}
}
return P;
end
--
source_shared_string_encode_http_1cc2f0 = function()
local function is_ok(status)
return (status and 200 <= status and status < 300) or false
end
local function is_ok_header(header)
local status = tonumber(header:match('HTTP/%d.%d (%d%d%d)'))
local ok = status and is_ok(status) or false
return ok, status
end
local function is_redirect(status)
return (status and 300 <= status and status < 400) or false
end
local function get_content(response)
local header, body = response:match("^(.-\r\n\r\n)(.*)")
if not header or not body then return nil end
local content_length = tonumber(header:match("Content%-Length:%s*(%d+)"))
if not content_length then return nil end
if #body < content_length then return nil end
local content = body:sub(1, content_length)
return content
end
local function get_user_agent()
return 'Ginga (GlyOS;SmartTv/Linux)'
end
local function create_request(method, uri)
local self = {
body_content = '',
header_list = {},
header_dict = {},
header_imutable = {},
print_http_status = true
}
self.add_body_content = function (body)
self.body_content = self.body_content..(body or '')
return self
end
self.add_imutable_header = function (header, value, cond)
if cond == false then return self end
if self.header_imutable[header] == nil then
self.header_list[#self.header_list + 1] = header
self.header_dict[header] = value
elseif self.header_imutable[header] == false then
self.header_dict[header] = value
end
self.header_imutable[header] = true
return self
end
self.add_mutable_header = function (header, value, cond)
if cond == false then return self end
if self.header_imutable[header] == nil then
self.header_list[#self.header_list + 1] = header
self.header_imutable[header] = false
self.header_dict[header] = value
end
return self
end
self.add_custom_headers = function(header_list, header_dict)
local index = 1
while header_list and #header_list >= index do
local header = header_list[index]
local value = header_dict[header]
if self.header_imutable[header] == nil then
self.header_list[#self.header_list + 1] = header
self.header_imutable[header] = false
self.header_dict[header] = value
elseif self.header_imutable[header] == false then
self.header_dict[header] = value
end
index = index + 1
end
return self
end
self.not_status = function()
self.print_http_status = false
return self
end
self.to_http_protocol = function ()
local index = 1
local request = method..' '..uri..' HTTP/1'..'.1\r\n'
while index <= #self.header_list do
local header = self.header_list[index]
local value = self.header_dict[header]
request = request..header..': '..value..'\r\n'
index = index + 1
end
request = request..'\r\n'
if method ~= 'GET' and method ~= 'HEAD' and #self.body_content > 0 then
request = request..self.body_content..'\r\n\r\n'
end
return request, function() end
end
self.to_curl_cmd = function ()
local index = 1
local request = 'curl -L -'..'-silent -'..'-insecure '
if self.print_http_status then
request = request..'-w "\n%{http_code}" '
end
if method == 'HEAD' then
request = request..'-'..'-HEAD '
else
request = request..'-X '..method..' '
end
while index <= #self.header_list do
local header = self.header_list[index]
local value = self.header_dict[header]
request = request..'-H "'..header..': '..value..'" '
index = index + 1
end
if method ~= 'GET' and method ~= 'HEAD' and #self.body_content > 0 then
request = request..'-d \''..self.body_content..'\' '
end
request = request..uri
return request, function() end
end
self.to_wget_cmd = function ()
local request = 'wget -'..'-quiet -'..'-output-document=-'
if method == 'HEAD' then
request = request..' -'..'-method=HEAD'
elseif method ~= 'GET' then
request = request..' -'..'-method='..method
end
for index, header in ipairs(self.header_list) do
local value = self.header_dict[header]
if value then
local escaped_value = value:gsub('"', '\\"')
request = request..' -'..'-header="'..header..': '..escaped_value..'"'
end
end
if method ~= 'GET' and method ~= 'HEAD' and #self.body_content > 0 then
local escaped_body = self.body_content:gsub('"', '\\"')
request = request..' -'..'-body-data="'..escaped_body..'"'
end
request = request..' '..uri
return request, function() end
end
return self
end
return {
is_ok=is_ok,
is_ok_header=is_ok_header,
is_redirect=is_redirect,
get_content=get_content,
get_user_agent=get_user_agent,
create_request=create_request
}
end
--
source_shared_string_encode_url_1c6918 = function()
local function search_param(param_list, param_dict)
local index, params = 1, ''
while param_list and param_dict and index <= #param_list do
local param = param_list[index]
local value = param_dict[param]
if #params == 0 then
params = params..'?'
else
params = params..'&'
end
params = params..param:gsub(' ', '%20')..'='..(value or ''):gsub(' ', '%20')
index = index + 1
end
return params
end
local P = {
search_param = search_param
}
return P
end
--
source_engine_api_draw_ui_common_1c0450 = function()
local function gap(self, space_between_items)
self.px_gap = space_between_items or 0
return self
end
local function margin(self, space_container)
self.px_margin = space_container or 0
return self
end
local function add(std, engine, self, application, size)
if not application then return self end
local index = #self.items_node + 1
local node = application.node or std.node.load(application.node or application)
std.node.spawn(node)
node.config.parent = self.node
self.items_node[index] = node
self.items_size[index] = size or 1
if application.node then
self.items_ui[application.node] = application
end
return self
end
local function add_items(std, engine, self, applications)
local index = 1
while applications and index <= #applications do
add(std, engine, self, applications[index])
index = index + 1
end
return self
end
local function get_item(self, id)
return self.items_node[id]
end
local function style(classkey, self, classlist)
self[classkey] = classlist
return self
end
local P = {
add=add,
gap=gap,
margin=margin,
style=style,
get_item=get_item,
add_items=add_items,
}
return P
end
--
return main_1c29b8()
