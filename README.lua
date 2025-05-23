-- Hello!!
--
-- INSTRUCTIONS FOR USE
--
-- 1. Move "Predictor" to ReplicatedStorage
-- 2. Move "DistributeTrajectories" to ServerScriptService
-- 3. Move "Settings" to Workspace
-- 4. Add a part named "Sun" to Workspace (Can have ANY properties, must be a Part)
-- 5. Add a part and give it the tag "Trajectory"
-- 6. Run game
-- 7. Give the new part in the newly created "VirtualBodies" folder any AssemblyLinearVelocity
-- 8. See results
--
-- To change the Gravitational Constant go inside of the "Predictor" folder and into the "Predictor" script,
-- scroll down from there till you see the long commented out text. It should look like this:
--
-- "G = 1  -- Gravitational constant, higher numbers amplifies gravity while lower numbers weaken it. The real life numb..."
--
--
-- YAP SECTION
--
-- You can look at the script and do whatever but I must warn you: It isn't pretty or well organized, but it works and showcases
-- N-body physics and Verlet integration. This script has not failed me ever and has actually helped me debug and tune N-body scripts.
--
-- If you want to learn more about N-body physics and Verlet integration there are some pretty good articles online, such as on Wikipedia.