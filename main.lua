--[[
  The game idea is to click the circles as they randomly appear:
  [X] Spawn circles randomly around the screen
  [X] When user clicks circle, remove from screen
  [X] Add score when user clicks a circle
  [X] Add a score element/text on screen
  [X] Add a round system that will add more circles
  [X] Add a timer that will count down, indicating time to click circles
]]


function love.load()
  game = {}
  game.circleCount = 10
  game.score = 0
  game.timer = 15
  game.round = 1
  game.restart = function()
      game.circleCount = 10
      game.timer = 15
      game.score = 0
      game.round = 1
      createCircles(game.circleCount)
  end
  game.newRound = function()
    game.circleCount = game.circleCount + 10
    game.timer = 15
    if (game.round == 1) then
      game.timer = 14
    elseif (game.round == 2) then
      game.timer = 10
    elseif (game.round == 3) then
      game.timer = 6
    elseif (game.round == 4) then
      game.timer = 4
    else
      game.restart()
    end
    createCircles(game.circleCount)
  end

  
  mouseData = {}
  mouseData.x = 0
  mouseData.y = 0
  mouseData.distToCirc = 0
  mouseData.isDown = false
  
  circles = {}
  createCircles(game.circleCount)
end

function createCircles(circleCount)
  for i=1,circleCount do
    local circle = {}
    circle.x = math.random(0, 500)
    circle.y = math.random(0, 500)
    circle.rad = math.random(25, 50)
    circle.mode = "line"
    table.insert(circles, circle)
  end
end

function math.dist(x1,y1, x2,y2) return ((x2-x1)^2+(y2-y1)^2)^0.5 end


function love.draw()
    love.graphics.print('Time: ' .. math.floor(game.timer) .. "\n Score: " .. game.score .. '\n Round: ' .. game.round .. "\n CircleCount:" .. game.circleCount, 0, 0)
    for i, circle in ipairs(circles) do
      love.graphics.circle(circle.mode, circle.x, circle.y, circle.rad)
    end
end


function love.update()
    mouseData.x, mouseData.y = love.mouse.getPosition()
    mouseData.isDown = love.mouse.isDown(1)
    
    if (game.timer >= 0) then
      game.timer = game.timer - love.timer.getDelta()
    end
    
    if (game.circleCount <= 0 and game.timer > 0) then
      game.round = game.round + 1
      game.newRound()
    end
    
    for i, circle in ipairs(circles) do
        mouseData.distToCirc = math.dist(mouseData.x, mouseData.y, circle.x, circle.y)
        if (mouseData.isDown == true and mouseData.distToCirc < circle.rad) then
          table.remove(circles, i)
          game.score = game.score + 1
          game.circleCount = game.circleCount - 1
        end
        if (mouseData.distToCirc < circle.rad) then
          circle.mode = "fill"
        else 
          circle.mode = "line"
        end
    end
end