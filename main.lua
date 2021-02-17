-- lecture_pong/main.lua

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

function love.load()
    --[[
        Runs when the game first starts up, only once; used to initialize the game.
    ]]
    love.window.setMode(WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = false,
        vsync = true
    })
end

function love.draw()
    --[[
        Called after update by LÖVE2D, used to draw anything to the screen, updated or otherwise.
    ]]
    love.graphics.printf(
        'Hello Pong!',
        0,
        WINDOW_HEIGHT/2 - 6,
        WINDOW_WIDTH,
        'center')
end