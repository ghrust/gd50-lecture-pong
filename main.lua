-- lecture_pong/main.lua

-- https://github.com/Ulydev/push
push = require 'lib/push/push'

-- the "Class" library we're using will allow us to represent anything in
-- our game as code, rather than keeping track of many disparate variables and
-- methods
--
-- https://github.com/vrld/hump/blob/master/class.lua
Class = require 'lib/class'

-- our Paddle class, which stores position and dimensions for each Paddle
-- and the logic for rendering them
require 'Paddle'

-- our Ball class, which isn't much different than a Paddle structure-wise
-- but which will mechanically function very differently
require 'Ball'

WINDOW_WIDTH = 854
WINDOW_HEIGHT = 480

VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 243

-- speed at which we will move our paddle; multiplied by dt in update
PADDLE_SPEED = 200

function love.load()
  --[[
      Runs when the game first starts up, only once; used to initialize the game.
  ]]
  -- if arg[#arg] == "-debug" then require("mobdebug").start() end
  love.graphics.setDefaultFilter('nearest', 'nearest')

  -- set the title of our application window
  love.window.setTitle('Pong')

  -- "seed" the RNG so that calls to random are always random
  -- use the current time, since that will vary on startup every time
  math.randomseed(os.time())

  -- more "retro-looking" font object we can use for any text
  smallFont = love.graphics.newFont('fonts/font.ttf', 8)
  love.graphics.setFont(smallFont)

  -- initialize window with virtual resolution
  push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
      fullscreen = false,
      resizable = false,
      vsync = true
  })

  -- initialize our player paddles; make them global so that they can be
  -- detected by other functions and modules
  player1 = Paddle(10, 30, 5, 20)
  player2 = Paddle(VIRTUAL_WIDTH - 10, VIRTUAL_HEIGHT - 30, 5 , 20)

  -- place a ball in the middle of the screen
  ball = Ball(VIRTUAL_WIDTH / 2 - 2, VIRTUAL_HEIGHT / 2 - 2, 4, 4)

  -- game state variable used to transition between different parts of the game
  -- (used for beginning, menus, main game, high score list, etc.)
  -- we will use this to determine behavior during render and update
  gameState = 'start'
end

function love.update(dt)
  --[[
    Runs every frame, with "dt" passed in, our delta in seconds
    since the last frame, which LÖVE2D supplies us.
  ]]
  if gameState == 'play' then
    -- detect ball collision with paddles, reversing dx if true and
    -- slightly increasing it, then altering the dy based on the position of collision
    if ball:collides(player1) then
      ball.dx = -ball.dx * 1.03
      ball.x = player1.x + 5

      -- keep velocity going in the same direction, but randomize it
      if ball.dy < 0 then
        ball.dy = -math.random(10, 150)
      else
        ball.dy = math.random(10, 150)
      end
    end

    if ball:collides(player2) then
      ball.dx = -ball.dx * 1.03
      ball.x = player2.x - 4

      -- keep velocity going in the same direction, but randomize it
      if ball.dy < 0 then
        ball.dy = -math.random(10, 150)
      else
        ball.dy = math.random(10, 150)
      end
    end
  end
  -- player 1 movement
  if love.keyboard.isDown('w') then
    player1.dy = -PADDLE_SPEED
  elseif love.keyboard.isDown('s') then
    player1.dy = PADDLE_SPEED
  else
    player1.dy = 0
  end

  -- player 2 movement
  if love.keyboard.isDown('up') then
    player2.dy = -PADDLE_SPEED
  elseif love.keyboard.isDown('down') then
    player2.dy = PADDLE_SPEED
  else
    player2.dy = 0
  end

  -- update our ball based on its DX and DY only if we're in play state;
  -- scale the velocity by dt so movement is framerate-independent
  if gameState == 'play' then
    ball:update(dt)
  end

  player1:update(dt)
  player2:update(dt)
end

function love.keypressed(key)
  --[[
    Keyboard handling, called by LÖVE2D each frame;
    passes in the key we pressed so we can access.
  ]]
  if key == 'escape' then
    love.event.quit()

  -- if we press enter during the start state of the game, we'll go into play mode
  -- during play mode, the ball will move in a random direction
  elseif key == 'enter' or key == 'return' then
    if gameState == 'start' then
      gameState = 'play'
    else
      gameState = 'start'

      -- ball's new reset method
      ball:reset()
    end
  end
end

function love.draw()
  --[[
      Called after update by LÖVE2D, used to draw anything to the screen, updated or otherwise.
  ]]
  -- begin rendering at virtual resolution
  push:apply('start')

  -- clear the screen with a specific color; in this case, a color similar
  -- to some versions of the original Pong
  love.graphics.clear(40 / 255, 45 / 255, 52 / 255, 1)

  -- draw different things based on the state of the game
  love.graphics.setFont(smallFont)

  if gameState == 'start' then
      love.graphics.printf('Hello Start State!', 0, 20, VIRTUAL_WIDTH, 'center')
  else
      love.graphics.printf('Hello Play State!', 0, 20, VIRTUAL_WIDTH, 'center')
  end

  -- render paddles, now using their class's render method
  player1:render()
  player2:render()

  -- render ball using its class's render method
  ball:render()

  -- new function just to demonstrate how to see FPS in LÖVE2D
  displayFPS()

  -- end rendering at virtual resolution
  push:apply('end')
end

function displayFPS()
  --[[
    Renders the current FPS.
  ]]
  love.graphics.setFont(smallFont)
  love.graphics.setColor(0, 255, 0, 255)
  love.graphics.print('FPS: ' .. tostring(love.timer.getFPS()), 10, 10)
end
