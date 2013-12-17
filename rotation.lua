--Holy Priest by Shadowstepster
--588 is Inner Fire
--123040 is Mindbender
--28730 is Arcane Torrent
--81206 is Chakra: Sanctuary
--34861 is Circle of Healing
--32546 is Binding Heal
--88685 is Holy Word: Sanctuary
--596 is Prayer of Healing
--724 is Lightwell
--33076 is Prayer of Mending
--2061 is Flash Heal
--2060 is Greater Heal
--2050 is Heal
--139 is Renew
--64901 is Hymn of Hope
--64843 is Divine Hymn
--121135 is Cascade
--120517 is Halo
--114255 is the Surge of Light buff ID
--129250 is Power Word: Solace
--88684 is Power Word: Serenity
--19236 is Desperate Prayer
--10060 is Power Infusion
--32375 is Mass Dispel
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

	{ "588", "!player.buff(Inner Fire)" },
	--mana
	{ "34433", {
		"player.mana < 70",
		"modifier.cooldowns"
	}},
	{ "123040", {
		"player.mana < 80",
		"modifier.cooldowns"
	}},
	{ "28730", {
		"player.mana < 90",
		"modifier.cooldowns"
        }},
        
        --Desperate Prayer
        { "19236", "player.health < 25", "player" },
        
        --Hymn of Hope
        { "!64901", "modifier.lalt"},
        
        --Divine Hymn
        { "64843", {
        	"@coreHealing.needsHealing(50, 8)",
        	"modifier.cooldowns"
        }},
        
        --Lightwell
        { "724", "modifier.lcontrol", "ground" },
        
        --Power Infusion
        { "10060", "modifier.rshift" },
        
        --Mass Dispell
        { "32375", "modifier.ralt", "ground" },
        
        --Cascade/Halo
        { "!121135", "@coreHealing.needsHealing(80, 6)", "lowest" },
        { "120517", "@coreHealing.needsHealing(60, 10)", "lowest" },
        
        -- Sanctuary
        {{	{ "81206", "!player.buff(81206)" },
        	{ "34861", "lowest.health < 95", "lowest" },
        	{ "2061", "lowest.health < 30", "lowest" },
        	{ "2061", {
        		"player.buff(114255).stacks > 0",
        		"lowest.health < 80"
        	}, "lowest" },
        	{ "88685", "modifier.lshift", "ground" },
        	{ "32546", {
        		"lowest.health < 40",
        		"player.health < 40"
        	}, "lowest" },
        	{ "596", "@coreHealing.needsHealing(80, 5)", "lowest" },
        	{ "33076", "!buff.tank", "tank" },
        }, "toggle.sanctuary" },
       
        -- Serenity
        {{	{ "81208", "!player.buff(81208)" },
        	{ "34861", "lowest.health < 95", "lowest" },
        	{ "2061", {
        		"player.buff(114255).stacks > 0",
        		"lowest.health < 80"
        	}, "lowest" },
        	{ "2061", "tank.health < 35", "tank" },
        	{ "139", {
        		"lowest.health < 90",
        		"!lowest.buff(139)"
        	}, "lowest" },
        	{ "88684", "lowest.health < 90" },
        	{ "139", "!tank.buff(139)", "tank" },
        	{ "32546", {
        		"lowest.health < 40",
        		"player.health < 40"
        	}, "lowest" },
        	{ "2061", "lowest.health < 40", "lowest" },
        	{ "!2060", "lowest.health < 75", "lowest" },
        	{ "596", "@coreHealing.needsHealing(85, 8)", "lowest" },
        }, "toggle.serenity" },
        -- Chastise
        {{	{ "Chakra: Chastise", "!player.buff(Chakra: Chastise)" },
        	{ "Mindbender",	"player.mana < 95" },
        	{ "Power Infusion", "modifier.cooldowns" },
        	{ "Mind Sear", "modifier.multitarget" },
        	{ "Holy Fire" },
        	{ "Shadow Word: Pain", "!target.debuff" },
        	{ "Shadow Word: Death", "target.health < 20" },
        	{ "Smite" },
        }, "toggle.chastise" },
        	
        	
        
  }, {
    { "596", "@coreHealing.needsHealing(85, 8)", "lowest" },
    { "139", {
        "lowest.health < 80",
        "!lowest.buff(139)"
    }, "lowest" },
    { "2050", "lowest.health < 95", "lowest" },
}, function ()
  ProbablyEngine.toggle.create('sanctuary', 'Interface\\Icons\\ability_priest_prayerofhealing', 'Sanctuary', '')
  ProbablyEngine.toggle.create('serenity', 'Interface\\Icons\\ability_priest_renew', 'Serenity', '')
  ProbablyEngine.toggle.create('chastise', 'Interface\\Icons\\ability_priest_smite', 'Chastise', '')
end)