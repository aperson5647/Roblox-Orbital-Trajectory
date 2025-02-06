-- Distribution Version

-- SCROLL DOWN TO FIND GRAVITATIONAL CONSTANT!

CollectionService = game:GetService("CollectionService")

real_body = script.Parent.Parent

virtual_body_folder = Instance.new("Folder")
virtual_body_folder.Parent = workspace
virtual_body_folder.Name = "VirtualBodies"

virtual_body = Instance.new("Part")
virtual_body.Anchored = true
virtual_body.Size = real_body.Size - Vector3.new(5,5,5)
virtual_body.Name = (real_body.Name.." Virtual Body")
virtual_body.Parent = virtual_body_folder
virtual_body.Shape = Enum.PartType.Ball
virtual_body.Color = Color3.new(134,0,0)
virtual_body.Material = Enum.Material.Neon
virtual_body.Position = real_body.Position
virtual_body.AssemblyLinearVelocity = real_body.AssemblyLinearVelocity
virtual_body.CustomPhysicalProperties = real_body.CustomPhysicalProperties
virtual_body.CanCollide = false

local velocity = Vector3.new(0,0,0) + virtual_body.AssemblyLinearVelocity

deltaSlider = workspace.Settings.Delta
stepSlider = workspace.Settings.Steps
trajThickness = workspace.Settings.TrajectoryThickness

prediction_steps = stepSlider.Value
prediction_delta = deltaSlider.Value
thickness = trajThickness.Value

G = 1  -- Gravitational constant, higher numbers amplifies gravity while lower numbers weaken it. The real life number is 0.0000000000667408
Self = virtual_body
pos = Self.Position
prev_pos = pos - (velocity * prediction_delta)
custom_mass = real_body.Mass
initPos = Self.Position

print(custom_mass)

virtual_body.AssemblyLinearVelocity = Vector3.zero

local Heartbeat = game:GetService("RunService").Heartbeat

local bodies = workspace.VirtualBodies:GetChildren()
local Sun = workspace.Sun

if Sun == nil then
	print("SUN IS MISSING! PLEASE ADD A PART NAMED 'SUN' TO WORKSPACE!!")
end

table.insert(bodies, Sun)
print(bodies)

function gravity(delta)
	local accelerationRawr = Vector3.new()

	for _, body in ipairs(bodies) do
		if body ~= Self then
			local other_mass = body.Mass
			local other_pos = body.Position
			local r = (pos - other_pos).Magnitude

			if r > 0 then
				local force_magnitude = (G * custom_mass  * other_mass) / (r * r)
				local direction = (other_pos - pos).Unit
				accelerationRawr += (direction * force_magnitude) / custom_mass
			end
		end
	end
	
	return accelerationRawr
end

function run_prediction()
	for i = 0, prediction_steps, 1 do
		local acceleration = gravity(prediction_delta)

		local new_pos = (2 * pos) - prev_pos + acceleration * (prediction_delta * prediction_delta)

		velocity = (new_pos - pos) / prediction_delta

		prev_pos = pos
		pos = new_pos
		
		local sphere = Instance.new("Part")
		sphere.Shape = Enum.PartType.Ball
		sphere.Size = thickness3
		sphere.Position = pos
		sphere.Anchored = true
		sphere.Material = Enum.Material.Neon
		sphere.Color = Color3.new(0, 134, 0)
		sphere.Parent = script.Parent.Arrows
		sphere.CanCollide = false
	end
	Self.Position = pos
end

function changedSettings()
	
	script.Parent.Arrows:ClearAllChildren()
	
	local current_velocity = Self.AssemblyLinearVelocity
	
	thickness = trajThickness.Value
	thickness3 = Vector3.new(thickness,thickness,thickness)
	prediction_steps = stepSlider.Value
	prediction_delta = deltaSlider.Value
	Self.Position = initPos
	pos = initPos
	prev_pos = pos - (current_velocity * prediction_delta)
	
	velocity = current_velocity

	run_prediction()
end

changedSettings()

trajThickness:GetPropertyChangedSignal("Value"):Connect(changedSettings)
deltaSlider:GetPropertyChangedSignal("Value"):Connect(changedSettings)
stepSlider:GetPropertyChangedSignal("Value"):Connect(changedSettings)
Self:GetPropertyChangedSignal("AssemblyLinearVelocity"):Connect(changedSettings)

run_prediction()

virtual_body.AssemblyLinearVelocity = real_body.AssemblyLinearVelocity