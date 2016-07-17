local function reload_plugins( )
  plugins = {}
  load_plugins()
end

function run(msg, matches)
 if is_sudo(msg) then
 if matches[1] == "setlang" and matches[2] == "fa" then
    file1 = io.open("./langs/supergroup-fa", "r")
   	local send1 = file1:read("*all")
    local b = 1
    while b ~= 0 do
    send1 = send1:trim()
    send1,b = send1:gsub('^!+','')
	end
      filea = io.open("./plugins/supergroup.lua", "w")
      filea:write(send1)
      filea:flush()
      filea:close()
	 return "زبان سوپرگپ با موفقیت تغییر کرد\nبرای اعمال تغییرات از دستور زیر استفاده کنید:\n!update"
 elseif matches[1] == "setlang" and matches[2] == "en" then
    file2 = io.open("./langs/supergroup-en", "r")
    local send2 = file2:read("*all")
    local b = 1
    while b ~= 0 do
    send2 = send2:trim()
    send2,b = send2:gsub('^!+','')
	end
      fileb = io.open("./plugins/supergroup.lua", "w")
      fileb:write(send2)
      fileb:flush()
      fileb:close()
	 return "Supergroup language has been changed\nFor the change of commands please use:\n!update"
 end
 if matches[1] == "update" then
  txt = "Updated!"
  send_msg("channel#id"..msg.to.id, txt, ok_cb, false)
  send_msg("chat#id"..msg.to.id, txt, ok_cb, false)
  return reload_plugins( )
 end
 
  if matches[1] == "help" and matches[2] == "fa" then
    file1 = io.open("./langs/help-fa", "r")
   	local send1 = file1:read("*all")
    local b = 1
    while b ~= 0 do
    send1 = send1:trim()
    send1,b = send1:gsub('^!+','')
	end
      filea = io.open("./helps/HelpSuper.txt", "w")
      filea:write(send1)
      filea:flush()
      filea:close()
	 return "زبان هلپ ربات در سوپرگپ تغییر کرد"
 elseif matches[1] == "help" and matches[2] == "en" then
    file2 = io.open("./langs/help-en", "r")
    local send2 = file2:read("*all")
    local b = 1
    while b ~= 0 do
    send2 = send2:trim()
    send2,b = send2:gsub('^!+','')
	end
      fileb = io.open("./helps/HelpSuper.txt", "w")
      fileb:write(send2)
      fileb:flush()
      fileb:close()
	 return "Language of help in supergroup has been changed"
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
	   "^[!#/](help) (fa)$",
	   "^[!#/](help) (en)$",
	   "^[!#/](update)$",
 },
 run = run
 }
