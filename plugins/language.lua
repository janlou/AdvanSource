local function reload_plugins( )
  plugins = {}
  load_plugins()
end

function run(msg, matches)
 if is_sudo(msg) then
 
  if msg.to.type == 'channel' then
 if matches[1] == "setlang" and matches[2] == "fa" then
    redis:set("sp:lang", "fa")
    file = http.request("http://nahrup.ir/view/811/supergroup-fa.txt")
	security = http.request("http://nahrup.ir/view/815/security-fa.txt")
    local b = 1
    while b ~= 0 do
    file = file:trim()
    file,b = file:gsub('^!+','')
	end
	while b ~= 0 do
    security = security:trim()
    security,b = security:gsub('^!+','')
	end
      filea = io.open("./plugins/supergroup.lua", "w")
      filea:write(file)
      filea:flush()
      filea:close()
	  sysa = io.open("./plugins/security.lua", "w")
      sysa:write(security)
      sysa:flush()
      sysa:close()
	  reload_plugins( )
	  return "<i>زبان سوپرگپ با موفقیت به فارسی با دستورات انگلیسی تغییر کرد</i>"
elseif matches[1] == "setlang" and matches[2] == "en" then
    redis:set("sp:lang", "en")
    file = http.request("http://nahrup.ir/view/810/supergroup-en.txt")
	security = http.request("http://nahrup.ir/view/814/security-en.txt")
    local b = 1
    while b ~= 0 do
    file = file:trim()
    file,b = file:gsub('^!+','')
	end
	while b ~= 0 do
    security = security:trim()
    security,b = security:gsub('^!+','')
	end
      fileb = io.open("./plugins/supergroup.lua", "w")
      fileb:write(file)
      fileb:flush()
      fileb:close()
	  sysb = io.open("./plugins/security.lua", "w")
      sysb:write(security)
      sysb:flush()
      sysb:close()
	  reload_plugins( )
	  return "<i>Supergroup language has been changed</i>"
elseif matches[1] == "setlang" and matches[2] == "فا" then
    redis:set("sp:lang", "فا")
    file = http.request("http://nahrup.ir/view/802/supergroup-farsi.txt")
	security = http.request("http://nahrup.ir/view/809/security-farsi.txt")
    local b = 1
    while b ~= 0 do
    file = file:trim()
    file,b = file:gsub('^!+','')
	end
	while b ~= 0 do
    security = security:trim()
    security,b = security:gsub('^!+','')
	end
      filec = io.open("./plugins/supergroup.lua", "w")
      filec:write(file)
      filec:flush()
      filec:close()
	  sysc = io.open("./plugins/security.lua", "w")
      sysc:write(security)
      sysc:flush()
      sysc:close()
	  reload_plugins( )
      return "<i>زبان سوپرگپ با موفقیت به فارسی با دستورات فارسی تغییر کرد</i>"
end
end

if msg.to.type == 'chat' then
 if matches[1] == "setlang" and matches[2] == "fa" then
    redis:set("gp:lang", "fa")
    file = http.request("http://www.folder98.ir/1395/05/1471088420.txt")
    local b = 1
    while b ~= 0 do
    file = file:trim()
    file,b = file:gsub('^!+','')
	end
      filea = io.open("./plugins/ingroup.lua", "w")
      filea:write(file)
      filea:flush()
      filea:close()
	  reload_plugins( )
	 return "<i>زبان گپ معمولی با موفقیت  به فارسی با دستورات انگلیسی تغییر کرد</i>"
 elseif matches[1] == "setlang" and matches[2] == "en" then
    redis:set("gp:lang", "en")
    file = http.request("http://www.folder98.ir/1395/07/1475331538.txt")
    local b = 1
    while b ~= 0 do
    file = file:trim()
    file,b = file:gsub('^!+','')
	end
      fileb = io.open("./plugins/ingroup.lua", "w")
      fileb:write(file)
      fileb:flush()
      fileb:close()
	  reload_plugins( )
	 return "<i>Chat language has been changed</i>"
 elseif matches[1] == "setlang" and matches[2] == "فا" then
    redis:set("gp:lang", "فا")
    file = http.request("http://www.folder98.ir/1395/05/1471124062.txt")
    local b = 1
    while b ~= 0 do
    file = file:trim()
    file,b = file:gsub('^!+','')
	end
      filec = io.open("./plugins/ingroup.lua", "w")
      filec:write(file)
      filec:flush()
      filec:close()
	  reload_plugins( )
       return "<i>زبان گپ معمولی با موفقیت به فارسی با دستورات فارسی تغییر کرد</i>"
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
	   "^[!#/](lang) (list)$",
	   "^[!#/](update)$",
 },
 run = run
}
