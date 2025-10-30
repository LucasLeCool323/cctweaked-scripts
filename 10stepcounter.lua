-- Gradient sequence triggered by redstone input from the top
-- Uses mon.clear() to show each step as a full-screen color
-- Outputs redstone on the back for 5 seconds after sequence
mon = peripheral.find("monitor")
local function runSequence()
  local gradient = {
    colors.green,   -- step 0
    colors.lime,    -- step 1
    colors.lime,    -- step 2
    colors.yellow,  -- step 3
    colors.yellow,  -- step 4
    colors.orange,  -- step 5
    colors.orange,  -- step 6
    colors.red,     -- step 7
    colors.red,     -- step 8
    colors.red      -- step 9/10
  }

  -- Run the 10-step sequence
  for i = 1, #gradient do
    mon.setBackgroundColor(gradient[i])
    mon.clear()
    sleep(1) -- one step per second
  end

  -- Clear to black
  mon.setBackgroundColor(colors.black)
  mon.clear()

  -- Output redstone on the back for 5 seconds
  redstone.setOutput("back", true)
  sleep(5)
  redstone.setOutput("back", false)
end

-- Main loop: wait for top input, run sequence, then wait for reset
while true do
  if redstone.getInput("top") then
    runSequence()
    -- Wait until top input goes low before restarting
    while redstone.getInput("top") do
      sleep(0.1)
    end
  else
    sleep(0.1)
  end
end
