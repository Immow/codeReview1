require("globals")
local gui = require("gui")
local hold = false

local targetCircle = {}
targetCircle.radius = 50
targetCircle.x = love.math.random(targetCircle.radius, WINDOW_WIDTH - targetCircle.radius)
targetCircle.y = love.math.random(targetCircle.radius, WINDOW_HEIGHT - targetCircle.radius)

local userCircle = {}
userCircle.radius = 50
userCircle.x = WINDOW_WIDTH / 2
userCircle.y = WINDOW_HEIGHT / 2

function love.load()
	love.window.setMode(WINDOW_WIDTH, WINDOW_HEIGHT)
	gui:load()
end

local function pointToPointDistance(a, b)
	local distX = a.x - b.x
	local distY = a.y - b.y

	return math.sqrt((distX * distX) + (distY * distY))
end

function love.mousepressed(mx, my)
	local mouse = {x = mx, y = my}
	if pointToPointDistance(userCircle, mouse) < userCircle.radius then
		hold = true
	end
end

function love.mousereleased()
	hold = false
end

function love.mousemoved(x, y, dx, dy)
	if hold then
		userCircle.x = userCircle.x + dx
		userCircle.y = userCircle.y + dy
	end
end

function love.update(dt)
	gui:update(dt)
	
	local target = (userCircle.x - targetCircle.x)^2 + (userCircle.y - targetCircle.y)^2
	if target < 10 then
		targetCircle.x = love.math.random(targetCircle.radius, WINDOW_WIDTH - targetCircle.radius + 1)
		targetCircle.y = love.math.random(targetCircle.radius, WINDOW_HEIGHT - targetCircle.radius + 1)
		gui:addCount()
	end
end

function love.draw()
	gui:draw()
	love.graphics.setColor(0.1, 0.5, 0.2)
	love.graphics.circle('fill', userCircle.x, userCircle.y, userCircle.radius, 100)
	love.graphics.setColor(0.7, 0.1, 0.4)
	love.graphics.circle('line', targetCircle.x, targetCircle.y, targetCircle.radius + 10, 100)
	love.graphics.setColor(0.5, 0.5, 0.5)
end