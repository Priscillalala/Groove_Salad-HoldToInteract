local config_path = path.combine(paths.config(), "Groove_Salad-HoldToInteract.cfg")

local default_config = {
   interaction_delay = 0.25,
   reset_delay_per_interactable = true,
}
local update_config = false

local exists, config = pcall(toml.decodeFromFile, config_path, { formattedIntsAsUserData = false })
if exists then
   ---@param config_table table
   ---@param default_config_table table
   local function check_update_config(config_table, default_config_table)
      for key, default_value in pairs(default_config_table) do
         local value_type = type(default_value)
         local config_value = config_table[key]
         if type(config_value) ~= value_type then
            config_table[key] = default_value
            update_config = true
         elseif value_type == "table" then
            check_update_config(config_value, default_value)
         end
      end
   end
   check_update_config(config, default_config)
else
   config = default_config
   update_config = true
end

if update_config then
   log.info("Updating config file")
   pcall(toml.encodeToFile, config, { file = config_path, overwrite = true })
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