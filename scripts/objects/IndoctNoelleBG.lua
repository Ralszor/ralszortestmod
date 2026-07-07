local IndoctNoelleBG, super = Class(BattleBackground)

function IndoctNoelleBG:init()
    super.init(self)
    self.offset = 0
    self.h = 0
    self.glow_siner = 0
	self.bloom_alpha_a = 0.6
	self.bloom_alpha_b = 0.5
	self.bloom_dist = 5
	self.bloom_amplitude = 3
	self.bloom_period = 20
	self.bloom_siner = 0
	self.bloom_filter = IndoctNoelleFilter()
	self.bloom_filter.layer = BATTLE_LAYERS["below_ui"]
	Game.battle:addChild(self.bloom_filter)
end

function IndoctNoelleBG:update()
    super.update(self)

    self.h = self.h - DTMULT
    self.bloom_siner = self.bloom_siner + DTMULT
	local noelle = Game.battle.enemies[1] or nil
	if noelle then
		self.bloom_filter.bloom_alpha_a = MathUtils.lerp(0.08, 0.02, (noelle.health / noelle.max_health))
		self.bloom_filter.bloom_alpha_b = MathUtils.lerp(0.07, 0.01, (noelle.health / noelle.max_health))
		self.bloom_filter.bloom_alpha_c = MathUtils.lerp(0.1, 0.04, (noelle.health / noelle.max_health))
		self.bloom_filter.bloom_alpha_d = MathUtils.lerp(0.08, 0.03, (noelle.health / noelle.max_health))
	end
	self.bloom_filter.bloom_dist = self.bloom_dist
	self.bloom_filter.bloom_amplitude = self.bloom_amplitude
	self.bloom_filter.bloom_period = self.bloom_period
	self.bloom_filter.bloom_siner = self.bloom_siner
    if not self.fading_out then
        self.alpha = MathUtils.approach(self.alpha, 1, 0.1 * DTMULT)
    else
        self.alpha = MathUtils.approach(self.alpha, 0, 0.1 * DTMULT)

        if self.alpha <= 0 then
            self:remove()
        end
    end
end


function IndoctNoelleBG:drawBackground()
        -- Draw the black background
    Draw.setColor(0, 0, 0, self.alpha)
    love.graphics.rectangle("fill", -10, -10, SCREEN_WIDTH + 20, SCREEN_HEIGHT + 20)

    local fog = Assets.getTexture("battle/backgrounds/perlin_noise_dark_looping")
    local bgtexture = Assets.getTexture("battle/backgrounds/creature_bg")
    local ominousglow = Assets.getTexture("battle/backgrounds/ominous_glow")
    
	local canvas = Draw.pushCanvas(SCREEN_WIDTH, SCREEN_HEIGHT)
    Draw.setColor(0, 0, 0, 1)
    love.graphics.rectangle("fill", -10, -10, SCREEN_WIDTH + 20, SCREEN_HEIGHT + 20)
    Draw.setColor(1, 0, 0, 0.5 + math.sin(self.h/40)/32)
    Draw.drawWrapped(bgtexture, true, true, MathUtils.round(6 - self.h/2), MathUtils.round(2 - self.h/2), 0, 1, 1)
    Draw.drawWrapped(bgtexture, true, true, MathUtils.round(6 - self.h)-10, MathUtils.round(2 - self.h)-10, 0, 2, 2)
    Draw.setColor(1, 0, 0, -math.sin(self.h/20)/8 + 0.5)
    Draw.drawWrapped(fog, true, true, MathUtils.round(12 - self.h*2), MathUtils.round(18 - self.h*2), 0, 2, 2)
    Draw.drawWrapped(fog, true, true, MathUtils.round(0 + self.h)+math.sin(self.h/20)*10, MathUtils.round(0 + self.h), 0, 2, 2)
    Draw.popCanvas(true)
	
    Draw.setColor(1, 1, 1, self.alpha)
    Draw.drawCanvas(canvas)
	love.graphics.setBlendMode("add")
    Draw.setColor(1, 1, 1, (0.4 + (math.sin(self.bloom_siner / self.bloom_period) * 0.2)) * self.alpha)
    Draw.draw(ominousglow, 0, 0, 0, 2, 2)
	love.graphics.setBlendMode("alpha")
end

return IndoctNoelleBG