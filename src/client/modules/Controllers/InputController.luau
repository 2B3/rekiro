--- Services ---
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")

--- Player ---
local localPlayer = Players.LocalPlayer

--- Folders ---
local inputs = localPlayer.PlayerScripts:WaitForChild("Inputs")

--- Variables ---
local inputController = {}

--- Private Methods ---
local function getAction(contextName: string, actionName: string): InputAction?
	local inputContext = inputs:FindFirstChild(contextName) :: InputContext?
	if not inputContext then
		warn(`Context({contextName}) not found in ReplicatedStorage/Inputs.`)
		return
	end

	local inputAction = inputContext:FindFirstChild(actionName) :: InputAction?
	if not inputAction then
		warn(`Action not found in {inputAction}`)
		return
	end

	return inputAction
end

--- Public Methods ---

--[=[
   Return Pressed `RBXScriptSignal` from a path.

   @param string contextName --> the `InputContext` parent of the `InputAction` you want.
   @param string actionName --> the name of the `InputAction` you want.

   @return RBXScriptSignal? PressedSignal
]=]
function inputController:getPressedSignal(contextName: string, actionName: string): RBXScriptSignal<nil>?
	local inputAction = getAction(contextName, actionName)
	assert(inputAction, "InputAction not found.")

	return inputAction.Pressed
end

--[=[
   Return Released `RBXScriptSignal` from a path.

   @param string contextName --> the `InputContext` parent of the `InputAction` you want.
   @param string actionName --> the name of the `InputAction` you want.

   @return RBXScriptSignal? ReleasedSignal
]=]
function inputController:getReleasedSignal(contextName: string, actionName: string): RBXScriptSignal?
	local inputAction = getAction(contextName, actionName)
	assert(inputAction, "InputAction not found.")

	return inputAction.Released
end

--[=[
	Returns whether the given key name is currently held down.

	@param keyof<KeyCode> key --> target key.

	@return boolean --> return true if is currently held down.
]=]
function inputController:isKeyDown(key: keyof<typeof(Enum.KeyCode)>): boolean
	return UserInputService:IsKeyDown(Enum.KeyCode[key])
end

return inputController
