local function run(msg, matches)
if matches[1] == "markread" then
    	if matches[2] == "on" then
    		redis:set("bot:markread", "on")
    		return "Mark read > on"
    	end
    	if matches[2] == "off" then
    		redis:del("bot:markread")
    		return "Mark read > off"
    	end
    	return
end
end

return {
  patterns = {
	"^[#!/](markread) (on)$",
	"^[#!/](markread) (off)$",
  },
  run = run,
  pre_process = pre_process
}
