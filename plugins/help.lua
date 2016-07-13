function run(msg, matches)
	
    if is_realm(msg) and is_sudo(msg) then
   	HelpRealm = io.open("./helps/HelpRealm.txt", "r")
    	help_text_realm = HelpRealm:read("*all")
	  return help_text_realm
	end

if is_momod(msg) or is_owner(msg) or is_sudo(msg) then
	
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
	
 elseif not is_momod(msg) or not is_owner(msg) then
	  return "You cant see /help text"
end
	
end
return {
advan = "http://github.com/janlou",
patterns = {"^[!#/](help)$"},
run = run,
}
