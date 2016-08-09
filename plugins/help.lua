function run(msg, matches)
	
    if is_realm(msg) then
    if is_sudo(msg) or is_vip(msg) then
     return "Realm haven`t help\nRealm is a place for sudo users!"
	end
	end
	
if is_momod(msg) or is_owner(msg) or is_sudo(msg) or is_vip(msg) then
	if matches[1] == "help" then
	if msg.to.type == 'channel' and is_super_group(msg) then
	HelpSuper = io.open("./helps/HelpSuper.txt", "r")
    	help_text_super = HelpSuper:read("*all")
	  return help_text_super
	elseif msg.to.type == 'channel' and not is_super_group(msg) then
	  return "SupreGroup is not added!"
	end
	
    if msg.to.type == 'chat' and is_group(msg) then
	HelpChat = io.open("./helps/HelpChat.txt", "r")
    	help_text = HelpChat:read("*all")
	  return help_text
	 elseif msg.to.type == 'chat' and not is_group(msg) then
	  return "Group is not added!"
	end
	end
elseif not is_momod(msg) or not is_owner(msg) or not is_vip(msg) then
 if is_group(msg) or is_super_group(msg) then
	  return "You cant see /help text"
 end
end

 if msg.to.type == 'channel' and matches[1] == "sethelp" and matches[2] then
    text = matches[2]
    local b = 1
    while b ~= 0 do
    text = text:trim()
    text,b = text:gsub('^!+','')
  end
  file = io.open("./helps/HelpSuper.txt", "w")
  file:write(text)
  file:flush()
  file:close()
  return "HelpSuper text has been changed to:\n"..matches[2]
 end
 if msg.to.type == 'chat' and matches[1] == "sethelp" and matches[2] then
    text = matches[2]
    local b = 1
    while b ~= 0 do
    text = text:trim()
    text,b = text:gsub('^!+','')
  end
  file = io.open("./helps/HelpChat.txt", "w")
  file:write(text)
  file:flush()
  file:close()
  return "HelpChat text has been changed to:\n"..matches[2] 
 end
end
return {
advan = "http://github.com/janlou",
patterns = {"^[!#/](help)$","^[!#/]([Ss]ethelp) (.*)$"},
run = run,
}
