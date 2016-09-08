local function run(msg, matches)
 local text = matches[2]
 if is_momod(msg) or is_owner(msg) or is_sudo(msg) then
 if matches[1] == "setbye" and matches[2] then
  if not is_momod(msg) or not is_owner(msg) or not is_sudo(msg) then
   return "فقط مخصوص ادمین ها"
  end
   local b = 1
  while b ~= 0 do
    text = text:trim()
    text,b = text:gsub('^!+','')
  end
  local file = io.open("./system/chats/logs/"..msg.to.id..".txt", "w")
  file:write(text)
  file:flush()
  file:close()
  return "متن خروج کاربر تغییر کرد به:\n"..text
 end
end
   
   local bye = io.open("./system/chats/logs/"..msg.to.id..".txt", "r")
   local send = bye:read("*all")
   if matches[1] == "chat_del_user" or matches[1] == "channel_kick" or matches[1] == "kick_user" then
      return send
   end
   
  if is_momod(msg) or is_owner(msg) or is_sudo(msg) then
   local say = "متن خروج با موفقیت حذف شد"
   if matches[1] == "delbye" then
    del = io.popen("cd system/chats/logs && rm "..msg.to.id..".txt")
    send_msg(get_receiver(msg), say, ok_cb, false)
   return del
   end
   
  elseif not is_momod(msg) or not is_owner(msg) or not is_sudo(msg) then
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
  "^!!tgservice (kick_user)$",
 },
 run = run,
 problem = problem,
}
