--!strict

export type event_data = {
	name: string,

	guard: ((any) -> ())?,
	callback: (any) -> (),
}

export type event = {
	name: string,
	enabled: boolean,

	guard: ((any) -> ())?,
	callback: (any) -> (),
}

return function(event_data: event_data): event
	local event = {} :: event
	local old_callback = event_data.callback

	event.name = event_data.name
	event.enabled = true

	event.guard = event_data.guard

	event.callback = function(...)
		if event.guard and not event.guard(...) then 
			return
		end

		old_callback(...)
	end

	return event
end
