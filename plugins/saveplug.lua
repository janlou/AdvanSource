local function plugin_enabled( name )
  for k,v in pairs(_config.enabled_plugins) do
    if name == v then
      return k
    end
  end
  return false
end

local function disable_plugin( name, chat )
  local k = plugin_enabled(name)
  if not k then
    return
  end
  table.remove(_config.enabled_plugins, k)
  save_config( )
end

local function enable_plugin( plugin_name )
  if plugin_enabled(plugin_name) then
    return disable_plugin( name, chat )
  end
    table.insert(_config.enabled_plugins, plugin_name)
    save_config()
end

local function plugin_exists( name )
  for k,v in pairs(plugins_names()) do
    if name..'.lua' == v then
      return true
    end
  end
  return false
end
  
local function reload_plugins( )
  plugins = {}
  load_plugins()
end

local function saveplug(extra, success, result)
  local msg = extra.msg
  local name = extra.name
  local receiver = get_receiver(msg)
  if success then
    local file = 'plugins-self/'..name..'.lua'
    print('File saving to:', result)
    os.rename(result, file)
    print('File moved to:', file)
    enable_plugin(name)
    reload_plugins( )
  else
    print('Error downloading: '..msg.id)
    send_large_msg(receiver, 'Failed, please try again!', ok_cb, false)
  end
end
local function run(msg,matches)
    local receiver = get_receiver(msg)
    local group = msg.to.id
    if msg.reply_id then
   local name = matches[2]
      if matches[1] == "save" and matches[2] and is_sudo(msg) then
load_document(msg.reply_id, saveplug, {msg=msg,name=name})
        return 'Plugin '..name..' has been saved.'
    end
end
end
return {
  advan = {
    "Created by: @janlou & @Alirezame",
    "Powered by: @SUDO_TM & @AdvanTM",
    "CopyRight all right reserved",
  },
  patterns = {
   "^[!/#](save) (.*)$",
  },
  run = run,
}

