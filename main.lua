local configPath = path.combine(paths.config(), "Groove_Salad-HoldToInteract.cfg")

local exists, config = pcall(toml.decodeFromFile, configPath, { formattedIntsAsUserData = false })
if not exists then
    log.info("Generating config file")
    config = {
        interaction_delay = 0.25
    }
    pcall(toml.encodeToFile, config, configPath)
end

---@type number
local last_interaction_time

---@return number
local function current_time()
   return gm.get_timer() / 1000000.0
end

gm.pre_script_hook(gm.constants.control, function(self, other, result, args)
   if args[1].value == "interact" and current_time() >= last_interaction_time + config.interaction_delay then
      args[2].value = false
   end
end)

gm.post_script_hook(gm.constants.control, function(self, other, result, args)
   if result.value == true and args[1].value == "interact" then
      last_interaction_time = current_time()
   end
end)