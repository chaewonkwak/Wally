-----------------------------------------------------------------------------------------
--
-- Main.lua
--
-- 개발 : 냨냨
--
-----------------------------------------------------------------------------------------

display.setStatusBar( display.DefaultStatusBar )	-- IOS

-- 환경 설정

local widget = require "widget"
local composer = require "composer"

local font = "KoPubDotumBold.ttf"
local SceneName
local sceneOption = { effect = "fade", time = 250 }

-- 이벤트 핸들러

local function Start()
	composer.gotoScene( "CardReverse", sceneOption )
end

Start()