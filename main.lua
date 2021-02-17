-- lecture_pong/main.lua

-- https://github.com/Ulydev/push
push = require 'lib/push/push'

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDHT = 432
VIRTUAL_HEIGHT = 243

function love.load()
    --[[
        Runs when the game first starts up, only once; used to initialize the game.
    ]]
    love.graphics.setDefaultFilter('nearest', 'nearest')

    push:setupScreen(VIRTUAL_WIDHT, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = false,
        vsync = true
    })
end

function love.keypressed(key)
    --[[
        Keyboard handling, called by LÖVE2D each frame; 
        passes in the key we pressed so we can access.
    ]]
    if key == 'escape' then
        love.event.quit()
    end
end

function love.draw()
    --[[
        Called after update by LÖVE2D, used to draw anything to the screen, updated or otherwise.
    ]]
    push:apply('start')

    love.graphics.printf(
        'Hello Pong!',
        0,
        VIRTUAL_HEIGHT / 2 - 6,
        VIRTUAL_WIDHT,
        'center')

    push:apply('end')
end
