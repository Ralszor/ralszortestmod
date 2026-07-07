local IndoctNoelleFilter, super = Class(Object)

function IndoctNoelleFilter:init()
    super.init(self)
	self.bloom_alpha_a = 0.6
	self.bloom_alpha_b = 0.5
	self.bloom_alpha_c = 0.04
	self.bloom_alpha_d = 0.03
	self.bloom_dist = 5
	self.bloom_amplitude = 3
	self.bloom_period = 20
	self.bloom_siner = 0
end

function IndoctNoelleFilter:fullDraw(...)
    self.main_canvas = love.graphics.getCanvas() -- Usually SCREEN_CANVAS, but not always.
    super.fullDraw(self)
end

function IndoctNoelleFilter:draw()
    love.graphics.push()
    Draw.pushCanvasLocks()
    love.graphics.origin()
    Draw.setColor(1, 1, 1, 1)
    local c = Draw.pushCanvas(SCREEN_WIDTH, SCREEN_HEIGHT)
    Draw.drawCanvas(self.main_canvas)
	local b = self.bloom_dist + (math.sin(self.bloom_siner / self.bloom_period) * self.bloom_amplitude)
	Draw.setColor(1, 1, 1, self.bloom_alpha_a * self.alpha)
	for i = 0, 4 do
		Draw.draw(self.main_canvas, math.cos(-math.rad(self.bloom_siner * 2) + (90 * i)) * (b * 2), math.sin(-math.rad(self.bloom_siner * 2) + (90 * i)) * (b * 2))
	end
    Draw.setColor(1, 1, 1, self.bloom_alpha_b * self.alpha)
	for i = 0, 4 do
		Draw.draw(self.main_canvas, math.cos(-math.rad(self.bloom_siner * 2) + (90 * i) + 45) * b, math.sin(-math.rad(self.bloom_siner * 2) + (90 * i) + 45) * b)
	end
	love.graphics.setBlendMode("add")
    Draw.setColor(1, 0.8, 0.8, self.bloom_alpha_c * self.alpha)
	for i = 0, 4 do
		Draw.draw(self.main_canvas, math.cos(-math.rad(self.bloom_siner * 2) + (90 * i)) * (b * 2), math.sin(-math.rad(self.bloom_siner * 2) + (90 * i)) * (b * 2))
	end
    Draw.setColor(1, 0.5, 0.5, self.bloom_alpha_d * self.alpha)
	for i = 0, 4 do
		Draw.draw(self.main_canvas, math.cos(-math.rad(self.bloom_siner * 2) + (90 * i) + 45) * b, math.sin(-math.rad(self.bloom_siner * 2) + (90 * i) + 45) * b)
	end
	love.graphics.setBlendMode("alpha")
    Draw.popCanvas(true)
    love.graphics.clear(0, 0, 0, 1)
	Draw.drawCanvas(c)
    Draw.popCanvasLocks()
    love.graphics.pop()
    super.draw(self)
end

return IndoctNoelleFilter