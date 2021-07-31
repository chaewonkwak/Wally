math.randomseed( os.time() )

local widget = require( "widget" )
local composer = require( "composer" )

local scene = composer.newScene()
local sceneOption = { effect = "fade", time = 250 }

--local font = "KoPubDotumBold.ttf"

local i, j = 0, 0
local isFinished = 0
local card = {}
local rand = {}
local count = {}

-- GUI

local background 
local backUI = {}
local gameUI = {}
local soundUI = {}

-- 사운드 UI

	function soundUI_touch()
		if soundUI[1].isVisible then
			soundUI[1].isVisible = false
			soundUI[2].isVisible = true
			audio.pause( soundUI[3] )
		else
			soundUI[1].isVisible = true
			soundUI[2].isVisible = false
			audio.resume( soundUI[3] )
		end
	end

	local btnOption = { width = 150, height = 150, numFrames = 6 }
	local btnSheets = graphics.newImageSheet( "btn_soundUIs.png", btnOption )

--	soundUI[0] = audio.loadStream( "BGM01.mp3" )

	soundUI[1] = widget.newButton({
		width = 140, height = 140, onPress = soundUI_touch,
		sheet = btnSheets, defaultFrame = 1, overFrame = 2
	})
	soundUI[1].x, soundUI[1].y = display.contentWidth - 75, 75
	soundUI[2] = widget.newButton({
		width = 140, height = 140, onPress = soundUI_touch,
		sheet = btnSheets, defaultFrame = 3, overFrame = 4
	})
	soundUI[2].x, soundUI[2].y = display.contentWidth - 75, 75
	soundUI[2].isVisible = false

--	soundUI[3] = audio.play( soundUI[0], { loops = -1 } )

function scene:create( event )
	local sceneGroup = self.view

	background = display.newImageRect("BG_Forest.png", display.contentWidth, display.contentHeight)
	background.x, background.y = display.contentWidth/2, display.contentHeight/2

	gameUI[0] = graphics.newImageSheet( "Card/card.jpg", {width=425, height=700, numFrames=10} )

	backUI[1] = display.newImageRect(gameUI[0], 1, 135, 225)
	backUI[1].x, backUI[1].y = display.contentWidth/2 - backUI[1].width*3.5 - 70, display.contentHeight/2 - backUI[1].height/2 + 75
	backUI[2] = display.newImageRect(gameUI[0], 1, backUI[1].width, backUI[1].height)
	backUI[2].x, backUI[2].y = backUI[1].x+backUI[1].width+20, backUI[1].y
	backUI[3] = display.newImageRect(gameUI[0], 1, backUI[1].width, backUI[1].height)
	backUI[3].x, backUI[3].y = backUI[2].x+backUI[1].width+20, backUI[1].y
	backUI[4] = display.newImageRect(gameUI[0], 1, backUI[1].width, backUI[1].height)
	backUI[4].x, backUI[4].y = backUI[3].x+backUI[1].width+20, backUI[1].y
	backUI[5] = display.newImageRect(gameUI[0], 1, backUI[1].width, backUI[1].height)
	backUI[5].x, backUI[5].y = backUI[4].x+backUI[1].width+20, backUI[1].y
	backUI[6] = display.newImageRect(gameUI[0], 1, backUI[1].width, backUI[1].height)
	backUI[6].x, backUI[6].y = backUI[5].x+backUI[1].width+20, backUI[1].y
	backUI[7] = display.newImageRect(gameUI[0], 1, backUI[1].width, backUI[1].height)
	backUI[7].x, backUI[7].y = backUI[6].x+backUI[1].width+20, backUI[1].y
	backUI[8] = display.newImageRect(gameUI[0], 1, backUI[1].width, backUI[1].height)
	backUI[8].x, backUI[8].y = backUI[7].x+backUI[1].width+20, backUI[1].y

	backUI[9] = display.newImageRect(gameUI[0], 1, backUI[1].width, backUI[1].height)
	backUI[9].x, backUI[9].y = backUI[1].x, backUI[1].y+backUI[1].height+20
	backUI[10] = display.newImageRect(gameUI[0], 1, backUI[1].width, backUI[1].height)
	backUI[10].x, backUI[10].y = backUI[2].x, backUI[9].y
	backUI[11] = display.newImageRect(gameUI[0], 1, backUI[1].width, backUI[1].height)
	backUI[11].x, backUI[11].y = backUI[3].x, backUI[9].y
	backUI[12] = display.newImageRect(gameUI[0], 1, backUI[1].width, backUI[1].height)
	backUI[12].x, backUI[12].y = backUI[4].x, backUI[9].y
	backUI[13] = display.newImageRect(gameUI[0], 1, backUI[1].width, backUI[1].height)
	backUI[13].x, backUI[13].y = backUI[5].x, backUI[9].y
	backUI[14] = display.newImageRect(gameUI[0], 1, backUI[1].width, backUI[1].height)
	backUI[14].x, backUI[14].y = backUI[6].x, backUI[9].y
	backUI[15] = display.newImageRect(gameUI[0], 1, backUI[1].width, backUI[1].height)
	backUI[15].x, backUI[15].y = backUI[7].x, backUI[9].y
	backUI[16] = display.newImageRect(gameUI[0], 1, backUI[1].width, backUI[1].height)
	backUI[16].x, backUI[16].y = backUI[8].x, backUI[9].y

	backUI[17] = display.newText("시도 횟수\n000", 175, soundUI[1].y, 300, 75, "돋움", 37.5)
	backUI[18] = display.newText("성공 확률\n000.00", 175*2+20, soundUI[1].y, 300, 75, "돋움", 37.5)
	backUI[19] = display.newText("성공 횟수\n000", 175*3+40, soundUI[1].y, 300, 75, "돋움", 37.5)
	backUI[20] = display.newText("실패 횟수\n000", 175*4+60, soundUI[1].y, 300, 75, "돋움", 37.5)
	backUI[21] = display.newText("게임 성공", display.contentWidth/2, display.contentHeight-100)
	backUI[21].size = 75
	backUI[21].alpha = 0

	for i = 1, 16, 1 do
		backUI[i].name = i;
	end

	count[0] = 0
	count[1] = 100
	count[2] = 0
	count[3] = 0

	function resetCardCount()
		card[0] = 0
		card[1] = 999
		card[2] = 777
		isFinished = 1
	end

	function isLastCard( c1, c2 )
		for i = 1, 16, 1 do
			if (i ~= c1 and i ~= c2 and rand[i] ~= 0) then
				return 0
			end
		end
		return 1
	end

	function clickBackUI( event )
		j = event.target.name
		
		if (backUI[j].alpha ~= 0 and isFinished == 1 and card[1] ~= j) then
			card[0] = card[0] + 1
			
			if (card[0] <= 2) then
				isFinished = 0

				transition.to( gameUI[j], { time=300, alpha=1 } )
				transition.to( gameUI[j], { time=300, delay=300, xScale=1 } )
				transition.to( backUI[j], { time=300, xScale=0 } )
				transition.to( backUI[j], { time=300, delay=300, alpha=0 } )

				if (card[0] == 1) then
					card[1] = j
					isFinished = 1

				elseif (card[0] == 2) then
					card[2] = j
					count[0] = count[0] + 1
					backUI[17].text = string.format("시도 횟수\n%03d", count[0])

					if(rand[card[1]] == rand[card[2]]) then
						rand[card[1]] = 0.5
						rand[card[2]] = 0.5
						count[2] = count[2] + 1
						backUI[19].text = string.format("성공 횟수\n%03d", count[2])
						backUI[18].text = string.format("성공 확률\n%05.2f", count[2] / count[0] * 100)

						if (isLastCard(card[1], card[2]) == 1) then
							transition.to( gameUI[card[1]], { time=1000, x=display.contentWidth/2, y=display.contentHeight/2 } )
							transition.to( gameUI[card[2]], { time=1000, x=display.contentWidth/2, y=display.contentHeight/2 } )
							transition.to( gameUI[card[1]], { time=1000, delay=1000, width=gameUI[card[1]].width*2, height=gameUI[card[1]].height*2 } )
							transition.to( gameUI[card[2]], { time=1000, delay=1000, width=gameUI[card[1]].width*2, height=gameUI[card[1]].height*2 } )
							transition.to( backUI[21], { time=1000, delay=1100, alpha=1 } )
						else
							transition.to( backUI[card[1]], { time=300, delay=500, alpha=0 } )
							transition.to( backUI[card[2]], { time=300, delay=500, alpha=0 } )
							transition.to( gameUI[card[1]], { time=300, delay=800, alpha=0 } )
							transition.to( gameUI[card[2]], { time=300, delay=800, alpha=0, onComplete=resetCardCount } )
						end
					else
						count[3] = count[3] + 1
						backUI[20].text = string.format("실패 횟수\n%03d", count[3])
						backUI[18].text = string.format("성공 확률\n%05.2f", count[2] / count[0] * 100)

						transition.to( backUI[card[1]], { time=300, delay=800, alpha=1 } )
						transition.to( backUI[card[1]], { time=300, delay=800, xScale=1 } )
						transition.to( gameUI[card[1]], { time=300, delay=500, xScale=0 } )
						transition.to( gameUI[card[1]], { time=300, delay=500, alpha=0 } )

						transition.to( backUI[card[2]], { time=300, delay=800, alpha=1 } )
						transition.to( backUI[card[2]], { time=300, delay=800, xScale=1 } )
						transition.to( gameUI[card[2]], { time=300, delay=500, xScale=0 } )
						transition.to( gameUI[card[2]], { time=300, delay=500, alpha=0, onComplete=resetCardCount } )
					end
				end
			end
		end
	end

	function createGameUI()
		for i = 1, 8, 1 do
			rand[i] = i + 1;
			rand[i+8] = i + 1;
		end

		for i = 1, 8, 1 do
			j = math.floor(math.random(1, 16));
			rand[0] = rand[i];
			rand[i] = rand[j];
			rand[j] = rand[0];
		end

		for i = 1, 16, 1 do
			gameUI[i] = display.newImageRect(gameUI[0], rand[i], backUI[1].width, backUI[1].height)
			gameUI[i].x, gameUI[i].y = backUI[i].x, backUI[i].y
			transition.to( backUI[i], { time=1000, delay=2000, xScale=0 } )
			transition.to( backUI[i], { time=1000, delay=3000, xScale=1, onComplete=resetCardCount } )
			transition.to( gameUI[i], { time=1000, delay=2000, xScale=0 } )
			transition.to( gameUI[i], { time=1000, delay=2500, alpha=0 } )
			backUI[i]:addEventListener( "tap", clickBackUI )
		end
	end
	createGameUI()

-- sceneGroup:insert

	sceneGroup:insert( background )

	for i = 1, 2, 1 do sceneGroup:insert( soundUI[i] ) end
end

function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if phase == "will" then
	elseif phase == "did" then
		-- e.g. start timers, begin animation, play audio, etc.
	end	
end

function scene:hide( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if event.phase == "will" then
		-- e.g. stop timers, stop animation, unload sounds, etc.)
	elseif phase == "did" then
	end
end

function scene:destroy( event )
	local sceneGroup = self.view
end

scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

return scene