local IndoctNoelle, super = Class(Encounter)

function IndoctNoelle:init()
    super.init(self)

    -- Text displayed at the bottom of the screen at the start of the encounter
    self.text = "* Indoct battle test."

    -- Battle music ("battle" is rude buster)
    self.music = "cultist"
    -- Enables the purple grid battle background
    self.background = true

    -- Add the dummy enemy to the encounter
    self.n = self:addEnemy("noelle")
    self.origx, self.origy = self.n.x, self.n.y
    self.siner = 0

    self.sh = ScreenBloomFX()
    self.sh.distance = 0
    Game.battle:addFX(self.sh)
    --- Uncomment this line to add another!
    --self:addEnemy("dummy")
end

function IndoctNoelle:createBackground()
    return Game.battle:addChild(IndoctNoelleBG())
end

return IndoctNoelle
