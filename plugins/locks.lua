--Start locks.lua by @janlou
--Prerequisite:
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

local function lock_group_operator(msg, data, target)
  if not is_momod(msg) then
    return
  end
  local group_operator_lock = data[tostring(target)]['settings']['lock_operator']
  if group_operator_lock == 'yes' then
    return 'operator posting is already locked'
  else
    data[tostring(target)]['settings']['lock_operator'] = 'yes'
    save_data(_config.moderation.data, data)
    return 'operator posting has been locked'
  end
end

local function unlock_group_operator(msg, data, target)
  if not is_momod(msg) then
    return
  end
  local group_operator_lock = data[tostring(target)]['settings']['lock_operator']
  if group_operator_lock == 'no' then
    return 'operator posting is not locked'
  else
    data[tostring(target)]['settings']['lock_operator'] = 'no'
    save_data(_config.moderation.data, data)
    return 'operator posting has been unlocked'
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

    local function isABotBadWay (user)
      local username = user.username or ''
      return username:match("[Bb]ot$")
    end
	--Prerequisite.
local function run(msg, matches)
	
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
    if data[tostring(msg.to.id)]['settings']['lock_fwd'] then
	 lock_fwd = data[tostring(msg.to.id)]['settings']['lock_fwd']
	end
	if data[tostring(msg.to.id)]['settings']['lock_reply'] then
	 lock_reply = data[tostring(msg.to.id)]['settings']['lock_reply']
	end
	if data[tostring(msg.to.id)]['settings']['lock_share'] then
	 lock_share = data[tostring(msg.to.id)]['settings']['lock_share']
	end
	if data[tostring(msg.to.id)]['settings']['lock_tag'] then
	 lock_tag = data[tostring(msg.to.id)]['settings']['lock_tag']
    end
    if data[tostring(msg.to.id)]['settings']['lock_bots'] then
	 lock_bots = data[tostring(msg.to.id)]['settings']['lock_bots']
	end
	if data[tostring(msg.to.id)]['settings']['lock_number'] then
	 lock_number = data[tostring(msg.to.id)]['settings']['lock_number']
	end
	if data[tostring(msg.to.id)]['settings']['lock_operator'] then
	 lock_operator = data[tostring(msg.to.id)]['settings']['lock_operator']
	end
	if data[tostring(msg.to.id)]['settings']['lock_poker'] then
	 lock_poker = data[tostring(msg.to.id)]['settings']['lock_poker']
	end
	end
	end
		
    if is_chat_msg(msg) or is_super_group(msg) then
	    if not is_momod(msg) and not is_whitelisted(msg.from.id) and not is_sudo(msg) and not is_owner(msg) and not is_admin1(msg) then
            --Media lock:
		 if matches[1]:lower() == "photo" or "document" or "video" or "audio" or "unsupported" or "gif" then
          if lock_media == "yes" then
		   if msg.to.type == channel then
           delete_msg(msg.id, ok_cb, true)
		   end
          end
		 end
	        --Media lock.
			--Share lock:
		 if matches[1]:lower() == "contact" then
          if lock_share == "yes" then
		   if msg.to.type == channel then
           delete_msg(msg.id, ok_cb, true)
		   end
          end
		 end
			--Share lock.
			--Tag lock:
	     if msg.text:match("#") then
          if lock_tag == "yes" then
		   if msg.to.type == channel then
           delete_msg(msg.id, ok_cb, true)
		   end
          end
		 end
			--Tag lock.
			--Bots lock:
	     if matches[1] == "chat_add_user" or matches[1] == "chat_add_user_link" then
		  if lock_bots == "yes" then
             local user = msg.action.user or msg.from
           if isABotBadWay(user) then
              userId = user.id
			  chatId = msg.to.id
		     if msg.to.type == channel then
              kickUser("user#id"..userId, "channel#id"..chatId)
              channel_kick_user("channel#id"..msg.to.id, 'user#id'..userId, ok_cb, false)
		   --elseif msg.to.type == chat then
		      --chat_del_user(userId, chatId)
		     end
           end
		  end
         end
			--Bots lock.
			--Number lock:
		 if msg.text:match("^%d+$") then
          if lock_number == "yes" then
		   if msg.to.type == channel then
           delete_msg(msg.id, ok_cb, true)
		   end
          end
		 end
			--Number lock.
			--Operator lock:
	     if matches[1]:lower() == "شارژ" or "ایرانسل" or "irancell" or "ir-mci" or "همراه اول" or "رایتل" or "تالیا" then
          if lock_operator == "yes" then
		   if msg.to.type == channel then
           delete_msg(msg.id, ok_cb, true)
		   end
          end
		 end
			--Operator lock.
			--Poker lock:
		 if msg.text:match("😐") then
          if lock_poker == "yes" then
		   if msg.to.type == channel then
           delete_msg(msg.id, ok_cb, true)
		   end
          end
		 end
			--Poker lock.
		end
	--Lock or Unlock settings:
	if is_momod(msg) or is_sudo(msg) or is_owner(msg) or is_admin1(msg) then
	    if matches[1] == 'lock' then
			local target = msg.to.id
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
			if matches[2] == 'operator' then
				return lock_group_operator(msg, data, target)
			end
			if matches[2] == 'poker' then
				return lock_group_poker(msg, data, target)
			end
        end
		
		if matches[1] == 'unlock' then
			local target = msg.to.id
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
			if matches[2] == 'operator' then
				return unlock_group_operator(msg, data, target)
			end
			if matches[2] == 'poker' then
				return unlock_group_poker(msg, data, target)
			end
        end
	end
	--Lock or Unlock settings.
    end
end
    --pre_process plugins:
local function pre_process(msg)
    
    --Fwd lock:
    hash = 'fwd:'..msg.to.id
    if redis:get(hash) and msg.fwd_from and not is_sudo(msg) and not is_owner(msg) and not is_momod(msg) and not is_admin1(msg)  then
            delete_msg(msg.id, ok_cb, true)
            return
        end
    --Fwd lock.
    --Reply lock:
    hash2 = 'reply:'..msg.to.id
    if redis:get(hash2) and msg.reply_id and not is_sudo(msg) and not is_owner(msg) and not is_momod(msg) and not is_admin1(msg) then
            delete_msg(msg.id, ok_cb, true)
            return
        end
    --Reply lock.
    
        return msg
    end
    --pre_process plugins.
--Finish locks.lua

return {
  advan = {
  "Created by @janlou",
  "Powered by @AdvanTm",
  "CopyRight all right reserved",
  },
  patterns = {
"😐",
"(شارژ)",
"(ایرانسل)",
"(irancell)",
"(ir-mci)",
"(همراه اول)",
"(رایتل)",
"(تالیا)",
"#",
"^%d+$",
"^[!/#](lock) (.*)$",
"^[!/#](unlock) (.*)$",
"%[(photo)%]",
"%[(document)%]",
"%[(video)%]",
"%[(audio)%]",
"%[(unsupported)%]",
"%[(gif)%]",
"%[(contact)%]",
"^!!tgservice (chat_add_user)$",
"^!!tgservice (chat_add_user_link)$",
  },
    run = run,
    pre_process = pre_process,
    moderation = true
}
