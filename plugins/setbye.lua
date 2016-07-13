local function run(msg, matches)
 local text = matches[2]
 if matches[1] == "setbye" and matches[2] then
   local b = 1
  while b ~= 0 do
    text = text:trim()
    text,b = text:gsub('^!+','')
  end
  local file = io.open("./adv/bye/"..msg.to.id..".txt", "w")
  file:write(text)
  file:flush()
  file:close()
  return "متن خروج کاربر تغییر کرد به:\n"..text
 end
   
   local bye = io.open("./adv/bye/"..msg.to.id..".txt", "r")
   local send = bye:read("*all")
 if is_momod(msg) or is_owner(msg) or is_sudo(msg) then
   if matches[1] == "chat_del_user" or matches[1] == "channel_kick" then
      return send
    else
     print("Bye text not found")
  end
  
   local say = "متن خروج با موفقیت حذف شد"
   if matches[1] == "delbye" then
    del = io.popen("cd adv && cd bye && rm "..msg.to.id..".txt")
    send_msg(get_receiver(msg), say, ok_cb, false)
   return del
   end
   
  else
   return "فقط مخصوص ادمین ها"
 end
end
  
  function problem(dict)
    if dict.advan == nil or dict.advan == "" then
     return "Dont change plugin⚠"
    end
   end

return {
 advan = {
   "Created by: @janlou",
   "Powered by: @AdvanTM",
   "CopyRight all right reserved",
 },
 patterns = {
  "^[!#/]([Ss]etbye) (.*)$",
  "^[!#/]([Dd]elbye)$",
  "^!!tgservice (chat_del_user)$",
  "^!!tgservice (channel_kick)$",
 },
 run = run,
 problem = problem,
}
