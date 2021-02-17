-- lecture_pong/main.lua

-- https://github.com/Ulydev/push
push = require 'lib/push/push'

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDHT = 432
VIRTUAL_HEIGHT = 243

-- speed at which we will move our paddle; multiplied by dt in update
PADDLE_SPEED = 200

function love.load()
    --[[
        Runs when the game first starts up, only once; used to initialize the game.
    ]]
    love.graphics.setDefaultFilter('nearest', 'nearest')

    -- more "retro-looking" font object we can use for any text
    smallFont = love.graphics.newFont('fonts/font.ttf', 8)

    -- larger font for drawing the score on the screen
    scoreFont = love.graphics.newFont('fonts/font.ttf', 32)

    love.graphics.setFont(smallFont)

    push:setupScreen(VIRTUAL_WIDHT, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = false,
        vsync = true
    })

    -- initialize score variables, used for rendering on the screen and keeping
    -- track of the winner
    player1score = 0
    player2score = 0

    -- paddle positions on the Y axis (they can only move up or down)
    player1Y = 30
    player2Y = VIRTUAL_HEIGHT - 50
end

--[[
    Runs every frame, with "dt" passed in, our delta in seconds 
    since the last frame, which LÖVE2D supplies us.
]]
function love.update(dt)
    -- player 1 movement
    if love.keyboard.isDown('w') then
        player1Y = player1Y + -PADDLE_SPEED * dt
    elseif love.keyboard.isDown('s') then
        player1Y = player1Y + PADDLE_SPEED * dt
    end

    -- player 2 movement
    if love.keyboard.isDown('up') then
        player2Y = player2Y + -PADDLE_SPEED * dt
    elseif love.keyboard.isDown('down') then
        player2Y = player2Y + PADDLE_SPEED * dt
    end
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

    love.graphics.setFont(smallFont)
    love.graphics.printf('Hello Pong!', 0, 20, VIRTUAL_WIDHT, 'center')

    -- draw score on the left and right center of the screen
    -- need to switch font to draw before actually printing
    love.graphics.setFont(scoreFont)
    love.graphics.print(tostring(player1score), VIRTUAL_WIDHT / 2 - 50,
        VIRTUAL_HEIGHT / 3)
    love.graphics.print(tostring(player2score), VIRTUAL_WIDHT / 2 + 30,
        VIRTUAL_HEIGHT / 3)
    -- first paddle(left side)
    love.graphics.rectangle('fill', 10, player1Y, 5, 20)

    -- second paddle(right side)
    love.graphics.rectangle('fill', VIRTUAL_WIDHT - 10, player2Y, 5, 20)

    love.graphics.rectangle('fill', VIRTUAL_WIDHT / 2 - 2, VIRTUAL_HEIGHT / 2 - 2, 4, 4)

    push:apply('end')
end
