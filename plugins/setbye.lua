local function run(msg, matches)
 local text = matches[2]
 if is_momod(msg) then
 if matches[1] == "setbye" and matches[2] then
  if not is_momod(msg) then
   return "فقط مخصوص ادمین ها"
  end
   redis:set("bye:"..msg.to.id, text)
  return "متن خروج کاربر تغییر کرد به:\n"..text
 end
end
   
   if matches[1] == "chat_del_user" or matches[1] == "channel_kick" or matches[1] == "kick_user" then
      send = redis:get("bye:"..msg.to.id)
      if send then
      return send
      elseif not send then
      return
      end
   end
   
  if is_momod(msg) or is_owner(msg) or is_sudo(msg) then
   local say = "متن خروج با موفقیت حذف شد"
   if matches[1] == "delbye" then
       if redis:get("bye:"..msg.to.id) then
          redis:del("bye:"..msg.to.id)
          send_msg(get_receiver(msg), say, ok_cb, false)
       else
          return "متن خروج کاربر تنظیم نشده است"
       end
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
