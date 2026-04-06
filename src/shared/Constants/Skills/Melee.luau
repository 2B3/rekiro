local Melee = {
	Combos = {
		[1] = {
			Duration = 0.56,
			Dash = {
				Velocity = -Vector3.zAxis * 8,
				Duration = 0.3,
			},
		},

		[2] = {
			Duration = 0.4,
			Dash = {
				Velocity = -Vector3.zAxis * 16,
				Duration = 0.17,
			},
		},

		[3] = {
			Duration = 0.6,
			Dash = {
				Velocity = -Vector3.zAxis * 8,
				Duration = 0.3,
			},
		},

		[4] = {
			Duration = 0.32,
			Dash = {
				Velocity = -Vector3.zAxis * 14,
				Duration = 0.17,
			},
		},

		[5] = {
			Duration = 1.8,
			Dash = {
				Velocity = Vector3.zAxis * 12,
				Duration = 0.5,
			},
		},
	},
}

return table.freeze(Melee)
