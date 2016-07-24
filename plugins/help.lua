function run(msg, matches)
	
    if is_realm(msg) then
    if is_sudo(msg) or is_vip(msg) then
     return "Realm haven`t help\nRealm is a place for sudo users!"
	end
	end
	
if is_momod(msg) or is_owner(msg) or is_sudo(msg) or is_vip(msg) then
	if matches[1] == "help" then
	if msg.to.type == 'channel' then
	HelpSuper = io.open("./helps/HelpSuper.txt", "r")
    	help_text_super = HelpSuper:read("*all")
	  return help_text_super
	end
	
    if msg.to.type == 'chat' then
	HelpChat = io.open("./helps/HelpChat.txt", "r")
    	help_text = HelpChat:read("*all")
	  return help_text
	end
	end
 elseif not is_momod(msg) or not is_owner(msg) or not is_vip(msg) then
	  return "You cant see /help text"
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
