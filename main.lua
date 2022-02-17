mouseX = 0
mouseY = 0
circlePosX = 250
circlePosY = 250
dist = 0
circleMode = "line"
radius = 100

function love.draw()
    love.graphics.print("XPos: " .. mouseX .. "\n YPos:" .. mouseY .. "\n Dist:" .. dist .. "\n" .. circleMode, 0, 0)
    love.graphics.circle(circleMode, circlePosX, circlePosY, radius)
end

function math.dist(x1,y1, x2,y2) return ((x2-x1)^2+(y2-y1)^2)^0.5 end

function love.update()
    mouseX = love.mouse.getX();
    mouseY = love.mouse.getY();
    dist = math.dist(mouseX, mouseY, circlePosX, circlePosY);
    if (dist < radius) then
        circleMode = "fill"
    else 
        circleMode = "line"
    end
end