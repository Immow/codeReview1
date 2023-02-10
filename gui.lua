local Gui = {}

function Gui:load()
	self.count = 0
	self.countdown = 0
	self.timer = 15
	self.round = 1
end

function Gui:barColor(time)
	love.graphics.setColor(time / self.timer, 0.0, 1.0 - time / self.timer)
end

function Gui:addCount()
	self.count = self.count + 1
end

function Gui:update(dt)
	self.countdown = self.countdown + dt
	if self.countdown > self.timer then
		if self.count >= 5 then
			self.timer = self.timer - 2
			self.count = 0
			self.round = self.round + 1
		else
		end
		self.countdown = 0
	end
end

function Gui:draw()
	self:barColor(self.countdown)
	love.graphics.rectangle('fill', self.countdown * WINDOW_WIDTH / 2 * self.timer, 0, WINDOW_WIDTH - self.countdown * WINDOW_WIDTH / self.timer, 10)
	love.graphics.print(tostring(self.count), WINDOW_WIDTH / 3, 10)
	love.graphics.print(tostring(self.countdown), WINDOW_WIDTH / 2, 0)
end

return Gui