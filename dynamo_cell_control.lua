-- initialise our arguments table
args = {...}

-- check that we have the right number of arguments
if #args > 0 and #args < 2  then
	-- extract our arguments to variables
	power_cell_number = args[1]
else
	error("Too few or too many arguments!")
end

-- bind our monitor
local monitor = peripheral.wrap("back")

-- set the text size
monitor.setTextScale(0.5)

-- initialise the redstone outputs
redstone.setOutput("left", false)
redstone.setOutput("right", false)

function redraw_screen()
	-- set background colour to black
	monitor.setBackgroundColor(colors.black)

	-- clear the screen before we redraw it
	monitor.clear()

	-- print our title
	monitor.setCursorPos(13,3)
	monitor.write("POWER CELL " .. power_cell_number)

	-- draw the dynamo control box, colour depending on what state the outputs are in
	monitor.setCursorPos(2,6)
	if redstone.getOutput("left") == false then
		monitor.setBackgroundColor(colors.red)
	elseif redstone.getOutput("left") == true then
		monitor.setBackgroundColor(colors.lime)
	end
	monitor.write("                ")
	monitor.setCursorPos(2,7)
	monitor.write("     DYNAMO     ")
	monitor.setCursorPos(2,8)
	monitor.write("     CONTROL    ")
	monitor.setCursorPos(2,9)
	monitor.write("                ")

	-- draw the energy output box, colour depending on what state the outputs are in
	monitor.setCursorPos(20,6)
	if redstone.getOutput("right") == false then
		monitor.setBackgroundColor(colors.red)
	elseif redstone.getOutput("right") == true then
		monitor.setBackgroundColor(colors.lime)
	end
	monitor.write("                ")
	monitor.setCursorPos(20,7)
	monitor.write("     ENERGY     ")
	monitor.setCursorPos(20,8)
	monitor.write("     OUTPUT     ")
	monitor.setCursorPos(20,9)
	monitor.write("                ")
end

-- call redraw_screen once to draw the screen for the first time
redraw_screen()

while true do
	-- pull touch events from the screen
	event, side, xPos, yPos = os.pullEvent("monitor_touch")

	-- if the touch was within the dynamo control box, toggle that output
	if xPos >= 2 and xPos <=17 and yPos >= 6 and yPos <= 9 then
		if redstone.getOutput("left") == false then
			redstone.setOutput("left", true)
			redraw_screen()
		elseif redstone.getOutput("left") == true then
			redstone.setOutput("left", false)
			redraw_screen()
		end
	end

	-- if the touch was within the energy output box, toggle that output
	if xPos >= 20 and xPos <= 35 and yPos >= 6 and yPos <= 9 then
		if redstone.getOutput("right") == false then
			redstone.setOutput("right", true)
			redraw_screen()
		elseif redstone.getOutput("right") == true then
			redstone.setOutput("right", false)
			redraw_screen()
		end
	end
end