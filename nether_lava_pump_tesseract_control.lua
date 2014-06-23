-- bind our monitor
local monitor = peripheral.wrap("back")

-- set the text size
monitor.setTextScale(0.5)

-- initialise the redstone output
redstone.setOutput("right", false)

function redraw_screen()
	-- set background colour to black
	monitor.setBackgroundColor(colors.black)

	-- clear the screen before we redraw it
	monitor.clear()

	-- print our title
	monitor.setCursorPos(3,2)
	monitor.write("NETHER LAVA")
	monitor.setCursorPos(7,3)
	monitor.write("PUMP")

	-- draw the tesseract box, colour depending on what state the outputs are in
	monitor.setCursorPos(2,6)
	if redstone.getOutput("right") == false then
		monitor.setBackgroundColor(colors.red)
		monitor.write("             ")
		monitor.setCursorPos(2,7)
		monitor.write("  TESSERACT  ")
		monitor.setCursorPos(2,8)
		monitor.write("  DISABLED   ")
		monitor.setCursorPos(2,9)
		monitor.write("             ")
	elseif redstone.getOutput("right") == true then
		monitor.setBackgroundColor(colors.lime)
		monitor.write("             ")
		monitor.setCursorPos(2,7)
		monitor.write("  TESSERACT  ")
		monitor.setCursorPos(2,8)
		monitor.write("   ENABLED   ")
		monitor.setCursorPos(2,9)
		monitor.write("             ")
	end
end

-- call redraw_screen once to draw the screen for the first time
redraw_screen()

while true do
	-- pull touch events from the screen
	event, side, xPos, yPos = os.pullEvent("monitor_touch")

	-- if the touch was within the tesseract box, toggle that output
	if xPos >= 2 and xPos <=14 and yPos >= 6 and yPos <= 9 then
		if redstone.getOutput("right") == false then
			redstone.setOutput("right", true)
			redraw_screen()
		elseif redstone.getOutput("right") == true then
			redstone.setOutput("right", false)
			redraw_screen()
		end
	end
end