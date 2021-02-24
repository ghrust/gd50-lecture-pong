-- Paddle class

Paddle = class{}

function Paddle:init(x, y, width, height)
  --[[
    The `init` function on our class is called just once, when the object
    is first created. Used to set up all variables in the class and get it
    ready for use.

    Our Paddle should take an X and a Y, for positioning, as well as a width
    and height for its dimensions.
  ]]

  self.x = x
  self.y = y
  self.width = width
  self.height = height
  self.dy = 0
end

function Paddle:update()
  -- math.max here ensures that we're the greater of 0 or the player's
  -- current calculated Y position when pressing up so that we don't
  -- go into the negatives; the movement calculation is simply our
  -- previously-defined paddle speed scaled by dt
  if self.dy < 0 then
    self.dy = math.max(0, self.dy + self.dy * dt)
  else
    -- similar to before, this time we use math.min to ensure we don't
    -- go any farther than the bottom of the screen minus the paddle's
    -- height (or else it will go partially below, since position is
    -- based on its top left corner)
    self.dy = math.min(VIRTUAL_HEIGHT - self.height + self.dy * dt)
  end
end

function Paddle:render()
  --[[
    To be called by our main function in `love.draw`, ideally. Uses
    LÖVE2D's `rectangle` function, which takes in a draw mode as the first
    argument as well as the position and dimensions for the rectangle. To
    change the color, one must call `love.graphics.setColor`. As of the
    newest version of LÖVE2D, you can even draw rounded rectangles!
  ]]
  love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
end
