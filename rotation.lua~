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

	{ "Inner fire", "!player.buff(Inner Fire)" },
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
        { "Divine Hymn", "@coreHealing.needsHealing(30, 10)" },
        { "Cascade", "@coreHealing.needsHealing(80, 6)", "lowest" },
        { "Halo", "@coreHealing.needsHealing(60, 10)", "lowest" },
        
        -- 25-man
        {{{ "Chakra: Sanctuary", "!player.buff" },
        { "Circle of Healing", "@coreHealing.needsHealing(95, 3)", "lowest" },
        { "Holy Word: Sanctuary", "modifier.shift", "ground" },
        { "88685", "modifier.shift", "ground" },
        { "Lightwell", "modifier.control", "ground" },
        { "Prayer of Mending", "!buff.lowest", "lowest" },
        { "Greater Heal", "lowest.health < 60", "lowest" },
        { "Binding Heal", {
        	"lowest.health < 40",
        	"player.health < 40"
        }},
        { "Prayer of Healing", "@coreHealing.needsHealing(85, 8)", "lowest" },
        { "Heal", "lowest.health < 95", "lowest" },
},"modifier.multitarget" },
       
        -- 10-man
        {{{ "Chakra: Serenity", "!player.buff" },
        { "88684", "lowest.health < 90" },
        { "Binding Heal", {
        	"lowest.health < 40",
        	"player.health < 40"
        }, "lowest" },
        { "Flash Heal", "lowest.health < 40", "lowest" },
        { "Greater Heal", "lowest.health < 75", "lowest" },
        { "Renew", {
        	"lowest.health < 80",
        	"!lowest.buff(139)"
        }, "lowest" },
        { "Heal", "lowest.health < 90", "lowest" }, 
}, "!modifier.multitarget" },
        
        
        
        
}
)