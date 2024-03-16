local configPath = path.combine(paths.config(), "Groove_Salad-HoldToInteract.cfg")

local exists, config = pcall(toml.decodeFromFile, configPath, { formattedIntsAsUserData = false })
if not exists then
    log.info("Generating config file")
    config = {
        interaction_delay = 0.25,
        reset_delay_per_interactable = true,
    }
    pcall(toml.encodeToFile, config, configPath)
end

local last_interaction_time = 0.0
local last_interactable_id
local current_interactable_id

---@return number
local function current_time()
   return gm.get_timer() / 1000000.0
end

local function should_force_interact()
   if last_interactable_id ~= current_interactable_id then
      last_interactable_id = current_interactable_id
      return true
   end
   return current_time() >= last_interaction_time + config.interaction_delay
end

gm.pre_script_hook(gm.constants.control, function(self, other, result, args)
   if args[1].value == "interact" and should_force_interact() then
      args[2].value = false
   end
end)

gm.post_script_hook(gm.constants.control, function(self, other, result, args)
   if result.value == true and args[1].value == "interact" then
      last_interaction_time = current_time()
   end
end)

if config.reset_delay_per_interactable then
   gm.pre_code_execute(function(self, other, code, result, flags)
      if code.name == "gml_Object_pInteractable_Collision_oP" then
         current_interactable_id = self.id
      end
   end)
end