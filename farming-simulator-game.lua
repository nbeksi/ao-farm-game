-- Farming Simulation Game
-- PID: Wcwiksk14dyMA9BqPtvBUwDS1-WpPn5Yv1Izqb8RGKU
-- Global variable initialization
local players = {} -- Table to store player data
local totalPlayers = 0 -- Total number of players
local activePlayers = 0 -- Number of active players

-- Credentials and game token
local CRED = "Sa0iBLPNyJQrwpTTG-tWLQU-1QeUAJA73DdxGGiKoJc"
local GAME = "tm1jYBC0F2gTZ0EuUQKq5q_esxITDFkAG6QEpLbpI9I"

local colors = { red = "\27[31m", green = "\27[32m", reset = "\27[0m", }

-- Initialize maximum number of players
local maxPlayers = 50

-- Initialize starting resources
local startingMoney = 1000
local startingSeeds = 10

-- Function to transfer cred to start the game
local function Send(data)
    -- Mock Send function for testing
    print("Sending data:", data)
end

-- Function to transfer cred to start the game
local function transferCred()
    -- Send command to transfer cred to game
    Send({Target = CRED, Action = "Transfer", Quantity = "10", Recipient = GAME})
end

-- Function to start the game
local function startGame()
    -- Assign participants as individuals
    for i = 1, maxPlayers do
        local player = {id = "Player " .. i, money = startingMoney, seeds = startingSeeds}
        table.insert(players, player)
        totalPlayers = totalPlayers + 1
        activePlayers = activePlayers + 1
    end

    -- Print in green color
    print(colors.green .. "The game has started!" .. colors.reset)
    print("Total players: " .. totalPlayers)
    print("Active players: " .. activePlayers)
end

-- Check if player has enough cred to start the game
local function checkPlayerCred()
    -- Assuming the player has enough cred, initiate the transfer and start the game
    transferCred()
    startGame()
end

-- Handler to start the game
local function handleStartGame()
    checkPlayerCred()
end

-- Function to harvest crops and earn money
local function harvestCrops(playerID, amount)
    -- Find the player with the matching ID
    for _, player in ipairs(players) do
        if player.id == playerID then
            -- Check if the player has enough crops to harvest
            if player.seeds >= amount then
                local earnings = amount * 10 -- Assume each crop yields 10 money
                player.money = player.money + earnings
                player.seeds = player.seeds - amount
                print("Player " .. playerID .. " harvested " .. amount .. " crops and earned " .. earnings .. " money.")
            else
                print(colors.red .. "Player " .. playerID .. " does not have enough crops to harvest." .. colors.reset)
            end
            break
        end
    end
end

-- Handler to harvest crops
local function handleHarvestCrops(playerID, amount)
    harvestCrops(playerID, amount)
end

-- Function to end the game
local function endGame()
    print(colors.green .. "Game over!" .. colors.reset)
end

-- Example of how to start the game
handleStartGame()

-- Example of how to harvest crops
handleHarvestCrops("Player 1", 5)
handleHarvestCrops("Player 2", 8)

-- End the game
endGame()
