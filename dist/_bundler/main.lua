local version = require('source_version')
local util_decorator = require('source_shared_functional_decorator')
local loadcore = require('source_shared_engine_loadcore')
local loadgame = require('source_shared_engine_loadgame')
--
local engine_draw_fps = require('source_engine_api_draw_fps')
local engine_draw_poly = require('source_engine_api_draw_poly')
local engine_draw_text = require('source_engine_api_draw_text')
local engine_draw_ui = require('source_engine_api_draw_ui')
local engine_array = require('source_engine_api_data_array')
local engine_encoder = require('source_engine_api_data_encoder')
local engine_hash = require('source_engine_api_data_hash')
local engine_i18n = require('source_engine_api_data_i18n')
local engine_log = require('source_engine_api_debug_log')
local engine_http = require('source_engine_api_io_http')
local engine_media = require('source_engine_api_io_media')
local engine_storage = require('source_engine_api_io_storage')
local engine_raw_bus = require('source_engine_api_raw_bus')
local engine_raw_memory = require('source_engine_api_raw_memory')
local engine_raw_node = require('source_engine_api_raw_node')
local engine_color = require('source_engine_api_system_color')
local engine_game = require('source_engine_api_system_app')
local engine_key = require('source_engine_api_system_key')
local engine_math = require('source_engine_api_system_math')
--
local callback_http = require('source_engine_protocol_http_callback')
--
local application_default = require('source_shared_var_object_root')
local std = require('source_shared_var_object_std')
--
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
