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

    smallFont = love.graphics.newFont('fonts/font.ttf', 8)

    love.graphics.setFont(smallFont)

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

    love.graphics.clear(40 / 255, 45 / 255, 52 / 255, 1)

    love.graphics.printf('Hello Pong!', 0, 20, VIRTUAL_WIDHT, 'center')

    -- first paddle(left side)
    love.graphics.rectangle('fill', 10, 30, 5, 20)

    -- second paddle(right side)
    love.graphics.rectangle('fill', VIRTUAL_WIDHT - 10, VIRTUAL_HEIGHT - 50, 5, 20)

    love.graphics.rectangle('fill', VIRTUAL_WIDHT / 2 - 2, VIRTUAL_HEIGHT / 2 - 2, 4, 4)

    push:apply('end')
end
