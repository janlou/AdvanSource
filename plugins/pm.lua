function run(msg, matches)
  if is_sudo(msg) or is_vip(msg) then
if matches[1] == "pm" then
    	local text = "Message From "..(msg.from.username or msg.from.last_name).."\n\nMessage : "..matches[3]
    	send_large_msg("user#id"..matches[2],text)
    	return "Message has been sent"
end
end
end
return {
  patterns = {
	"^[#!/](pm) (%d+) (.*)$",
  },
  run = run,
  pre_process = pre_process
}
