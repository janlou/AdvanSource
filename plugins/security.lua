--Begin security.lua
--Prerequisite:
    local function isABotBadWay (user)
      local username = user.username or ''
      return username:match("bot$")
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
  
  local function kickUser(userId, chatId)
  local chat = 'chat#id'..chatId
  local user = 'user#id'..userId
  chat_del_user(chat, user, function (data, success, result)
    if success ~= 1 then
    end
  end, {chat=chat, user=user})
end
	--Prerequisite.
--Begin pre_process function
local function pre_process(msg)
-- Begin 'RondoMsgChecks' text checks by @rondoozle and Edited by @janlou
-- Powered by @AdvanTeam & CopyRight all right reserved
if is_chat_msg(msg) or is_super_group(msg) then
	local data = load_data(_config.moderation.data)
	local print_name = user_print_name(msg.from):gsub("‮", "") -- get rid of rtl in names
	local name_log = print_name:gsub("_", " ") -- name for log
	local to_chat = msg.to.type == 'chat'
	local to_super = msg.to.type == 'channel'
	local receiver = get_receiver(msg)
	local user = "user"
	local chat =  "chat"
	local channel = "channel"
	if data[tostring(msg.to.id)] and data[tostring(msg.to.id)]['settings'] then
		settings = data[tostring(msg.to.id)]['settings']
	else
		return
	end
	if settings.lock_rtl then
		lock_rtl = settings.lock_rtl
	else
		lock_rtl = 'no'
	end
		if settings.lock_tgservice then
		lock_tgservice = settings.lock_tgservice
	else
		lock_tgservice = 'no'
	end
	if settings.lock_link then
		lock_link = settings.lock_link
	else
		lock_link = 'no'
	end
	if settings.lock_member then
		lock_member = settings.lock_member
	else
		lock_member = 'no'
	end
	if settings.lock_spam then
		lock_spam = settings.lock_spam
	else
		lock_spam = 'no'
	end
	if settings.lock_sticker then
		lock_sticker = settings.lock_sticker
	else
		lock_sticker = 'no'
	end
	if settings.lock_contacts then
		lock_contacts = settings.lock_contacts
	else
		lock_contacts = 'no'
	end
	if settings.strict then
		strict = settings.strict
	else
		strict = 'no'
	end
	if settings.lock_media then
		lock_media = settings.lock_media
	else
		lock_media = 'no'
	end
	if settings.lock_number then
		lock_number = settings.lock_number
	else
		lock_number = 'no'
	end
	if settings.lock_poker then
		lock_poker = settings.lock_poker
	else
		lock_poker = 'no'
	end
	if settings.lock_tag then
		lock_tag = settings.lock_tag
	else
		lock_tag = 'no'
	end
	if settings.lock_fwd then
		lock_fwd = settings.lock_fwd
	else
		lock_fwd = 'no'
	end
	if settings.lock_reply then
		lock_reply = settings.lock_reply
	else
		lock_reply = 'no'
	end
	if settings.lock_share then
		lock_share = settings.lock_share
	else
		lock_share = 'no'
	end
	if settings.lock_bots then
		lock_bots = settings.lock_bots
	else
		lock_bots = 'no'
	end
	if settings.lock_inline then
		lock_inline = settings.lock_inline
	else
		lock_inline = 'no'
	end
	if settings.lock_cmd then
		lock_cmd = settings.lock_cmd
	else
		lock_cmd = 'no'
	end
	if not is_momod(msg) and not is_whitelisted(msg.from.id) then --if regular user
		if msg and not msg.service and is_muted(msg.to.id, 'All: yes') or is_muted_user(msg.to.id, msg.from.id) and not msg.service then
			delete_msg(msg.id, ok_cb, false)
			if to_chat then
			--	kick_user(msg.from.id, msg.to.id)
			end
		end
		if msg.text then -- msg.text checks
			local _nl, ctrl_chars = string.gsub(msg.text, '%c', '')
			 local _nl, real_digits = string.gsub(msg.text, '%d', '')
			if lock_spam == "yes" and string.len(msg.text) > 2049 or ctrl_chars > 40 or real_digits > 2000 then
				delete_msg(msg.id, ok_cb, false)
				if strict == "yes" or to_chat then
					delete_msg(msg.id, ok_cb, false)
					kick_user(msg.from.id, msg.to.id)
				end
			end
			local is_link_msg = msg.text:match("[Hh][Tt][Tt][Pp]://[Tt].[Mm][Ee]/") or msg.text:match("[Tt].[Mm][Ee]") or msg.text:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Mm][Ee]/") or msg.text:match("[Tt][Ll][Gg][Rr][Mm].[Mm][Ee]/") or msg.text:match("^([https?://w]*.?telegram.me/joinchat/%S+)$") or msg.text:match("[Hh][Tt][Tt][Pp][Ss]://(.*)") or msg.text:match("[Hh][Tt][Tt][Pp]://(.*)")
			local is_bot = msg.text:match("?[Ss][Tt][Aa][Rr][Tt]=")
			if is_link_msg and lock_link == "yes" and not is_bot then
				delete_msg(msg.id, ok_cb, false)
				if strict == "yes" or to_chat then
					kick_user(msg.from.id, msg.to.id)
				end
            end
		if msg.service then 
			if lock_tgservice == "yes" then
				delete_msg(msg.id, ok_cb, false)
				if to_chat then
					return
				end
			end
		end
			local print_name = msg.from.print_name
			local is_rtl = print_name:match("‮") or msg.text:match("‮")
			if is_rtl and lock_rtl == "yes" then
				delete_msg(msg.id, ok_cb, false)
				if strict == "yes" or to_chat then
					kick_user(msg.from.id, msg.to.id)
				end
			end
			if is_muted(msg.to.id, "Text: yes") and msg.text and not msg.media and not msg.service then
				delete_msg(msg.id, ok_cb, false)
				if to_chat then
					kick_user(msg.from.id, msg.to.id)
				end
			end
		end
		if msg.media then -- msg.media checks
			if msg.media.title then
				local is_link_title = msg.media.title:match("[Hh][Tt][Tt][Pp]://[Tt].[Mm][Ee]/") or msg.media.title:match("[Tt].[Mm][Ee]") or msg.media.title:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Mm][Ee]/") or msg.media.title:match("[Tt][Ll][Gg][Rr][Mm].[Mm][Ee]/")
				if is_link_title and lock_link == "yes" then
					delete_msg(msg.id, ok_cb, false)
					delete_msg(msg.id, ok_cb, false)
					delete_msg(msg.id, ok_cb, false)
					if strict == "yes" or to_chat then
						kick_user(msg.from.id, msg.to.id)
					end
				end
			end
			if msg.media.description then
				local is_link_desc = msg.media.description:match("[Hh][Tt][Tt][Pp]://[Tt].[Mm][Ee]/") or msg.media.description:match("[Tt].[Mm][Ee]") or msg.media.description:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Mm][Ee]/") or msg.media.description:match("[Tt][Ll][Gg][Rr][Mm].[Mm][Ee]/")
				if is_link_desc and lock_link == "yes" then
					delete_msg(msg.id, ok_cb, false)
					if strict == "yes" or to_chat then
						kick_user(msg.from.id, msg.to.id)
					end
				end
			end
			if msg.media.caption then -- msg.media.caption checks
				local is_link_caption = msg.media.caption:match("[Hh][Tt][Tt][Pp]://[Tt].[Mm][Ee]/") or msg.media.caption:match("[Tt].[Mm][Ee]") or msg.media.caption:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Mm][Ee]/") or msg.media.caption:match("[Tt][Ll][Gg][Rr][Mm].[Mm][Ee]/")
				if is_link_caption and lock_link == "yes" then
					delete_msg(msg.id, ok_cb, false)
					if strict == "yes" or to_chat then
						kick_user(msg.from.id, msg.to.id)
					end
				end
				local is_username_caption = msg.media.caption:match("^@[%a%d]")
				if is_username_caption and lock_link == "yes" then
					delete_msg(msg.id, ok_cb, false)
					if strict == "yes" or to_chat then
						kick_user(msg.from.id, msg.to.id)
					end
				end
				if lock_sticker == "yes" and msg.media.caption:match("sticker.webp") then
					delete_msg(msg.id, ok_cb, false)
					if strict == "yes" or to_chat then
						kick_user(msg.from.id, msg.to.id)
					end
				end
			end
			if msg.media.type:match("contact") and lock_contacts == "yes" then
				delete_msg(msg.id, ok_cb, false)
				if strict == "yes" or to_chat then
					kick_user(msg.from.id, msg.to.id)
				end
			end
			local is_photo_caption =  msg.media.caption and msg.media.caption:match("photo")--".jpg",
			if is_muted(msg.to.id, 'Photo: yes') and msg.media.type:match("photo") or is_photo_caption and not msg.service then
				delete_msg(msg.id, ok_cb, false)
				if strict == "yes" or to_chat then
					--	kick_user(msg.from.id, msg.to.id)
				end
			end
			local is_gif_caption =  msg.media.caption and msg.media.caption:match(".mp4")
			if is_muted(msg.to.id, 'Gifs: yes') and is_gif_caption and msg.media.type:match("document") and not msg.service then
				delete_msg(msg.id, ok_cb, false)
				if strict == "yes" or to_chat then
					--	kick_user(msg.from.id, msg.to.id)
				end
			end
			if is_muted(msg.to.id, 'Audio: yes') and msg.media.type:match("audio") and not msg.service then
				delete_msg(msg.id, ok_cb, false)
				if strict == "yes" or to_chat then
					kick_user(msg.from.id, msg.to.id)
				end
			end
			local is_video_caption = msg.media.caption and msg.media.caption:lower(".mp4","video")
			if  is_muted(msg.to.id, 'Video: yes') and msg.media.type:match("video") and not msg.service then
				delete_msg(msg.id, ok_cb, false)
				if strict == "yes" or to_chat then
					kick_user(msg.from.id, msg.to.id)
				end
			end
			if is_muted(msg.to.id, 'Documents: yes') and msg.media.type:match("document") and not msg.service then
				delete_msg(msg.id, ok_cb, false)
				if strict == "yes" or to_chat then
					kick_user(msg.from.id, msg.to.id)
				end
			end
		end
		if msg.fwd_from then
			if msg.fwd_from.title then
				local is_link_title = msg.fwd_from.title:match("[Hh][Tt][Tt][Pp]://[Tt].[Mm][Ee]/") or msg.fwd_from.title:match("[Tt].[Mm][Ee]") or msg.fwd_from.title:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Mm][Ee]/") or msg.fwd_from.title:match("[Tt][Ll][Gg][Rr][Mm].[Mm][Ee]/")
				if is_link_title and lock_link == "yes" then
					delete_msg(msg.id, ok_cb, false)
					if strict == "yes" or to_chat then
						kick_user(msg.from.id, msg.to.id)
					end
				end
			end
			if is_muted_user(msg.to.id, msg.fwd_from.peer_id) then
				delete_msg(msg.id, ok_cb, false)
			end
		end
		if msg.service then -- msg.service checks
		local action = msg.action.type
			if action == 'chat_add_user_link' then
				local user_id = msg.from.id
				local _nl, ctrl_chars = string.gsub(msg.text, '%c', '')
				if string.len(msg.from.print_name) > 70 or ctrl_chars > 40 and lock_group_spam == 'yes' then
					delete_msg(msg.id, ok_cb, false)
					if strict == "yes" or to_chat then
						kick_user(msg.from.id, msg.to.id)
					end
				end
				local print_name = msg.from.print_name
				local is_rtl_name = print_name:match("‮")
				if is_rtl_name and lock_rtl == "yes" then
					kick_user(user_id, msg.to.id)
				end
				if lock_member == 'yes' then
					kick_user(user_id, msg.to.id)
					delete_msg(msg.id, ok_cb, false)
				end
			end
			if action == 'chat_add_user' and not is_momod2(msg.from.id, msg.to.id) then
				local user_id = msg.action.user.id
				if string.len(msg.action.user.print_name) > 70 and lock_group_spam == 'yes' then
					delete_msg(msg.id, ok_cb, false)
					if strict == "yes" or to_chat then
						delete_msg(msg.id, ok_cb, false)
						kick_user(msg.from.id, msg.to.id)
					end
				end
				local print_name = msg.action.user.print_name
				local is_rtl_name = print_name:match("‮")
				if is_rtl_name and lock_rtl == "yes" then
					kick_user(user_id, msg.to.id)
				end
				if msg.to.type == 'channel' and lock_member == 'yes' then
					kick_user(user_id, msg.to.id)
					delete_msg(msg.id, ok_cb, false)
				end
			end
		end
		    --Media lock:
		if msg.text:match("%[(photo)%]") or msg.text:match("%[(video)%]") or msg.text:match("%[(document)%]") or msg.text:match("%[(gif)%]") or msg.text:match("%[(unsupported)%]") or msg.text:match("%[(audio)%]") then
            if lock_media == "yes" then
		        if msg.to.type == channel then
                    if lock_strict == "no" then
				        delete_msg(msg.id, ok_cb, true)
				    elseif lock_strict == "yes" then
						delete_msg(msg.id, ok_cb, true)
			            kick_user(msg.from.id, msg.to.id)
				    end
		        end
            end
		end
	        --Media lock.
			--Share lock:
		if msg.text:match("%[(contact)%]") then
            if lock_share == "yes" then
		        if msg.to.type == channel then
				    delete_msg(msg.id, ok_cb, true)
                    if lock_strict == "yes" then
			            kick_user(msg.from.id, msg.to.id)
				    end
		        end
            end
		end
			--Share lock.
	        --Number lock:
		if msg.text:match("%d+") then
            if lock_number == "yes" then
		        if msg.to.type == channel then
				    delete_msg(msg.id, ok_cb, true)
                    if lock_strict == "yes" then
			            kick_user(msg.from.id, msg.to.id)
				    end
		        end
            end
		end
			--Number lock.
			--Poker lock:
		if msg.text:match("😐") then
            if lock_poker == "yes" then
			    delete_msg(msg.id, ok_cb, true)
                if lock_strict == "yes" then
			        kick_user(msg.from.id, msg.to.id)
				end
            end
		end
			--Poker lock.
			--Tag lock:
	    if msg.text:match("#") then
            if lock_tag == "yes" then
		        delete_msg(msg.id, ok_cb, true)
				if lock_strict == "yes" then
			        kick_user(msg.from.id, msg.to.id)
				end
            end
		end
			--Tag lock.
			--Bots lock:
	    if msg.text:match("^!!tgservice (chat_add_user)$") or msg.text:match("^!!tgservice (chat_add_user_link)$") then
		    if lock_bots == "yes" then
                local user = msg.action.user or msg.from
                if isABotBadWay(user) then
                    userId = user.id
			        chatId = msg.to.id
		            if msg.to.type == channel then
                        kickUser("user#id"..userId, "channel#id"..chatId)
                        channel_kick_user("channel#id"..msg.to.id, 'user#id'..userId, ok_cb, false)
		            end
                end
		    end
        end
			--Bots lock.
			--Inline lock:
			if msg.text == "[unsupported]" then
			    if msg.to.type == channel then
			        if lock_inline == "yes" then
					    delete_msg(msg.id, ok_cb, true)
					    if lock_strict == "yes" then
			                kick_user(msg.from.id, msg.to.id)
						end
					end
				end
			end
			--Inline lock.	
            --Fwd lock:
		if msg.fwd_from then
		if msg.media or not msg.media then
            if redis:get('fwd:'..msg.to.id) then
			    delete_msg(msg.id, ok_cb, true)
                if lock_strict == "yes" then
			        kick_user(msg.from.id, msg.to.id)
			    end
			end
		end
        end
            --Fwd lock.
            --Reply lock:
		if msg.reply_id then
            if redis:get('reply:'..msg.to.id) then
			    delete_msg(msg.id, ok_cb, true)
                if lock_strict == "yes" then
			        kick_user(msg.from.id, msg.to.id)
			    end
			end
        end
            --Reply lock.
			--Cmd Lock:
	    if msg.text:match("^[/#!](.*)$") and lock_cmd == "yes" then
			delete_msg(msg.id, ok_cb, true)
		    if lock_strict == "yes" then
			    kick_user(msg.from.id, msg.to.id)
			end
		return false
        end
			--Cmd Lock.
end
-- End 'RondoMsgChecks' text checks by @Rondoozle
   end
	return msg
end
--End pre_process function
return {
	patterns = {},
	pre_process = pre_process,
}
--End security.lua By @Rondoozle
