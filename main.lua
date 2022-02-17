--[[
  The game idea is to click the circles as they randomly appear:
  [X] Spawn circles randomly around the screen
  [X] When user clicks circle, remove from screen
  [] Add score when user clicks a circle
  [] Add a score element/text on screen
  [] Add a round system that will add more circles
  [] Add a timer that will count down, indicating time to click circles
]]


function love.load()
  circleCount = 100
  mouseData = {}

  mouseData.x = 0
  mouseData.y = 0
  mouseData.distToCirc = 0
  mouseData.isDown = false
  
  circles = {}
  for i=0,circleCount do
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
  for i, circle in ipairs(circles) do
    love.graphics.circle(circle.mode, circle.x, circle.y, circle.rad)
  end
end


function love.update()
    mouseData.x, mouseData.y = love.mouse.getPosition()
    mouseData.isDown = love.mouse.isDown(1)
    
    for i, circle in ipairs(circles) do
        mouseData.distToCirc = math.dist(mouseData.x, mouseData.y, circle.x, circle.y)
        if (mouseData.isDown == true and mouseData.distToCirc < circle.rad) then
          table.remove(circles, i)
        end
        if (mouseData.distToCirc < circle.rad) then
          circle.mode = "fill"
        else 
          circle.mode = "line"
        end
    end

end