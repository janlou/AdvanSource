local function reload_plugins( )
  plugins = {}
  load_plugins()
end

function run(msg, matches)
 if is_sudo(msg) then
    
	local hash = "auto:help"
	if msg.text:match("^[!#/](auto) (help)$") then
	 if not redis:get(hash) then
	   redis:set(hash, "on")
	   return "Auto help is on"
	 elseif redis:get(hash) ~= "on" then
	   redis:set(hash, "on")
	   return "Auto help is on"
	 elseif redis:get(hash) == "on" then
	   redis:set(hash, "off")
	   return "Auto help is off"
	 end
	end
  if msg.to.type == 'channel' then
 if matches[1] == "setlang" and matches[2] == "fa" then
    file = http.request("http://www.folder98.ir/1395/05/1473920656.txt")
    local b = 1
    while b ~= 0 do
    file = file:trim()
    file,b = file:gsub('^!+','')
	end
	 if not redis:get(hash) or redis:get(hash) == "off"  then
      filea = io.open("./plugins/supergroup.lua", "w")
      filea:write(file)
      filea:flush()
      filea:close()
	  reload_plugins( )
	  return "<i>زبان سوپرگپ با موفقیت به فارسی با دستورات انگلیسی تغییر کرد</i>"
	 elseif redis:get(hash) == "on" then
	 help = http.request("http://www.folder98.ir/1395/05/1473700489.txt")
      local b = 1
      while b ~= 0 do
       help = help:trim()
       help,b = help:gsub('^!+','')
	  end
	  filea1 = io.open("./plugins/supergroup.lua", "w")
      filea1:write(file)
      filea1:flush()
      filea1:close()
	  filea2 = io.open("./helps/HelpSuper.txt", "w")
      filea2:write(help)
      filea2:flush()
      filea2:close()
	  reload_plugins( )
	 return "<i>زبان سوپرگپ با موفقیت به فارسی با دستورات انگلیسی تغییر کرد +متن راهنما</i>"
	 end
elseif matches[1] == "setlang" and matches[2] == "en" then
    file = http.request("http://www.folder98.ir/1395/05/1473933837.txt")
    local b = 1
    while b ~= 0 do
    file = file:trim()
    file,b = file:gsub('^!+','')
	end
	 if not redis:get(hash) or redis:get(hash) == "off"  then
      fileb = io.open("./plugins/supergroup.lua", "w")
      fileb:write(file)
      fileb:flush()
      fileb:close()
	  reload_plugins( )
	  return "Supergroup language has been changed"
	 elseif redis:get(hash) == "on" then
	 help = http.request("http://www.folder98.ir/1395/05/1473726399.txt")
      local b = 1
      while b ~= 0 do
       help = help:trim()
       help,b = help:gsub('^!+','')
	  end
	  fileb1 = io.open("./plugins/supergroup.lua", "w")
      fileb1:write(file)
      fileb1:flush()
      fileb1:close()
	  fileb2 = io.open("./helps/HelpSuper.txt", "w")
      fileb2:write(help)
      fileb2:flush()
      fileb2:close()
	  reload_plugins( )
	  return "<i>Supergroup language has been changed +help text</i>"
	 end
elseif matches[1] == "setlang" and matches[2] == "فا" then
    file = http.request("http://www.folder98.ir/1395/05/1473882636.txt")
    local b = 1
    while b ~= 0 do
    file = file:trim()
    file,b = file:gsub('^!+','')
	end
	 if not redis:get(hash) or redis:get(hash) == "off"  then
      filec = io.open("./plugins/supergroup.lua", "w")
      filec:write(file)
      filec:flush()
      filec:close()
	  reload_plugins( )
      return "<i>زبان سوپرگپ با موفقیت به فارسی با دستورات فارسی تغییر کرد</i>"
	 elseif redis:get(hash) == "on" then
	 help = http.request("http://www.folder98.ir/1395/05/1473703817.txt")
      local b = 1
      while b ~= 0 do
       help = help:trim()
       help,b = help:gsub('^!+','')
	  end
	  filec1 = io.open("./plugins/supergroup.lua", "w")
      filec1:write(file)
      filec1:flush()
      filec1:close()
	  filec2 = io.open("./helps/HelpSuper.txt", "w")
      filec2:write(help)
      filec2:flush()
      filec2:close()
	  reload_plugins( )
	  return "زبان سوپرگپ با موفقیت به فارسی با دستورات فارسی تغییر کرد +متن راهنما"
	 end
end
end

if msg.to.type == 'chat' then
 if matches[1] == "setlang" and matches[2] == "fa" then
    file = http.request("http://www.folder98.ir/1395/05/1471088420.txt")
    local b = 1
    while b ~= 0 do
    file = file:trim()
    file,b = file:gsub('^!+','')
	end
	 if not redis:get(hash) or redis:get(hash) == "off"  then
      filea = io.open("./plugins/ingroup.lua", "w")
      filea:write(file)
      filea:flush()
      filea:close()
	  reload_plugins( )
	 return "زبان گپ معمولی با موفقیت  به فارسی با دستورات انگلیسی تغییر کرد"
	 elseif redis:get(hash) == "on" then
	 help = http.request("http://www.folder98.ir/1395/05/1473685968.txt")
      local b = 1
      while b ~= 0 do
       help = help:trim()
       help,b = help:gsub('^!+','')
	  end
	  filea1 = io.open("./plugins/ingroup.lua", "w")
      filea1:write(file)
      filea1:flush()
      filea1:close()
	  filea2 = io.open("./helps/HelpChat.txt", "w")
      filea2:write(help)
      filea2:flush()
      filea2:close()
	  reload_plugins( )
	  return "زبان گپ معمولی با موفقیت  به فارسی با دستورات انگلیسی تغییر کرد +متن راهنما"
	 end
 elseif matches[1] == "setlang" and matches[2] == "en" then
    file = http.request("http://www.folder98.ir/1395/05/1473661138.txt")
    local b = 1
    while b ~= 0 do
    file = file:trim()
    file,b = file:gsub('^!+','')
	end
	 if not redis:get(hash) or redis:get(hash) == "off"  then
      fileb = io.open("./plugins/ingroup.lua", "w")
      fileb:write(file)
      fileb:flush()
      fileb:close()
	  reload_plugins( )
	 return "Chat language has been changed"
	 elseif redis:get(hash) == "on" then
	 help = http.request("http://www.folder98.ir/1395/05/1473743959.txt")
      local b = 1
      while b ~= 0 do
       help = help:trim()
       help,b = help:gsub('^!+','')
	  end
	  fileb1 = io.open("./plugins/ingroup.lua", "w")
      fileb1:write(file)
      fileb1:flush()
      fileb1:close()
	  fileb2 = io.open("./helps/HelpChat.txt", "w")
      fileb2:write(help)
      fileb2:flush()
      fileb2:close()
	  reload_plugins( )
	  return "Chat language has been changed +help text"
	 end
 elseif matches[1] == "setlang" and matches[2] == "فا" then
    file = http.request("http://www.folder98.ir/1395/05/1471124062.txt")
    local b = 1
    while b ~= 0 do
    file = file:trim()
    file,b = file:gsub('^!+','')
	end
	 if not redis:get(hash) or redis:get(hash) == "off"  then
      filec = io.open("./plugins/ingroup.lua", "w")
      filec:write(file)
      filec:flush()
      filec:close()
	  reload_plugins( )
       return "زبان گپ معمولی با موفقیت به فارسی با دستورات فارسی تغییر کرد"
	 elseif redis:get(hash) == "on" then
	 help = http.request("http://www.folder98.ir/1395/05/1473704736.txt")
      local b = 1
      while b ~= 0 do
       help = help:trim()
       help,b = help:gsub('^!+','')
	  end
	  filec1 = io.open("./plugins/ingroup.lua", "w")
      filec1:write(file)
      filec1:flush()
      filec1:close()
	  filec2 = io.open("./helps/HelpChat.txt", "w")
      filec2:write(help)
      filec2:flush()
      filec2:close()
	  reload_plugins( )
	  return "زبان گپ معمولی با موفقیت به فارسی با دستورات فارسی تغییر کرد +متن راهنما"
	 end
end
 end

 if matches[1] == "update" then
  txt = "Updated!"
  send_msg(get_receiver(msg), txt, ok_cb, false)
  return reload_plugins( )
 end
 if matches[1] == "lang" and matches[2] == "list" then
 	return [[
List of language:
 	
⚓️ !setlang en
Change language to English
 	
⚓️ !setlang fa
تغییر زبان به فارسی با دستورات انگلیسی
 	
⚓️ !setlang فا
تغییر زبان به فارسی با دستورات فارسی
 	
⚓️ !auto help 
on/off auto set help
]]
end
  elseif not is_sudo(msg) then
 return "You cant change language (just for sudo!)"
end
end
 return {
 advan = {
 "Created by: @janlou",
 "Powered by: @AdvanTm",
 "CopyRight all right reserved",
 },
 patterns = {
    "^[!#/](setlang) (fa)$",
	   "^[!#/](setlang) (en)$",
	   "^[!#/](setlang) (فا)$",
	   "^[!#/](auto) (help)$",
	   "^[!#/](lang) (list)$",
	   "^[!#/](update)$",
 },
 run = run
}
