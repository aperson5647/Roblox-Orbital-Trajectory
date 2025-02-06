CollectionService = game:GetService("CollectionService")
local gravityScript = game.ReplicatedStorage.Predictor
local bodies = workspace:GetChildren()

for _, body in ipairs(bodies) do
	if CollectionService:HasTag(body, "Trajectory") then
		clonedGrav = gravityScript:Clone()
		clonedGrav.Parent = body
	end
end

-- there is no comment here you are insane