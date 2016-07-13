local function run(msg, matches)
 local text = matches[2]
 if matches[1] == "note" and matches[2] then
   local b = 1
  while b ~= 0 do
    text = text:trim()
    text,b = text:gsub('^!+','')
  end
  local file = io.open("./adv/note/"..msg.from.id..".txt", "w")
  file:write(text)
  file:flush()
  file:close()
  return "You can use it:\n!mynote\n\nYour note has been changed to:\n"..text
 end
   
   local note = io.open("./adv/note/"..msg.from.id..".txt", "r")
   local mn = note:read("*all")
   if matches[1] == "mynote" then
      return mn
    else
     return "You havent any note."
  end
end

return {
 description = "a plugin for save your note! and see it!",
 usage = {
  "!note [text] : save note",
  "!mynote : show your note",
 },
 advan = {
   "Created by: @janlou",
   "Powered by: @AdvanTM",
   "CopyRight all right reserved",
 },
 patterns = {
  "^[!#/]([Nn]ote) (.*)$",
  "^[!#/]([Mm]ynote)$",
 },
 run = run,
 problem = problem,
}
