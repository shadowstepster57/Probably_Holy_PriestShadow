--Holy Priest by Shadowstepster

ProbablyEngine.library.register('coreHealing', {
  needsHealing = function(percent, count)
    return ProbablyEngine.raid.needsHealing(tonumber(percent)) >= count
  end,
  needsDispelled = function(spell)
    for unit,_ in pairs(ProbablyEngine.raid.roster) do
      if UnitDebuff(unit, spell) then
        ProbablyEngine.dsl.parsedTarget = unit
        return true
      end
    end
  end,
})

ProbablyEngine.rotation.register_custom(257, "Holy Priest[Shadow]", {

	--mana
	{ "Shadowfiend", {
		"player.mana < 70",
		"modifier.cooldowns"
	}},
	{ "Mindbender", {
		"player.mana < 70",
		"modifier.cooldowns"
	}},
	{ "Arcane Torrent", {
		"player.mana < 90",
		"modifier.cooldowns"
        }},
        { "Hymn of Hope", "modifier.alt"},
        
        --healing
        { "Chakra: Sanctuary", "!player.buff" },
        { "Circle of Healing", "@coreHealing.needsHealing(85, 3)", "lowest" },
        { "Holy Word: Sanctuary", "modifier.shift", "ground" },
        { "88685", "modifier.shift", "ground" },
        { "Lightwell", "modifier.control", "ground" },
        { "Prayer of Mending", "!buff.tank", "tank" },
        { "Greater Heal", "lowest.health < 50", "lowest" },
        { "Halo", "@coreHealing.needsHealing(60, 10)", "lowest" },
        { "Binding Heal", {
        	"lowest.health < 40",
        	"player.health < 40"
        }},
        { "Renew", {
        	"lowest.health < 70",
        	"!lowest.buff(Renew)"
        }},
        { "Prayer of Healing", "@coreHealing.needsHealing(85, 10)", "lowest" },
        { "Heal", "lowest.health < 90", "lowest" },
        
        
        

})