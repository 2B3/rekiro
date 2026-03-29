local function callWithSelf<T>(self, func: T): T
	return function(): T
		return func(self)
	end
end

return callWithSelf
