--Begin security.lua
--Prerequisite:
    local function isABotBadWay (user)
      local username = user.username or ''
      return username:match("[Bb]ot$")
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
	--Prerequisite.
--Begin pre_process function
local function pre_process(msg)
-- Begin 'RondoMsgChecks' text checks by @rondoozle and Edited by @janlou
-- Powered by @AdvanTeam
-- CopyRight all right reserved
if is_chat_msg(msg) or is_super_group(msg) then
	local data = load_data(_config.moderation.data)
	local print_name = user_print_name(msg.from):gsub("‮", "") -- get rid of rtl in names
	local name_log = print_name:gsub("_", " ") -- name for log
	local to_chat = msg.to.type == 'chat'
	local to_super = msg.to.type == 'channel'
	if data[tostring(msg.to.id)] and data[tostring(msg.to.id)]['settings'] then
		settings = data[tostring(msg.to.id)]['settings']
	else
		return
	end
	if settings.lock_arabic then
		lock_arabic = settings.lock_arabic
	else
		lock_arabic = 'no'
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
			local is_link_msg = msg.text:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Mm][Ee]/") or msg.text:match("[Tt][Ll][Gg][Rr][Mm].[Mm][Ee]/") or msg.text:match("^([https?://w]*.?telegram.me/joinchat/%S+)$") or msg.text:match("[Hh][Tt][Tt][Pp][Ss]://(.*)") or msg.text:match("[Hh][Tt][Tt][Pp]://(.*)") or msg.text:match("(.*)(.[([Cc][Oo][Mm])([Ii][Rr])([Nn][Ee][Tt])([Oo][Rr][Gg])([Ii][Oo])([Cc][Ff])([Cc][Oo])])")
			local is_bot = msg.text:match("?[Ss][Tt][Aa][Rr][Tt]=")
			if is_link_msg and lock_link == "yes" and not is_bot then
				delete_msg(msg.id, ok_cb, false)
				delete_msg(msg.id, ok_cb, false)
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
			local is_squig_msg = msg.text:match("[\216-\219][\128-\191]")
			if is_squig_msg and lock_arabic == "yes" then
				delete_msg(msg.id, ok_cb, false)
				if strict == "yes" or to_chat then
					kick_user(msg.from.id, msg.to.id)
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
				local is_link_title = msg.media.title:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Mm][Ee]/") or msg.media.title:match("[Tt][Ll][Gg][Rr][Mm].[Mm][Ee]/")
				if is_link_title and lock_link == "yes" then
					delete_msg(msg.id, ok_cb, false)
					delete_msg(msg.id, ok_cb, false)
					delete_msg(msg.id, ok_cb, false)
					if strict == "yes" or to_chat then
						kick_user(msg.from.id, msg.to.id)
					end
				end
				local is_squig_title = msg.media.title:match("[\216-\219][\128-\191]")
				if is_squig_title and lock_arabic == "yes" then
					delete_msg(msg.id, ok_cb, false)
					if strict == "yes" or to_chat then
						kick_user(msg.from.id, msg.to.id)
					end
				end
			end
			if msg.media.description then
				local is_link_desc = msg.media.description:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Mm][Ee]/") or msg.media.description:match("[Tt][Ll][Gg][Rr][Mm].[Mm][Ee]/")
				if is_link_desc and lock_link == "yes" then
					delete_msg(msg.id, ok_cb, false)
					if strict == "yes" or to_chat then
						kick_user(msg.from.id, msg.to.id)
					end
				end
				local is_squig_desc = msg.media.description:match("[\216-\219][\128-\191]")
				if is_squig_desc and lock_arabic == "yes" then
					delete_msg(msg.id, ok_cb, false)
					if strict == "yes" or to_chat then
						kick_user(msg.from.id, msg.to.id)
					end
				end
			end
			if msg.media.caption then -- msg.media.caption checks
				local is_link_caption = msg.media.caption:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Mm][Ee]/") or msg.media.caption:match("[Tt][Ll][Gg][Rr][Mm].[Mm][Ee]/") or msg.media.caption:match("@[ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz][_ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz][_ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz][_ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz][ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz]")
				if is_link_caption and lock_link == "yes" then
					delete_msg(msg.id, ok_cb, false)
					if strict == "yes" or to_chat then
						kick_user(msg.from.id, msg.to.id)
					end
				end
				local is_squig_caption = msg.media.caption:match("[\216-\219][\128-\191]")
					if is_squig_caption and lock_arabic == "yes" then
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
				local is_link_title = msg.fwd_from.title:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Mm][Ee]/") or msg.fwd_from.title:match("[Tt][Ll][Gg][Rr][Mm].[Mm][Ee]/")
				if is_link_title and lock_link == "yes" then
					delete_msg(msg.id, ok_cb, false)
					if strict == "yes" or to_chat then
						kick_user(msg.from.id, msg.to.id)
					end
				end
				local is_squig_title = msg.fwd_from.title:match("[\216-\219][\128-\191]")
				if is_squig_title and lock_arabic == "yes" then
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
            --[[if msg.text:match("@[ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz][_ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz][_ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz][_ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz][ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz]") then
	            if lock_link == 'yes' then
	                if msg.to.type == 'channel' then
	                    if strict == 'no' then
		                  delete_msg(msg.id, ok_cb, false)
		                elseif strict == 'yes' then
		                  delete_msg(msg.id, ok_cb, false)
		                  kick_user(msg.from.id, msg.to.id)
		                end
		            end
		              if msg.to.type == 'chat' then
		                 kick_user(msg.from.id, msg.to.id)
	                  end
		        end
            end]]
   if msg.text:match("/[Ss][Tt][Aa][Rr][Tt]") then
		if msg.to.type == "user" then
			return "Hello dear ["..msg.from.print_name.."], welcome to "..msg.to.print_name.."\nThanks for /start me :)\n"
	    end
    end
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
	if is_chat_msg(msg) or is_super_group(msg) then
	receiver = get_receiver(msg)
	user = "user"
	chat =  "chat"
	channel = "channel"
		local data = load_data(_config.moderation.data)
		if data[tostring(msg.to.id)] then
        if data[tostring(msg.to.id)]['settings'] then
		if data[tostring(msg.to.id)]['settings']['lock_media'] then
	        lock_media = data[tostring(msg.to.id)]['settings']['lock_media']
        end
		if data[tostring(msg.to.id)]['settings']['lock_number'] then
	        lock_number = data[tostring(msg.to.id)]['settings']['lock_number']
	    end
		if data[tostring(msg.to.id)]['settings']['lock_poker'] then
	        lock_poker = data[tostring(msg.to.id)]['settings']['lock_poker']
	    end
		if data[tostring(msg.to.id)]['settings']['lock_tag'] then
	        lock_tag = data[tostring(msg.to.id)]['settings']['lock_tag']
        end
		if data[tostring(msg.to.id)]['settings']['lock_fwd'] then
	        lock_fwd = data[tostring(msg.to.id)]['settings']['lock_fwd']
	    end
	    if data[tostring(msg.to.id)]['settings']['lock_reply'] then
	        lock_reply = data[tostring(msg.to.id)]['settings']['lock_reply']
	    end
	    if data[tostring(msg.to.id)]['settings']['lock_share'] then
	        lock_share = data[tostring(msg.to.id)]['settings']['lock_share']
	    end
        if data[tostring(msg.to.id)]['settings']['lock_bots'] then
	        lock_bots = data[tostring(msg.to.id)]['settings']['lock_bots']
	    end
		if data[tostring(msg.to.id)]['settings']['lock_inline'] then
	        lock_inline = data[tostring(msg.to.id)]['settings']['lock_inline']
	    end
		if data[tostring(msg.to.id)]['settings']['strict'] then
	        lock_strict = data[tostring(msg.to.id)]['settings']['strict']
	    end
		if data[tostring(msg.to.id)]['settings']['lock_cmd'] then
	        lock_cmd = data[tostring(msg.to.id)]['settings']['lock_cmd']
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
                    if lock_strict == "no" then
				        delete_msg(msg.id, ok_cb, true)
				    elseif lock_strict == "yes" then
						delete_msg(msg.id, ok_cb, true)
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
                    if lock_strict == "no" then
				        delete_msg(msg.id, ok_cb, true)
				    elseif lock_strict == "yes" then
						delete_msg(msg.id, ok_cb, true)
			            kick_user(msg.from.id, msg.to.id)
				    end
		        end
            end
		end
			--Number lock.
			--Poker lock:
		if msg.text:match("😐") then
            if lock_poker == "yes" then
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
			--Poker lock.
			--Tag lock:
	    if msg.text:match("#") then
            if lock_tag == "yes" then
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
					    if lock_strict == "no" then
				            delete_msg(msg.id, ok_cb, true)
						elseif lock_strict == "yes" then
						    delete_msg(msg.id, ok_cb, true)
			                kick_user(msg.from.id, msg.to.id)
						end
					end
				end
			end
			--Inline lock.
		end
	
            --Fwd lock:
		if msg.fwd_from then
            if redis:get('fwd:'..msg.to.id) then
                if lock_strict == "no" then
				    delete_msg(msg.id, ok_cb, true)
		        elseif lock_strict == "yes" then
				    delete_msg(msg.id, ok_cb, true)
			        kick_user(msg.from.id, msg.to.id)
			    end
			end
        end
            --Fwd lock.
            --Reply lock:
		if msg.reply_id then
            if redis:get('reply:'..msg.to.id) then
                if lock_strict == "no" then
				    delete_msg(msg.id, ok_cb, true)
		        elseif lock_strict == "yes" then
				    delete_msg(msg.id, ok_cb, true)
			        kick_user(msg.from.id, msg.to.id)
			    end
			end
        end
            --Reply lock.
			--Cmd Lock:
	    if msg.text:match("^[/#!](.*)$") and lock_cmd == "yes" then
            if lock_strict == "no" then
				delete_msg(msg.id, ok_cb, true)
		    elseif lock_strict == "yes" then
				delete_msg(msg.id, ok_cb, true)
			    kick_user(msg.from.id, msg.to.id)
			end
		return false
        end
			--Cmd Lock.
-- End 'RondoMsgChecks' text checks by @Rondoozle
   end
   end
   if msg.text:match("^[!/#][Aa][Dd][Vv][Aa][Nn]$") then
    	txt = _config.about_text
    	send_msg(get_receiver(msg), txt, ok_cb, false)
    end
	return msg
end
--End pre_process function
return {
	patterns = {},
	pre_process = pre_process,
}
--End security.lua
--By @Rondoozle
