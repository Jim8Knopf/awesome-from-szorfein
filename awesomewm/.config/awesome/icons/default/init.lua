local p = os.getenv("HOME") .. "/.config/awesome/icons/default/"
local icons = {}
local icon_name = {
  "tor_on",
  "tor_off",
  "tor_start",
  "tor_stop",
  "tor_restart",
  "default_cover",
  "connected",
  "machine",
  "miami",
  "anonymous",
  "morpho",
  "worker"
}

for _,v in pairs(icon_name) do
  icons[v] = p..v..".png"
end

return icons
