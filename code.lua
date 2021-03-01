-- Labeled by Alvise1309 for no reasons, told by someone full of herself lol

local DS = game:GetService("DataStoreService"):GetDataStore("UserData1") -- Gets the DataStore named "UserData1" from the DataStoreService
-- Using DataStore is a lot unreliable and may cause on loss of data, so I reccomend using DataStore2 or DataStoreX but whatever

game.Players.PlayerAdded:Connect(function(Player) -- Once a player connects run this function with the player that joined as parameter
	local Data = script.Data:Clone() -- Clones the child of the script named Data (which I assume it's a folder). There should be a WaitForChild to prevent an eventual error
	Data.Parent = Player -- Parents the Data to the Player.

	local PlayerData -- Defines a new local variable called PlayerData

	local Success, Error = pcall(function() -- Using a protected call to have a better handle of eventual errors, it returns a tuple to see if there was a success or an error.
		PlayerData = DS:GetAsync("Data_"..Player.UserId) -- Gets the data from the DataStore and assign it to the PlayerData using "Data_" added with the Player's Id as the datastore key
	end) -- end of the pcall

	if Success and PlayerData ~= nil then -- If the pcall had success and the PlayerData is not nil
		for i, Value in pairs(Data:GetDescendants()) do -- Cycles through the Data (folder maybe?) descendants. Variable i of the for loop isn't used so consider using _
			if not Value:IsA("Folder") and PlayerData[Value.Name] then -- if one of the descendants is not a folder and the name of it is found inside the PlayerData table
				Value.Value = PlayerData[Value.Name] -- Assign the value of the descendant to the value of the PlayerData
				-- This could generate an error because there's no check if the descendants is a value so you could attempt to index nil with .Value
			end -- end of the if statement
		end -- end of the for loop
	end -- end of the if statement
end) -- end of the function connected to PlayerAdded  

game.Players.PlayerRemoving:Connect(function(Player) -- Once a player is about to leave run this function with the player that is leaving as a parameter
	local SaveTable = {} -- Defines a new table called SaveTable
	
	-- I would add a if statement to check if the data folder has been successfully parented to the player
	for i, Value in pairs(Player.Data:GetDescendants()) do -- Cycles through the Data (folder maybe?) descendants. Variable i of the for loop isn't used so consider using _
		if not Value:IsA("Folder") then -- if the descendant is not a folder.
			SaveTable[Value.Name] = Value.Value -- Assigns a new index to the table naming it with the value name and then assigns it the descendant value
			-- This could generate an error because there's no check if the descendants is a value so you could attempt to index nil with .Value
		end -- end of the if statement
	end -- end of the for loop

	local Success, Error = pcall(function() -- Using a protected call to have a better handle of eventual errors, it returns a tuple to see if there was a success or an error.
		DS:SetAsync("Data_"..Player.UserId, SaveTable) -- Sets the previously generated SaveTable to the DataStore using "Data_" added with the Player's Id as the datastore key
	end) -- end of the pcall

	if Success then -- If the save operation was a success
		print(Player.UserId.." data saved.") -- prints the Player's Id added with the string " data saved."
	else -- if the save operation wasn't a success
		print(Error) -- prints the details of the error
	end -- end of the if statement
end) -- end of the function connected to PlayerRemoving  

game:BindToClose(function() -- When the server is about to be close caused by a shutdown or by all players leaving run this function
	for i, Player in pairs(game.Players:GetChildren()) do -- Cycles through all the players retrieved with the Players service function GetChildren. I won't use GetChildren, use instead GetPlayers. Variable i of the for loop isn't used so consider using _
		local SaveTable = {} -- Defines a new table called SaveTable
		
		-- I would add a if statement to check if the data folder has been successfully parented to the player
		for i, Value in pairs(Player.Data:GetDescendants()) do -- Cycles through the Data (folder maybe?) descendants. Variable i of the for loop isn't used so consider using _
			if not Value:IsA("Folder") then -- if the descendant is not a folder.
				SaveTable[Value.Name] = Value.Value -- Assigns a new index to the table naming it with the value name and then assigns it the descendant value
				-- This could generate an error because there's no check if the descendants is a value so you could attempt to index nil with .Value
			end -- end of the if statement
		end -- end of the for loop

		local Success, Error = pcall(function() -- Using a protected call to have a better handle of eventual errors, it returns a tuple to see if there was a success or an error.
			DS:SetAsync("Data_"..Player.UserId, SaveTable) -- Sets the previously generated SaveTable to the DataStore using "Data_" added with the Player's Id as the datastore key
		end) -- end of the pcall
		
		if Success then -- If the save operation was a success
			print("Saved") -- Prints "Saved".
		else -- if the save operation wasn't a success
			print(Error)  -- prints the details of the error
		end -- end of the if statement
	end -- end of the for loop
end) -- end of the function connected to the BindToClose

--[[ 
Side notes.

- First: I don't know who you are, but you don't come and shit on other devs just because you are hungry for Robux.
- Second: This was a dickhead move not gonna lie, plus this code was easy.
- Third: Next time makes sure the code is 100% perfect, because I see a lot of lines that could generate errors.
- Fourth: Have fun with my code, bye :)

]]
