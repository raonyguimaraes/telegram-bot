do

function run(msg, matches)
 local text = msg.text
 local url = "https://static.wiidatabase.de/personal/chatter-bot-api/cleverbot.php?text="..URL.escape(text) --- replace with your url
 local query = https.request(url)
 if query == nil then return 'An error happened :(' end
 local decode = json:decode(query)
 return decode.clever
end


return {
  description = "chat with cleverbot!", 
  usage = "!cbot [text]: chat with cleverbot",
  patterns = {
    "^!cbot (.*)$"
 },
 run = run
}

end
