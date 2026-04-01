--- Services ---
local ReplicatedStorage = game:GetService("ReplicatedStorage")

--- Requires ---
local Janitor = require(ReplicatedStorage.Packages.Janitor)

--- Types ---
type Actions = typeof(require(script.Parent.Actions))
type Guards = typeof(require(script.Parent.Guards))

type Context = typeof(require(script.Parent.Context)) & {
	janitor: typeof(Janitor.new()),
	event: string,
	Send: (string, any) -> (),
	target: string?,
	any: any,
}

export type Action = keyof<Actions> | ((any) -> any)
export type Guard = keyof<Guards>

export type EventActions = { Action } | Action | string?
export type EventGuards = { Guard } | Guard | string?

export type Event = { target: string?, guards: EventGuards?, actions: EventActions? }

export type StateNode = {
	initial: string?,

	parallel: true?,
	janitor: true?,

	history: "shallow" | "deep" | nil,

	OnEntry: ((ctx: Context, eventData: any) -> ())?,
	OnDestroy: ((ctx: Context) -> ())?,
	OnExit: ((ctx: Context) -> ())?,

	states: { [string]: StateNode }?,
	events: { [string]: Event | { Event } }?,
}

return {}
