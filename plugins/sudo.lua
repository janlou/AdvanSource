do

local function create_group(msg)
     -- superuser and admins only (because sudo are always has privilege)
    if is_sudo(msg) or is_realm(msg) and is_admin1(msg) then
		local group_creator = msg.from.print_name
		create_group_chat (group_creator, group_name, ok_cb, false)
		return 'Group [ '..string.gsub(group_name, '_', ' ')..' ] has been created.'
	end
end

local function create_realm(msg)
        -- superuser and admins only (because sudo are always has privilege)
	if is_sudo(msg) or is_realm(msg) and is_admin1(msg) then
		local group_creator = msg.from.print_name
		create_group_chat (group_creator, group_name, ok_cb, false)
		return 'Realm [ '..string.gsub(group_name, '_', ' ')..' ] has been created.'
	end
end


local function killchat(cb_extra, success, result)
  local receiver = cb_extra.receiver
  local chat_id = "chat#id"..result.peer_id
  local chatname = result.print_name
  for k,v in pairs(result.members) do
    kick_user_any(v.peer_id, result.peer_id)
  end
end

local function killrealm(cb_extra, success, result)
  local receiver = cb_extra.receiver
  local chat_id = "chat#id"..result.peer_id
  local chatname = result.print_name
  for k,v in pairs(result.members) do
    kick_user_any(v.peer_id, result.peer_id)
  end
end

function run(msg, matches)

if matches[1] == 'creategroup' and matches[2] then
        group_name = matches[2]
        group_type = 'group'
        return create_group(msg)
end

if matches[1] == 'createsuper' and matches[2] then
	if not is_sudo(msg) or is_admin1(msg) and is_realm(msg) then
		return "You cant create groups!"
	end
        group_name = matches[2]
        group_type = 'super_group'
        return create_group(msg)
    end
    
 if matches[1] == 'createrealm' and matches[2] then
			if not is_sudo(msg) then
				return "Sudo users only !"
			end
        group_name = matches[2]
        group_type = 'realm'
        return create_realm(msg)
end

if matches[1] == 'kill' and matches[2] == 'chat' and matches[3] then
			if not is_admin1(msg) then
				return
			end
			if is_realm(msg) then
				local receiver = 'chat#id'..matches[3]
				return modrem(msg),
				print("Closing Group: "..receiver),
				chat_info(receiver, killchat, {receiver=receiver})
			else
				return 'Error: Group '..matches[3]..' not found'
			end
		end
		if matches[1] == 'kill' and matches[2] == 'realm' and matches[3] then
			if not is_admin1(msg) then
				return
			end
			if is_realm(msg) then
				local receiver = 'chat#id'..matches[3]
				return realmrem(msg),
				print("Closing realm: "..receiver),
				chat_info(receiver, killrealm, {receiver=receiver})
			else
				return 'Error: Realm '..matches[3]..' not found'
			end
		end
		if matches[1] == 'rem' and matches[2] then
			-- Group configuration removal
			data[tostring(matches[2])] = nil
			save_data(_config.moderation.data, data)
			local groups = 'groups'
			if not data[tostring(groups)] then
				data[tostring(groups)] = nil
				save_data(_config.moderation.data, data)
			end
			data[tostring(groups)][tostring(matches[2])] = nil
			save_data(_config.moderation.data, data)
			send_large_msg(receiver, 'Chat '..matches[2]..' removed')
end

if matches[1] == 'addadmin' then
		    if not is_sudo(msg) then-- Sudo only
				return
			end
			if string.match(matches[2], '^%d+$') then
				local admin_id = matches[2]
				print("user "..admin_id.." has been promoted as admin")
				return admin_promote(msg, admin_id)
			else
			  local member = string.gsub(matches[2], "@", "")
				local mod_cmd = "addadmin"
				chat_info(receiver, username_id, {mod_cmd= mod_cmd, receiver=receiver, member=member})
			end
		end
		if matches[1] == 'removeadmin' then
		    if not is_sudo(msg) then-- Sudo only
				return
			end
			if string.match(matches[2], '^%d+$') then
				local admin_id = matches[2]
				print("user "..admin_id.." has been demoted")
				return admin_demote(msg, admin_id)
			else
			local member = string.gsub(matches[2], "@", "")
				local mod_cmd = "removeadmin"
				chat_info(receiver, username_id, {mod_cmd= mod_cmd, receiver=receiver, member=member})
			end
end
end

return {
  patterns = {
    "^[#!/](creategroup) (.*)$",
  	"^[#!/](createsuper) (.*)$",
    "^[#!/](createrealm) (.*)$",
    "^[#!/](kill) (chat) (%d+)$",
    "^[#!/](kill) (realm) (%d+)$",
   	"^[#!/](rem) (%d+)$",
    "^[#!/](addadmin) (.*)$",
    "^[#!/](removeadmin) (.*)$",
    "^!!tgservice (.+)$",
  },
  run = run
}
end
