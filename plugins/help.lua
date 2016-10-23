function run(msg, matches)

--------------------------
 local channel = "channel"
 local chat = "chat"
 local type = msg.to.type
 local receiver = get_receiver(msg)
 -------------------------
 
    if matches[1] == "sethelp" then
	    if is_sudo(msg) then
            if type == channel then
	            hash = "help:sp"
				text = matches[2]
			    redis:set(hash, text)
				file = io.open("./data/tmp/HelpSuper.txt", "w")
				file:write(text)
				file:flush()
				file:close()
				send_document(receiver, "./data/tmp/HelpSuper.txt", ok_cb, false)
				return "Help of supergroup has been changed successful!"
			elseif type == chat then
			    hash = "help:gp"
				text = matches[2]
			    redis:set(hash, text)
				file = io.open("./data/tmp/HelpChat.txt", "w")
				file:write(text)
				file:flush()
				file:close()
				send_document(receiver, "./data/tmp/HelpChat.txt", ok_cb, false)
				return "Help of chat has been changed successful!"
			elseif type == "user" then
			    return "Please use /sethelp commands in chat or supergroup!"
		    end
		elseif is_owner(msg) then
		    if is_group(msg) or is_super_group(msg) then
	            hash = "help:"..msg.to.id
				text = matches[2]
			    redis:set(hash, text)
				file = io.open("./data/tmp/HelpOwner.txt", "w")
				file:write(text)
				file:flush()
				file:close()
				send_document(receiver, "./data/tmp/HelpOwner.txt", ok_cb, false)
				return "Help of your group has been changed successful!"
			elseif not is_group(msg) or not is_super_group(msg) then
			    if type == channel then
			        return "SuperGroup is not added!"
				elseif type == chat then
				    return "Group is not added!"
				end
			elseif type == "user" then
			    return "Please use /sethelp commands in your chat or supergroup! (If you are an owner.)"
		    end
		elseif is_momod(msg) or not is_momod(msg) then
		    return "Just for sudo or owner!"
		end
	end
	
	if matches[1] == "help" then
	    if not is_super_group(msg) and type == channel then
		    return "SuperGroup is not added!"
		elseif not is_group(msg) and type == chat then
		    return "Group is not added!"
		end
	    if not is_momod(msg) and msg.to.type ~= "user" then
		    return "You cant see /help text"
		end
	        if type == channel then
		        hash1 = "help:sp"
			    hash2 = "help:"..msg.to.id
		    elseif type == chat then
		        hash1 = "help:gp"
			    hash2 = "help:"..msg.to.id
		    end
			local one = io.open("./system/team", "r")
            local two = io.open("./system/channel", "r")
            local team = one:read("*all")
            local channel = two:read("*all")
			local is_hash1 = redis:get(hash1)
			local is_hash2 = redis:get(hash2)
			if is_hash1 and not is_hash2 then
			    help = redis:get(hash1)
			    return help
		    elseif is_hash1 and is_hash2 then
			    help = redis:get(hash2)
				return help.."\n\n⚡️ [👉 Powered by "..team.." ] ⚡️\n📎 [👉 Join: "..channel.." ]"
			elseif not is_hash1 and is_hash2 then
			    help = redis:get(hash2)
				return help.."\n\n⚡️ [👉 Powered by "..team.." ] ⚡️\n📎 [👉 Join: "..channel.." ]"
			elseif not is_hash1 and not is_hash2 then
			    local error = "Error! help text not found! please use /sethelp (text) or /setlang [en/fa/فا] for fix it."
			    if msg.to.type == "channel" then
				    if not redis:get("sp:lang") then
					    return error
				    elseif redis:get("sp:lang") == "fa" then
					    help = http.request("http://www.folder98.ir/1395/05/1473700489.txt")
						return help
					elseif redis:get("sp:lang") == "en" then
					    help = http.request("http://www.folder98.ir/1395/05/1473726399.txt")
						return help
				    elseif redis:get("sp:lang") == "فا" then
					    help = http.request("http://www.folder98.ir/1395/05/1473703817.txt")
						return help
					end
				elseif msg.to.type == "chat" then
				    if not redis:get("gp:lang") then
					    return error
				    elseif redis:get("gp:lang") == "fa" then
					    help = http.request("http://www.folder98.ir/1395/05/1473685968.txt")
						return help
					elseif redis:get("gp:lang") == "en" then
					    help = http.request("http://www.folder98.ir/1395/05/1473743959.txt")
						return help
				    elseif redis:get("gp:lang") == "فا" then
					    help = http.request("http://www.folder98.ir/1395/05/1473704736.txt")
						return help
					end
				end
			end
	end
	
	if matches[1] == "delhelp" then
	    if is_sudo(msg) then
		    if type == channel then
			    if redis:get("help:sp") then
			        hash = "help:sp"
				    redis:del(hash)
				    return "Help of supergroup has been removed!"
				else
				    return "Error! help not found, please set help text with /sethelp commands."
				end
		    elseif type == chat then
			    if redis:get("help:gp") then
			        hash = "help:gp"
				    redis:del(hash)
				    return "Help of chat has been removed!"
				else
				    return "Error! help not found, please set help text with /sethelp commands."
				end
			end
		elseif is_owner(msg) then
			if type == channel and is_super_group(msg) then
			    if redis:get("help:"..msg.to.id) then
			        hash = "help:"..msg.to.id
			        redis:del(hash)
			        return "Help of your supergroup has been removed!"
				else
				    return "Error! help not found, please set help text with /sethelp commands."
				end
			elseif type == chat and is_group(msg) then
			    if redis:get("help:"..msg.to.id) then
			        hash = "help:"..msg.to.id
			        redis:del(hash)
			        return "Help of your chat has been removed!"
				else
				    return "Error! help not found, please set help text with /sethelp commands."
				end
			end
		elseif not is_momod(msg) then
		    return "You cant remove help text! (Just for sudo)"
		end
	end
end
return {
advan = "http://github.com/janlou/AdvanSource",
patterns = {"^[!#/](help)$","^[!#/]([Ss]ethelp) (.*)$","^[!#/](delhelp)$"},
run = run,
}
