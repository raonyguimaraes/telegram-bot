do

local BASE_URL = 'http://api.giphy.com/v1'
local API_KEY = 'dc6zaTOxFJmzC' -- public beta key

local function get_image(response)
  local images = json:decode(response).data
  if #images == 0 then return nil end -- No images
  local i = math.random(#images)
  local image =  images[i] -- A random one

  if image.images.downsized then
    return image.images.downsized.url
  end

  if image.images.original then
    return image.original.url
  end

  return nil
end

local function get_random_top()
  local url = BASE_URL.."/gifs/trending?api_key="..API_KEY
  local response, code = http.request(url)
  if code ~= 200 then return nil end
  return get_image(response)
end

local function search(text)
  text = URL.escape(text)
  local url = BASE_URL.."/gifs/search?q=weed&api_key="..API_KEY
  local response, code = http.request(url)
  if code ~= 200 then return nil end
  return get_image(response)
end

local function run(msg, matches)
  local text = matches[1]
  local b = 1

  while b ~= 0 do
    text = text:trim()
    text,b = text:gsub('^!+','')
  end
  -- add image
  gif_url = search(matches[1])
  local receiver = get_receiver(msg)
  print("GIF URL"..gif_url)
  send_document_from_url(receiver, gif_url)
  return "puf puf puf ... (passa a bola) ..."
end

return {
  description = "Simplest plugin ever!",
  patterns = { "^(.*)[Pp][Yy][Hh][Ee][Mm][Pp](.*)$" },
  run = run 
}

end