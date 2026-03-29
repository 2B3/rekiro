--- Services ---
local ReplicatedStorage = game:GetService("ReplicatedStorage")

--- Folders ---
local inputs = ReplicatedStorage:WaitForChild("Inputs")

--- Variables ---
local InputController = {}

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
function InputController:GetPressedSignal(contextName: string, actionName: string): RBXScriptSignal<nil>?
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
function InputController:GetReleasedSignal(contextName: string, actionName: string): RBXScriptSignal?
	local inputAction = getAction(contextName, actionName)
	assert(inputAction, "InputAction not found.")

	return inputAction.Released
end

return InputController
