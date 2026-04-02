type Method<T, A..., R...> = (T, A...) -> R...

local function callWithSelf<T, A..., R...>(self: T, fn: Method<T, A..., R...>)
	return function(...: A...): R...
		return fn(self, ...)
	end
end

return callWithSelf
