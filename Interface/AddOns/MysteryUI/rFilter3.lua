  -- // rFilter3
  -- // zork 
  --  法术监视
  --get the addon namespace
  local addon, ns = ...
  
  --object container
  local cfg = CreateFrame("Frame") 
  
  cfg.rf3_BuffList, cfg.rf3_DebuffList, cfg.rf3_CooldownList = {}, {}, {}
  
  local player_name, _ = UnitName("player")
  local _, player_class = UnitClass("player")
  
  -----------------------------
  -- CONFIG
  -----------------------------  
  
  cfg.highlightPlayerSpells = true
  cfg.updatetime            = 0.2 --how fast should the timer update itself
  
  if player_class == "DEATHKNIGHT" then
  -- Buffs
  cfg.rf3_BuffList = {
 --[[     [1] = {
        spec = nil,
        spellid = 64856, -- Blade Barrier
        size = 28,
        pos = { a1 = "BOTTOM", a2 = "BOTTOM", af = "UIParent", x = -138, y = 410 },
        unit = "player",
        ismine = true,
        desaturate = true,
        alpha = {
          found = {
            frame = 1,
            icon = 1,
          },
          not_found = {
            frame = 0.0,
            icon = 0.6,          
          },
        },
      },]]
      [2] = {
        spec = nil,
        spellid = 57330, -- HoW
        spelllist = { --check a list instead because other classes can do the same
          [1] = 57330,
          [2] = 6673,
          [3] = 8076,
          [4] = 93435,
        },
        size = 28,
        pos = { a1 = "BOTTOM", a2 = "BOTTOM", af = "UIParent", x = -108, y = 410 },
        unit = "player",
        ismine = false,
        hide_ooc = true,
        desaturate = true,
        alpha = {
          found = {
            frame = 1,
            icon = 1,
          },
          not_found = {
            frame = 0.0,
            icon = 0.6,          
          },
        },
      },
      [3] = {
        spec = nil,
        spellid = 49222, -- Bone Shield
        size = 32,
        pos = { a1 = "BOTTOM", a2 = "BOTTOM", af = "UIParent", x = -232, y = 445 },
        unit = "player",
        ismine = true,
        desaturate = true,
        alpha = {
          found = {
            frame = 1,
            icon = 1,
          },
          not_found = {
            frame = 0.0,
            icon = 0.6,          
          },
        },
      },
      [4] = {
        spec = nil,
        spellid = 55233, -- VB
        size = 32,
        pos = { a1 = "BOTTOM", a2 = "BOTTOM", af = "UIParent", x = -197, y = 445 },
        unit = "player",
        ismine = false,
        desaturate = true,
        alpha = {
          found = {
            frame = 1,
            icon = 1,
          },
          not_found = {
            frame = 0.0,
            icon = 0.6,          
          },
        },
      },
       [5] = {
        spec = nil,
        spellid = 48792, -- IBF
        size = 32,
        pos = { a1 = "BOTTOM", a2 = "BOTTOM", af = "UIParent",  x = -267, y = 445 },
        unit = "player",
        ismine = false,
        desaturate = true,
        alpha = {
          found = {
            frame = 1,
            icon = 1,
          },
          not_found = {
            frame = 0.0,
            icon = 0.6,          
          },
        },
      },
    [6] = {
        spec = nil,
        spellid = 48707, -- AMS
        size = 32,
        pos = { a1 = "BOTTOM", a2 = "BOTTOM", af = "UIParent", x = -197, y = 445 },
        unit = "player",
        ismine = false,
        desaturate = true,
        alpha = {
          found = {
            frame = 1,
            icon = 1,
          },
          not_found = {
            frame = 0.0,
            icon = 0.6,          
          },
        },
      },
      [7] = {
        spec = nil,
        spellid = 59052, -- Freezing fog
        size = 32,
        pos = { a1 = "BOTTOM", a2 = "BOTTOM", af = "UIParent", x = -232, y = 447 },
        spelllist = { --Procc
          [1] = 59052, -- Rime
          [2] = 81141, --Blood Swarm
          [3] = 81340, -- Sudden Doom
          [4] = 26017,
          [5] = 702,
          [6] = 50256,
          [7] = 24423,
        },
        unit = "player",
        ismine = true,
        desaturate = true,
        alpha = {
          found = {
            frame = 1,
            icon = 1,
          },
          not_found = {
            frame = 0.0,
            icon = 0.6,          
          },
        },
      },
      [8] = {
        spec = nil,
        spellid = 51124, -- Killing machine
        size = 32,
        pos = { a1 = "BOTTOM", a2 = "BOTTOM", af = "UIParent", x = -232, y = 495 },
        unit = "player",
        ismine = true,
        desaturate = true,
        alpha = {
          found = {
            frame = 1,
            icon = 1,
          },
          not_found = {
            frame = 0.0,
            icon = 0.6,          
          },
        },
      },
      [9] = {
        spec = nil,
        spellid = 49028, -- Dancing Rune Weapon
        size = 32,
        pos = { a1 = "BOTTOM", a2 = "BOTTOM", af = "UIParent", x = -232, y = 495 },
        unit = "player",
        ismine = false,
        desaturate = true,
        alpha = {
          found = {
            frame = 1,
            icon = 1,
          },
          not_found = {
            frame = 0.0,
            icon = 0.6,          
          },
        },
      },
      [10] = {
        spec = nil,
        spellid = 35706, -- Pain Suppression
        size = 32,
        pos = { a1 = "BOTTOM", a2 = "BOTTOM", af = "UIParent", x = -267, y = 495 },
        unit = "player",
        ismine = false,
        desaturate = true,
        alpha = {
          found = {
            frame = 1,
            icon = 1,
          },
          not_found = {
            frame = 0.0,
            icon = 0.6,          
          },
        },
      },
      [11] = {
        spec = nil,
        spellid = 47788, -- Guardian Spirit
        size = 32,
        pos = { a1 = "BOTTOM", a2 = "BOTTOM", af = "UIParent", x = -302, y = 495 },
        unit = "player",
        ismine = false,
        desaturate = true,
        alpha = {
          found = {
            frame = 1,
            icon = 1,
          },
          not_found = {
            frame = 0.0,
            icon = 0.6,          
          },
        },
      },
      [12] = {
        spec = nil,
        spellid = 49039, -- Lichborne
        size = 32,
        pos = { a1 = "BOTTOM", a2 = "BOTTOM", af = "UIParent", x = -232, y = 445 },
        unit = "player",
        ismine = false,
        desaturate = true,
        alpha = {
          found = {
            frame = 1,
            icon = 1,
          },
          not_found = {
            frame = 0.0,
            icon = 0.6,          
          },
        },
      },
    [13] = {
        spec = nil,
        spellid = 77513, -- Blood Shield
        size = 28,
        pos = { a1 = "BOTTOM", a2 = "BOTTOM", af = "UIParent", x = -168, y = 410 },
        unit = "player",
        ismine = true,
        desaturate = true,
        alpha = {
          found = {
            frame = 1,
            icon = 1,
          },
          not_found = {
            frame = 0.0,
            icon = 0.6,          
          },
        },
      },
      [14] = {
        spec = nil,
        spellid = 91342, -- Shadow Infusion
        spelllist = { --check a list instead because other classes can do the same
          [1] = 91342, -- Shadow Infusion
          [2] = 63560, -- Dark Transformation
        },
        size = 28,
        pos = { a1 = "BOTTOM", a2 = "BOTTOM", af = "UIParent", x = -138, y = 410 },
        unit = "pet",
        ismine = false,
        desaturate = true,
        alpha = {
          found = {
            frame = 1,
            icon = 1,
          },
          not_found = {
            frame = 0.0,
            icon = 0.6,          
          },
        },
      },
      [15] = {
        spec = nil,
        spellid = 77606, -- Dark Simulacrum
        size = 32,
        pos = { a1 = "BOTTOM", a2 = "BOTTOM", af = "UIParent", x = -178, y = 420 },
        unit = "player",
        ismine = true,
        desaturate = true,
        alpha = {
          found = {
            frame = 1,
            icon = 1,
          },
          not_found = {
            frame = 0.0,
            icon = 0.6,          
          },
        },
      },
--~       [16] = {
--~         spellid = 16236, -- Ancestral Fortitude
--~         spelllist = { --check a list instead because other classes can do the same
--~           [1] = 16236, -- Ancestral Fortitude
--~           [2] = 15357, --Inspiration       
--~         },
--~         size = 28,
--~         pos = { a1 = "BOTTOM", a2 = "BOTTOM", af = "UIParent", x = -198, y = 410 },
--~         unit = "player",
--~         ismine = false,
--~         desaturate = true,
--~         alpha = {
--~           found = {
--~             frame = 1,
--~             icon = 1,
--~           },
--~           not_found = {
--~             frame = 0.0,
--~             icon = 0.6,          
--~           },
--~         },
--~       },
    }
	
    -- Debuffs    
    cfg.rf3_DebuffList = {
      [1] = {
        spec = nil,
        spellid = 55095, -- FF
        size = 28,
        pos = { a1 = "BOTTOM", a2 = "BOTTOM", af = "UIParent", x = 108, y = 410 },
        unit = "target",
        ismine = true,
        desaturate = true,
        alpha = {
          found = {
            frame = 1,
            icon = 1,
          },
          not_found = {
            frame = 0.0,
            icon = 0.6,          
          },
        },
      },
      [2] = {
        spec = nil,
        spellid = 55078, -- BP
        size = 28,
        pos = { a1 = "BOTTOM", a2 = "BOTTOM", af = "UIParent", x = 138, y = 410 },
        unit = "target",
        ismine = true,
        desaturate = true,
        alpha = {
          found = {
            frame = 1,
            icon = 1,
          },
          not_found = {
            frame = 0.0,
            icon = 0.6,          
          },
        },
      },
      [3] = {
        spec = nil,
        spellid = 81130, -- Scarlet Fever
        spelllist = { --check a list instead because other classes can do the same
          [1] = 81130,
          [2] = 1160,
          [3] = 99,
          [4] = 26017,
          [5] = 702,
          [6] = 50256,
          [7] = 24423,
        },
        size = 28,
        pos = { a1 = "BOTTOM", a2 = "BOTTOM", af = "UIParent", x = 168, y = 410 },
        unit = "target",
        ismine = false,
        desaturate = true,
        alpha = {
          found = {
            frame = 1,
            icon = 1,
          },
          not_found = {
            frame = 0.0,
            icon = 0.6,          
          },
        },
      },
      [4] = {
        spec = nil,
        spellid = 45524, -- CoI / slows
        spelllist = { --check a list instead because other classes can do the same
          [1] = 45524, -- CoI
          [2] = 68766, -- Desecration
          [3] = 50041, -- Chilblains
        },
        size = 32,
        pos = { a1 = "BOTTOM", a2 = "BOTTOM", af = "UIParent", x = 142, y = 445 },
        unit = "target",
        ismine = true,
        desaturate = true,
        alpha = {
          found = {
            frame = 1,
            icon = 1,
          },
          not_found = {
            frame = 0.0,
            icon = 0.6,          
          },
        },
      },
      [5] = {
        spec = nil,
        spellid = 73975, -- Necro
        size = 28,
        pos = { a1 = "BOTTOM", a2 = "BOTTOM", af = "UIParent", x = 168, y = 410 },
        unit = "target",
        ismine = true,
        desaturate = true,
        alpha = {
          found = {
            frame = 1,
            icon = 1,
          },
          not_found = {
            frame = 0.0,
            icon = 0.6,          
          },
        },
      },
      [6] = {
        spec = nil,
        spellid = 64856, -- PvE Stuff
        spelllist = { --check a list instead because other classes can do the same
          [1] = 79624, -- Power Generator Arcanotron
          [2] = 92512, -- Aegis of Flame  25 
          [3] = 82631, -- Aegis of Flame  10
          [4] = 88826, -- Double Attack
        },
        size = 34,
        pos = { a1 = "BOTTOM", a2 = "BOTTOM", af = "UIParent", x = 108, y = 520 },
        unit = "target",
        ismine = false,
        desaturate = true,
        alpha = {
          found = {
            frame = 1,
            icon = 1,
          },
          not_found = {
            frame = 0.0,
            icon = 0.6,          
          },
        },
      },
    }
    
        cfg.rf3_CooldownList = {
--~       [1] = {
--~         spec = 2, 
--~         spellid = 49016, -- Unholy Frenzy
--~         pos = { a1 = "BOTTOM", a2 = "BOTTOM", af = "UIParent", x = -150, y = 132 },
--~         size = 32,
--~         desaturate = true,
--~         alpha = {
--~           cooldown = {
--~             frame = 1,
--~             icon = 0.6,
--~           },
--~           no_cooldown = {
--~             frame = 1,
--~             icon = 1,          
--~           },
--~         },
--~       },
--~       [2] = {
--~         spec = 2, 
--~         spellid = 49206, -- Summon Gargoyle
--~         pos = { a1 = "BOTTOM", a2 = "BOTTOM", af = "UIParent", x = -110, y = 132 },
--~         size = 32,
--~         desaturate = true,
--~         alpha = {
--~           cooldown = {
--~             frame = 1,
--~             icon = 0.6,
--~           },
--~           no_cooldown = {
--~             frame = 1,
--~             icon = 1,          
--~           },
--~         },
--~       },
      [1] = {
        spec = nil, 
        spellid = 45529, -- Blood Tap
        pos = { a1 = "BOTTOM", a2 = "BOTTOM", af = "UIParent", x = -70, y = 132 },
        size = 32,
        desaturate = true,
        alpha = {
          cooldown = {
            frame = 1,
            icon = 0.6,
          },
          no_cooldown = {
            frame = 1,
            icon = 1,          
          },
        },
      },
       [2] = {
        spec = nil, 
        spellid = 77575, -- Outbreak
        pos = { a1 = "BOTTOM", a2 = "BOTTOM", af = "UIParent", x = -30, y = 132 },
        size = 32,
        desaturate = true,
        alpha = {
          cooldown = {
            frame = 1,
            icon = 0.6,
          },
          no_cooldown = {
            frame = 1,
            icon = 1,          
          },
        },
      },
      
    }
end

if player_class == "SHAMAN" then
  -- Buffs
  cfg.rf3_BuffList = {
      [1] = {
        spec = nil,
        spellid = 53390, -- Tidal Waves
        size = 28,
        pos = { a1 = "BOTTOM", a2 = "BOTTOM", af = "UIParent", x = -138, y = 410 },
        unit = "player",
        ismine = true,
        desaturate = true,
        alpha = {
          found = {
            frame = 1,
            icon = 1,
          },
          not_found = {
            frame = 0.0,
            icon = 0.6,          
          },
        },
        },
        [2] = {
        spec = nil,
        spellid = 98619, -- Wings of Flame
        size = 32,
        pos = { a1 = "BOTTOM", a2 = "BOTTOM", af = "UIParent", x = -138, y = 410 },
        unit = "player",
        ismine = true,
        desaturate = true,
        alpha = {
          found = {
            frame = 1,
            icon = 1,
          },
          not_found = {
            frame = 0.0,
            icon = 0.6,          
          },
        },
      },
    }
	
    -- Debuffs    
    cfg.rf3_DebuffList = {
      [1] = {
        spec = nil,
        spellid = 8050, -- Flame Shock
        size = 28,
        pos = { a1 = "BOTTOM", a2 = "BOTTOM", af = "UIParent", x = 108, y = 410 },
        unit = "target",
        ismine = true,
        desaturate = true,
        alpha = {
          found = {
            frame = 1,
            icon = 1,
          },
          not_found = {
            frame = 0.0,
            icon = 0.6,          
          },
        },
      },
--~       [2] = {
--~         spec = nil,
--~         spellid = 55078, -- BP
--~         size = 28,
--~         pos = { a1 = "BOTTOM", a2 = "BOTTOM", af = "UIParent", x = 138, y = 410 },
--~         unit = "target",
--~         ismine = true,
--~         desaturate = true,
--~         alpha = {
--~           found = {
--~             frame = 1,
--~             icon = 1,
--~           },
--~           not_found = {
--~             frame = 0.0,
--~             icon = 0.6,          
--~           },
--~         },
--~       },
--~     }
    
--~         cfg.rf3_CooldownList = {
--~       [1] = {
--~         spec = nil, 
--~         spellid = 2094, -- Blind
--~         pos = { a1 = "BOTTOM", a2 = "BOTTOM", af = "UIParent", x = -150, y = 132 },
--~         size = 32,
--~         desaturate = true,
--~         alpha = {
--~           cooldown = {
--~             frame = 1,
--~             icon = 0.6,
--~           },
--~           no_cooldown = {
--~             frame = 1,
--~             icon = 1,          
--~           },
--~         },
--~       },
--~       [2] = {
--~         spec = nil, 
--~         spellid = 57934, -- Tricks
--~         pos = { a1 = "BOTTOM", a2 = "BOTTOM", af = "UIParent", x = -110, y = 132 },
--~         size = 32,
--~         desaturate = true,
--~         alpha = {
--~           cooldown = {
--~             frame = 1,
--~             icon = 0.6,
--~           },
--~           no_cooldown = {
--~             frame = 1,
--~             icon = 1,          
--~           },
--~         },
--~       },
--~       [3] = {
--~         spec = nil, 
--~         spellid = 68992, -- Worgen Sprint
--~         pos = { a1 = "BOTTOM", a2 = "BOTTOM", af = "UIParent", x = -70, y = 132 },
--~         size = 32,
--~         desaturate = true,
--~         alpha = {
--~           cooldown = {
--~             frame = 1,
--~             icon = 0.6,
--~           },
--~           no_cooldown = {
--~             frame = 1,
--~             icon = 1,          
--~           },
--~         },
--~       },
           
    }
end

if player_class == "WARLOCK" then
  -- Buffs
  cfg.rf3_BuffList = {
--~       [1] = {
--~         spec = nil,
--~         spellid = 17941, -- Shadowtrance
--~         size = 28,
--~         pos = { a1 = "BOTTOM", a2 = "BOTTOM", af = "UIParent", x = -108, y = 480 },
--~         unit = "player",
--~         ismine = true,
--~         desaturate = true,
--~         alpha = {
--~           found = {
--~             frame = 1,
--~             icon = 1,
--~           },
--~           not_found = {
--~             frame = 0.0,
--~             icon = 0.6,          
--~           },
--~         },
--~         },
--~         [2] = {
--~         spec = nil,
--~         spellid = 64371, -- Eradication
--~         size = 28,
--~         pos = { a1 = "BOTTOM", a2 = "BOTTOM", af = "UIParent", x = -108, y = 445 },
--~         unit = "player",
--~         ismine = true,
--~         desaturate = true,
--~         alpha = {
--~           found = {
--~             frame = 1,
--~             icon = 1,
--~           },
--~           not_found = {
--~             frame = 0.0,
--~             icon = 0.6,          
--~           },
--~         },
--~       },
--~         [3] = {
--~         spec = nil,
--~         spellid = 74434, -- Soulburn
--~         size = 28,
--~         pos = { a1 = "BOTTOM", a2 = "BOTTOM", af = "UIParent", x = -180, y = 410 },
--~         unit = "player",
--~         ismine = true,
--~         desaturate = true,
--~         alpha = {
--~           found = {
--~             frame = 1,
--~             icon = 1,
--~           },
--~           not_found = {
--~             frame = 0.0,
--~             icon = 0.6,          
--~           },
--~         },
--~       },
    }
	
    -- Debuffs    
    cfg.rf3_DebuffList = {
      [1] = {
        spec = nil,
        spellid = 30108, -- UA
        size = 28,
        pos = { a1 = "BOTTOM", a2 = "BOTTOM", af = "UIParent", x = 108, y = 410 },
        unit = "target",
        ismine = true,
        desaturate = true,
        alpha = {
          found = {
            frame = 1,
            icon = 1,
          },
          not_found = {
            frame = 0.0,
            icon = 0.6,          
          },
        },
      },
      [2] = {
        spec = nil,
        spellid = 172, -- Corr
        size = 28,
        pos = { a1 = "BOTTOM", a2 = "BOTTOM", af = "UIParent", x = 138, y = 410 },
        unit = "target",
        ismine = true,
        desaturate = true,
        alpha = {
          found = {
            frame = 1,
            icon = 1,
          },
          not_found = {
            frame = 0.0,
            icon = 0.6,          
          },
        },
      },
      [3] = {
        spec = nil,
        spellid = 980, -- Bane of Agony
        spelllist = { --check a list instead because other classes can do the same
          [1] = 980, -- BoA
          [2] = 603, -- BoD 
        },
        size = 28,
        pos = { a1 = "BOTTOM", a2 = "BOTTOM", af = "UIParent", x = 168, y = 410 },
        unit = "target",
        ismine = true,
        desaturate = true,
        alpha = {
          found = {
            frame = 1,
            icon = 1,
          },
          not_found = {
            frame = 0.0,
            icon = 0.6,          
          },
        },
      },
      [4] = {
        spec = nil,
        spellid = 980, -- Curse
        spelllist = { --check a list instead because other classes can do the same
          [1] = 1490, -- CoE
          [2] = 1714, -- CoT 
          [3] = 85547, -- Jinx Ele
          [4] = 18223, -- CoEx
        },
        size = 28,
        pos = { a1 = "BOTTOM", a2 = "BOTTOM", af = "UIParent", x = 168, y = 445 },
        unit = "target",
        ismine = true,
        desaturate = true,
        alpha = {
          found = {
            frame = 1,
            icon = 1,
          },
          not_found = {
            frame = 0.0,
            icon = 0.6,          
          },
        },
      },
--~         [5] = {
--~         spec = nil,
--~         spellid = 32389, -- Shadow Embrace
--~         size = 28,
--~         pos = { a1 = "BOTTOM", a2 = "BOTTOM", af = "UIParent", x = 138, y = 445 },
--~         unit = "target",
--~         ismine = true,
--~         desaturate = true,
--~         alpha = {
--~           found = {
--~             frame = 1,
--~             icon = 1,
--~           },
--~           not_found = {
--~             frame = 0.0,
--~             icon = 0.6,          
--~           },
--~         },
--~       },
--~         [6] = {
--~         spec = nil,
--~         spellid = 48181, -- Haunt
--~         size = 28,
--~         pos = { a1 = "BOTTOM", a2 = "BOTTOM", af = "UIParent", x = 108, y = 445 },
--~         unit = "target",
--~         ismine = true,
--~         desaturate = true,
--~         alpha = {
--~           found = {
--~             frame = 1,
--~             icon = 1,
--~           },
--~           not_found = {
--~             frame = 0.0,
--~             icon = 0.6,          
--~           },
--~         },
--~       },
    }
end

if player_class == "HUNTER" then
  -- Buffs
  cfg.rf3_BuffList = {
    [1] = {
        spec = nil,
        spellid = 53220, -- Improved Steady
        size = 28,
        pos = { a1 = "BOTTOM", a2 = "BOTTOM", af = "UIParent", x = -108, y = 410 },
        unit = "player",
        ismine = true,
        hide_ooc = true,
        desaturate = true,
        alpha = {
          found = {
            frame = 1,
            icon = 1,
          },
          not_found = {
            frame = 0.5,
            icon = 0.6,          
          },
        },
      },
    [2] = {
        spec = nil,
        spellid = 3045, -- Rapid Fire
        size = 28,
        pos = { a1 = "BOTTOM", a2 = "BOTTOM", af = "UIParent", x = -138, y = 410 },
        unit = "player",
        ismine = false,
        desaturate = true,
        alpha = {
          found = {
            frame = 1,
            icon = 1,
          },
          not_found = {
            frame = 0.0,
            icon = 0.6,          
          },
        },
      },
    [3] = {
        spec = nil,
        spellid = 136, -- Mend Pet
        size = 28,
        pos = { a1 = "BOTTOM", a2 = "BOTTOM", af = "UIParent", x = -112, y = 435 },
        unit = "pet",
        ismine = true,
        desaturate = true,
        alpha = {
          found = {
            frame = 1,
            icon = 1,
          },
          not_found = {
            frame = 0.0,
            icon = 0.6,          
          },
        },
      },
    [4] = {
        spec = nil,
        spellid = 82926, -- Amied!
        size = 32,
        pos = { a1 = "BOTTOM", a2 = "BOTTOM", af = "UIParent", x = -152, y = 415 },
        unit = "player",
        ismine = false,
        desaturate = true,
        alpha = {
          found = {
            frame = 1,
            icon = 1,
          },
          not_found = {
            frame = 0.0,
            icon = 0.6,          
          },
        },
      },
        }
	
    -- Debuffs    
    cfg.rf3_DebuffList = {
      [1] = {
        spec = nil,
        spellid = 1978, -- Serpent Sting
        size = 28,
        pos = { a1 = "BOTTOM", a2 = "BOTTOM", af = "UIParent", x = 108, y = 410 },
        unit = "target",
        ismine = true,
        desaturate = true,
        alpha = {
          found = {
            frame = 1,
            icon = 1,
          },
          not_found = {
            frame = 0.0,
            icon = 0.6,          
          },
        },
      },
      [2] = {
        spec = nil,
        spellid = 1130, -- Hunter's Mark
		spelllist = { --check a list instead because other classes can do the same
          [1] = 1130,
          [2] = 88691,
        },
        size = 28,
        pos = { a1 = "BOTTOM", a2 = "BOTTOM", af = "UIParent", x = 138, y = 410 },
        unit = "target",
        ismine = false,
        desaturate = true,
        alpha = {
          found = {
            frame = 1,
            icon = 1,
          },
          not_found = {
            frame = 0.0,
            icon = 0.6,          
          },
        },
      },
    }
end

if player_class == "ROGUE" then
  -- Buffs
  cfg.rf3_BuffList = {
    [1] = {
        spec = nil,
        spellid = 73651, -- Recu
        size = 28,
        pos = { a1 = "BOTTOM", a2 = "BOTTOM", af = "UIParent", x = -108, y = 410 },
        unit = "player",
        ismine = true,
        hide_ooc = false,
        desaturate = true,
        alpha = {
          found = {
            frame = 1,
            icon = 1,
          },
          not_found = {
            frame = 0.0,
            icon = 0.6,          
          },
        },
      },
    [2] = {
        spec = nil,
        spellid = 5171, -- SnD
        size = 28,
        pos = { a1 = "BOTTOM", a2 = "BOTTOM", af = "UIParent", x = -138, y = 410 },
        unit = "player",
        ismine = false,
        desaturate = true,
        alpha = {
          found = {
            frame = 1,
            icon = 1,
          },
          not_found = {
            frame = 0.0,
            icon = 0.6,          
          },
        },
      },
    [3] = {
        spec = nil,
        spellid = 74001, -- CR
        size = 28,
        pos = { a1 = "BOTTOM", a2 = "BOTTOM", af = "UIParent", x = -112, y = 435 },
        unit = "pet",
        ismine = true,
        desaturate = true,
        alpha = {
          found = {
            frame = 1,
            icon = 1,
          },
          not_found = {
            frame = 0.0,
            icon = 0.6,          
          },
        },
      },
    [4] = {
        spec = nil,
        spellid = 13877, -- Blade Flurry
        size = 34,
        pos = { a1 = "BOTTOM", a2 = "BOTTOM", af = "UIParent", x = -138, y = 495 },
        unit = "player",
        ismine = false,
        desaturate = true,
        alpha = {
          found = {
            frame = 1,
            icon = 1,
          },
          not_found = {
            frame = 0.0,
            icon = 0.6,          
          },
        },
      },
    [5] = {
        spec = nil,
        spellid = 1966, -- Feint
        size = 34,
        pos = { a1 = "BOTTOM", a2 = "BOTTOM", af = "UIParent", x = -178, y = 495 },
        unit = "player",
        ismine = false,
        desaturate = true,
        alpha = {
          found = {
            frame = 1,
            icon = 1,
          },
          not_found = {
            frame = 0.0,
            icon = 0.6,          
          },
        },
      },
    [6] = {
        spec = nil,
        spellid = 13750, -- AR/Dance
        spelllist = { 
            [1] = 13750,
            [2] = 51713,
                },
        size = 34,
        pos = { a1 = "BOTTOM", a2 = "BOTTOM", af = "UIParent", x = -218, y = 495 },
        unit = "player",
        ismine = false,
        desaturate = true,
        alpha = {
          found = {
            frame = 1,
            icon = 1,
          },
          not_found = {
            frame = 0.0,
            icon = 0.6,          
          },
        },
      },
        }
	
    -- Debuffs    
    cfg.rf3_DebuffList = {
      [1] = {
        spec = nil,
        spellid = 1943, -- Rupture
        size = 28,
        pos = { a1 = "BOTTOM", a2 = "BOTTOM", af = "UIParent", x = 108, y = 410 },
        unit = "target",
        ismine = true,
        desaturate = true,
        alpha = {
          found = {
            frame = 1,
            icon = 1,
          },
          not_found = {
            frame = 0.0,
            icon = 0.6,          
          },
        },
      },
      [2] = {
        spec = nil,
        spellid = 2818, -- DP
--~ 		spelllist = { --check a list instead because other classes can do the same
--~           [1] = 1130,
--~           [2] = 88691,
--~         },
        size = 28,
        pos = { a1 = "BOTTOM", a2 = "BOTTOM", af = "UIParent", x = 138, y = 410 },
        unit = "target",
        ismine = true,
        desaturate = true,
        alpha = {
          found = {
            frame = 1,
            icon = 1,
          },
          not_found = {
            frame = 0.0,
            icon = 0.6,          
          },
        },
      },
        [3] = {
        spec = nil,
        spellid = 56807, -- Glyph of Hemorrhage
--~ 		spelllist = { --check a list instead because other classes can do the same
--~           [1] = 1130,
--~           [2] = 88691,
--~         },
        size = 28,
        pos = { a1 = "BOTTOM", a2 = "BOTTOM", af = "UIParent", x = 168, y = 410 },
        unit = "target",
        ismine = true,
        desaturate = true,
        alpha = {
          found = {
            frame = 1,
            icon = 1,
          },
          not_found = {
            frame = 0.0,
            icon = 0.6,          
          },
        },
      },
    }
end

if player_class == "WARRIOR" then
  -- Buffs
  cfg.rf3_BuffList = {
    [1] = {
        spec = nil,
        spellid = 2565, -- Block
        size = 28,
        pos = { a1 = "BOTTOM", a2 = "BOTTOM", af = "UIParent", x = -108, y = 410 },
        unit = "player",
        ismine = true,
        hide_ooc = false,
        desaturate = true,
        alpha = {
          found = {
            frame = 1,
            icon = 1,
          },
          not_found = {
            frame = 0.0,
            icon = 0.6,          
          },
        },
      },
    [2] = {
        spec = nil,
        spellid = 12975, -- Last Stand
        size = 28,
        pos = { a1 = "BOTTOM", a2 = "BOTTOM", af = "UIParent", x = -138, y = 410 },
        unit = "player",
        ismine = false,
        desaturate = true,
        alpha = {
          found = {
            frame = 1,
            icon = 1,
          },
          not_found = {
            frame = 0.0,
            icon = 0.6,          
          },
        },
      },
    [3] = {
        spec = nil,
        spellid = 871, -- Wall
        size = 28,
        pos = { a1 = "BOTTOM", a2 = "BOTTOM", af = "UIParent", x = -112, y = 435 },
        unit = "pet",
        ismine = true,
        desaturate = true,
        alpha = {
          found = {
            frame = 1,
            icon = 1,
          },
          not_found = {
            frame = 0.0,
            icon = 0.6,          
          },
        },
      },
    [4] = {
        spec = nil,
        spellid = 13877, -- Blade Flurry
        size = 34,
        pos = { a1 = "BOTTOM", a2 = "BOTTOM", af = "UIParent", x = -138, y = 495 },
        unit = "player",
        ismine = false,
        desaturate = true,
        alpha = {
          found = {
            frame = 1,
            icon = 1,
          },
          not_found = {
            frame = 0.0,
            icon = 0.6,          
          },
        },
      },
    [5] = {
        spec = nil,
        spellid = 1966, -- Feint
        size = 34,
        pos = { a1 = "BOTTOM", a2 = "BOTTOM", af = "UIParent", x = -178, y = 495 },
        unit = "player",
        ismine = false,
        desaturate = true,
        alpha = {
          found = {
            frame = 1,
            icon = 1,
          },
          not_found = {
            frame = 0.0,
            icon = 0.6,          
          },
        },
      },
      [6] = {
        spec = nil, 
        spellid = 6673, --battle shout
        spelllist = { --check a list instead because other classes can do the same
          [1] = 6673,
          [2] = 57330,
          [3] = 8076,
          [4] = 93435,
        },
        size = 26,
        pos = { a1 = "BOTTOM", a2 = "BOTTOM", af = "UIParent", x = -218, y = 495 },
        unit = "player",
        hide_ooc = true, --hide icon out of combat
        ismine = false,
        desaturate = true,
        alpha = {
          found = {
            frame = 0,
            icon = 0,
          },
          not_found = {
            frame = 0.4,
            icon = 0.6,          
          },
        },
      },
        }
	
    -- Debuffs    
    cfg.rf3_DebuffList = {
      [1] = {
        spec = nil,
        spellid = 86346, -- Col Smash
--~ 		spelllist = { --check a list instead because other classes can do the same
--~           [1] = 1130,
--~           [2] = 88691,
--~         },
        size = 28,
        pos = { a1 = "BOTTOM", a2 = "BOTTOM", af = "UIParent", x = 108, y = 410 },
        unit = "target",
        ismine = true,
        desaturate = true,
        alpha = {
          found = {
            frame = 1,
            icon = 1,
          },
          not_found = {
            frame = 0.0,
            icon = 0.6,          
          },
        },
      },
      [2] = {
        spec = 2, 
        spellid = 1160, --demo shout
        spelllist = { --check a list instead because other classes can do the same
          [1] = 1160,
          [2] = 81130,
          [3] = 99,
          [4] = 26017,
          [5] = 702,
          [6] = 50256,
          [7] = 24423,
        },
        size = 26,
        pos = { a1 = "BOTTOM", a2 = "BOTTOM", af = "UIParent", x = 138, y = 410 },
        unit = "target",
        validate_unit = true, --only show the icon if unit is found
        hide_ooc      = true, --hide icon out of combat
        ismine = false,
        desaturate = true,
        alpha = {
          found = {
            frame = 1,
            icon = 1,
          },
          not_found = {
            frame = 0.4,
            icon = 0.6,          
          },
        },
      },
    }
end

  if player_name == "Rothar" and player_class == "WARRIOR" then
  
    --Rothars Buff List
  
    cfg.rf3_BuffList = {
      [1] = {
        spec = 1, 
        --spec got moved to bufflist, so buffs can be set up per spec 
        -- 1 is your first spec 
        -- 2 is your second spec
        -- false or nil will remove the spec tracking
        spellid = 469, --commanding shout
        spelllist = { --check a list instead because other classes can do the same
          [1] = 469,
          [2] = 79105,
          [3] = 6307,
          [4] = 90364,
        },
        size = 26,
        pos = { a1 = "BOTTOM", a2 = "BOTTOM", af = "UIParent", x = 130, y = 107 },
        unit = "player",
        validate_unit = true, --only show the icon if unit is found
        ismine        = false,
        desaturate =   true,
        alpha = {
          found = {
            frame = 1,
            icon = 1,
          },
          not_found = {
            frame = 0.4,
            icon = 0.6,          
          },
        },
      },
      [2] = {
        spec = 2, 
        spellid = 6673, --battle shout
        spelllist = { --check a list instead because other classes can do the same
          [1] = 6673,
          [2] = 57330,
          [3] = 8076,
          [4] = 93435,
        },
        size = 26,
        pos = { a1 = "BOTTOM", a2 = "BOTTOM", af = "UIParent", x = 100, y = 107 },
        unit = "player",
        ismine = false,
        desaturate = true,
        alpha = {
          found = {
            frame = 1,
            icon = 1,
          },
          not_found = {
            frame = 0.4,
            icon = 0.6,          
          },
        },
      },
      [3] = {
        spec = nil, 
        spellid = 18499, --berserker rage
        size = 30,
        pos = { a1 = "BOTTOM", a2 = "BOTTOM", af = "UIParent", x = 0, y = 150 },
        unit = "player",
        ismine = true,
        desaturate = true,
        alpha = {
          found = {
            frame = 1,
            icon = 1,
          },
          not_found = {
            frame = 0,
            icon = 0,          
          },
        },
      },
      [4] = {
        spec = nil, 
        spellid = 2565, --shield block
        size = 26, 
        pos = { a1 = "BOTTOM", a2 = "BOTTOM", af = "UIParent", x = -130, y = 138 },
        unit = "player",
        ismine = true,
        desaturate = true,
        alpha = {
          found = {
            frame = 1,
            icon = 1,
          },
          not_found = {
            frame = 0,
            icon = 0.6,          
          },
        },
      },
      [5] = {
        spec = nil, 
        spellid = 87096, --thunderclap dps boost
        size = 26, 
        pos = { a1 = "BOTTOM", a2 = "BOTTOM", af = "UIParent", x = -100, y = 138 },
        unit = "player",
        ismine = true,
        desaturate = true,
        alpha = {
          found = {
            frame = 1,
            icon = 1,
          },
          not_found = {
            frame = 0,
            icon = 0.6,          
          },
        },
      },
      [6] = {
        spec = nil, 
        spellid = 14202, --enrage
        size = 30, 
        pos = { a1 = "BOTTOM", a2 = "BOTTOM", af = "UIParent", x = 0, y = 150 },
        unit = "player",
        ismine = true,
        desaturate = true,
        alpha = {
          found = {
            frame = 1,
            icon = 1,
          },
          not_found = {
            frame = 0,
            icon = 0,          
          },
        },
      },
      [7] = {
        spec = nil, 
        spellid = 12292, --deathwish
        size = 30, 
        pos = { a1 = "BOTTOM", a2 = "BOTTOM", af = "UIParent", x = 0, y = 150 },
        unit = "player",
        ismine = true,
        desaturate = true,
        alpha = {
          found = {
            frame = 1,
            icon = 1,
          },
          not_found = {
            frame = 0,
            icon = 0,          
          },
        },
      },
      [8] = {
        spec = nil, 
        spellid = 12964, --deathwish
        size = 50, 
        pos = { a1 = "BOTTOM", a2 = "BOTTOM", af = "UIParent", x = 0, y = 190 },
        unit = "player",
        ismine = true,
        desaturate = true,
        alpha = {
          found = {
            frame = 1,
            icon = 1,
          },
          not_found = {
            frame = 0,
            icon = 0,          
          },
        },
      },
      
      
    }
    
    --Rothars Debuff List
    
    cfg.rf3_DebuffList = {
      [1] = {
        spec = nil, 
        spellid = 58567, --sunder armor
        spelllist = { --check a list instead because other classes can do the same
          [1] = 58567,
          [2] = 91565,
          [3] = 8647,
          [4] = 95467,
          [5] = 95466,
        },
        size          = 26,
        pos           = { a1 = "BOTTOM", a2 = "BOTTOM", af = "UIParent", x = -130, y = 107},
        unit          = "target",
        validate_unit = true, --only show the icon if unit is found
        hide_ooc      = true, --hide icon out of combat
        ismine        = false,
        desaturate    = true,
        alpha = {
          found = {
            frame = 1,
            icon = 1,
          },
          not_found = {
            frame = 0.4,
            icon = 0.6,          
          },
        },
      },
      [2] = {
        spec = nil, 
        spellid = 6343, --thunderclap
        spelllist = { --check a list instead because other classes can do the same
          [1] = 6343,
          [2] = 55095,
          [3] = 58180,
          [4] = 68055,
          [5] = 8042,
          [6] = 90315,
          [7] = 54404,
        },
        size = 26,
        pos = { a1 = "BOTTOM", a2 = "BOTTOM", af = "UIParent", x = -100, y = 107 },
        unit = "target",
        validate_unit = true, --only show the icon if unit is found
        hide_ooc      = true, --hide icon out of combat
        ismine = false,
        desaturate = true,
        alpha = {
          found = {
            frame = 1,
            icon = 1,
          },
          not_found = {
            frame = 0.4,
            icon = 0.6,          
          },
        },
      },
      [3] = {
        spec = nil, 
        spellid = 1160, --demo shout
        spelllist = { --check a list instead because other classes can do the same
          [1] = 1160,
          [2] = 81130,
          [3] = 99,
          [4] = 26017,
          [5] = 702,
          [6] = 50256,
          [7] = 24423,
        },
        size = 26,
        pos = { a1 = "BOTTOM", a2 = "BOTTOM", af = "UIParent", x = -40, y = 107 },
        unit = "target",
        validate_unit = true, --only show the icon if unit is found
        hide_ooc      = true, --hide icon out of combat
        ismine = false,
        desaturate = true,
        alpha = {
          found = {
            frame = 1,
            icon = 1,
          },
          not_found = {
            frame = 0.4,
            icon = 0.6,          
          },
        },
      },
      [4] = {
        spec = nil, 
        spellid = 772, --rend
        size = 26,
        pos = { a1 = "BOTTOM", a2 = "BOTTOM", af = "UIParent", x = -70, y = 107 },
        unit = "target",
        validate_unit = true, --only show the icon if unit is found
        hide_ooc      = true, --hide icon out of combat
        ismine = true,
        desaturate = true,
        alpha = {
          found = {
            frame = 1,
            icon = 1,
          },
          not_found = {
            frame = 0.4,
            icon = 0.6,          
          },
        },
      },
      [5] = {
        spec = nil, 
        spellid = 86346, --colossus smash
        size = 40, 
        pos = { a1 = "BOTTOM", a2 = "BOTTOM", af = "UIParent", x = 0, y = 110 },
        unit = "target",
        validate_unit = true, --only show the icon if unit is found
        hide_ooc      = true, --hide icon out of combat
        ismine = true,
        desaturate = true,
        alpha = {
          found = {
            frame = 1,
            icon = 1,
          },
          not_found = {
            frame = 0,
            icon = 0,          
          },
        },
      },
    }
  
  --Rothars Cooldown List
    cfg.rf3_CooldownList = {
      [1] = {
        spec = nil, 
        spellid = 100, --charge
        pos = { a1 = "BOTTOM", a2 = "BOTTOM", af = "UIParent", x = 70, y = 107 },
        size = 26,
        desaturate = true,
        alpha = {
          cooldown = {
            frame = 1,
            icon = 0.6,
          },
          no_cooldown = {
            frame = 1,
            icon = 1,          
          },
        },
      },
      --[[
      [2] = {
        spec = nil, 
        spellid = 20252, --intercept
        pos = { a1 = "BOTTOM", a2 = "BOTTOM", af = "UIParent", x = 70, y = 107 },
        size = 26,
        desaturate = true,
        alpha = {
          cooldown = {
            frame = 1,
            icon = 0.6,
          },
          no_cooldown = {
            frame = 1,
            icon = 1,          
          },
        },
      },
      ]]--
    }
    
  end
  
  if player_class == "MAGE" then
  -- Buffs
  cfg.rf3_BuffList = {
    [1] = {
        spec = nil,
        spellid = 48108, -- 瞬发炎爆术
        size = 30,
        pos = { a1 = "BOTTOM", a2 = "BOTTOM", af = "UIParent", x = -105, y = 320 },
        unit = "player",
        ismine = true,
        hide_ooc = false,
        desaturate = true,
        alpha = {
          found = {
            frame = 1,
            icon = 1,
          },
          not_found = {
            frame = 0.0,
            icon = 0.6,          
          },
        },
      },
	}
    -- Debuffs    
  cfg.rf3_DebuffList = {
    [1] = {
        spec = nil,
        spellid = 44457, -- 活体炸弹
        size = 30,
        pos = { a1 = "BOTTOM", a2 = "BOTTOM", af = "UIParent", x = 145, y = 320 },
        unit = "target",
        ismine = true,
        desaturate = true,
        alpha = {
          found = {
            frame = 1,
            icon = 1,
          },
          not_found = {
            frame = 0.0,
            icon = 0.6,          
          },
        },
      },
    [2] = {
        spec = nil,
        spellid = 118271, -- 活体炸弹
        size = 30,
        pos = { a1 = "BOTTOM", a2 = "BOTTOM", af = "UIParent", x = 105, y = 320 },
        unit = "target",
        ismine = true,
        desaturate = true,
        alpha = {
          found = {
            frame = 1,
            icon = 1,
          },
          not_found = {
            frame = 0.0,
            icon = 0.6,          
          },
        },
      },
	}
  end
  
  -----------------------------
  -- HANDOVER
  -----------------------------
  
  --object container to addon namespace
  ns.cfg = cfg
  
  --------------------------------------
  
  --get the addon namespace
  local addon, ns = ...  
  
  --get the config
  local cfg = ns.cfg  
  
  local rf3_BuffList, rf3_DebuffList, rf3_CooldownList = cfg.rf3_BuffList, cfg.rf3_DebuffList, cfg.rf3_CooldownList
  
  rFilter3Frames = {}  --global variable gather all frames that can be moved ingame, will be accessed by slash command function later
  
  -----------------------------
  -- FUNCTIONS
  -----------------------------
  
  --format time func
  local GetFormattedTime = function(time)
    local hr, m, s, text
    if time <= 0 then text = ""
    elseif(time < 3600 and time > 60) then
      hr = floor(time / 3600)
      m = floor(mod(time, 3600) / 60 + 1)
      text = format('|cffffffff%d|cffCC3333m|r', m)
    elseif time < 60 then
      m = floor(time / 60)
      s = mod(time, 60)
      text = (m == 0 and format('|cffffffff%d|cffCC3333s|r', s))
    else
      hr = floor(time / 3600 + 1)
      text = format('|cffffffff%d|cffCC3333h|r', hr)
    end
    return text
  end
  
  local applySize = function(i)    
    local w = i:GetWidth()
    if w < i.minsize then w = i.minsize end    
    i:SetSize(w,w)
    i.glow:SetPoint("TOPLEFT",i,"TOPLEFT",-w*3.3/32,w*3.3/32)
    i.glow:SetPoint("BOTTOMRIGHT",i,"BOTTOMRIGHT",w*3.3/32,-w*3.3/32)  
    i.icon:SetPoint("TOPLEFT",i,"TOPLEFT",w*3/32,-w*3/32)
    i.icon:SetPoint("BOTTOMRIGHT",i,"BOTTOMRIGHT",-w*3/32,w*3/32)
    i.time:SetFont(STANDARD_TEXT_FONT, w*18/32, "THINOUTLINE")
    i.time:SetPoint("BOTTOM", 0, 0)    
    i.count:SetFont(STANDARD_TEXT_FONT, w*18/32, "OUTLINE")
    i.count:SetPoint("TOPRIGHT", 0,0)
  end
  
  --generate the frame name if a global one is needed
  local makeFrameName = function(f,type)
    if not f.move_ingame then return nil end
    local _, class = UnitClass("player")
    local spec = "None"
    if f.spec then spec = f.spec end
    return "rFilter3"..type.."Frame"..f.spellid.."Spec"..spec..class
  end
  
  local unlockFrame = function(i)
    if i.spec and i.spec ~= GetActiveTalentGroup() then
      return --only show icons that are visible for the current spec
    end    
    i:EnableMouse(true)
    i.locked = false
    i.dragtexture:SetAlpha(0.2)
    i:RegisterForDrag("LeftButton","RightButton")
    i:SetScript("OnEnter", function(s) 
      GameTooltip:SetOwner(s, "ANCHOR_BOTTOMRIGHT")
      GameTooltip:AddLine(s:GetName(), 0, 1, 0.5, 1, 1, 1)
      GameTooltip:AddLine("LEFT MOUSE + ALT + SHIFT to DRAG", 1, 1, 1, 1, 1, 1)
      GameTooltip:AddLine("RIGHT MOUSE + ALT + SHIFT to SIZE", 1, 1, 1, 1, 1, 1)
      GameTooltip:Show()
    end)
    i:SetScript("OnLeave", function(s) GameTooltip:Hide() end)
    i:SetScript("OnDragStart", function(s,b) 
      if IsAltKeyDown() and IsShiftKeyDown() and b == "LeftButton" then
        s:StartMoving()
      end
      if IsAltKeyDown() and IsShiftKeyDown() and b == "RightButton" then
        s:StartSizing()
      end
    end)
    i:SetScript("OnDragStop", function(s) 
      s:StopMovingOrSizing() 
    end)
  end
  
  local lockFrame = function(i)
    i:EnableMouse(nil)
    i.locked = true
    i.dragtexture:SetAlpha(0)
    i:RegisterForDrag(nil)
    i:SetScript("OnEnter", nil)
    i:SetScript("OnLeave", nil)
    i:SetScript("OnDragStart", nil)
    i:SetScript("OnDragStop", nil)
  end
  
  --simple frame movement
  local appyMoveFunctionality = function(f,i)
    if not f.move_ingame then 
      if i:IsUserPlaced() then
        i:SetUserPlaced(false)
      end
      return
    end
    i:SetHitRectInsets(-5,-5,-5,-5)
    i:SetClampedToScreen(true)
    i:SetMovable(true)
    i:SetResizable(true)
    i:SetUserPlaced(true)
    local t = i:CreateTexture(nil,"OVERLAY",nil,6)
    t:SetAllPoints(i)
    t:SetTexture(0,1,0)
    t:SetAlpha(0)
    i.dragtexture = t
    i:SetScript("OnSizeChanged", function(s) 
      applySize(s)
    end)
    lockFrame(i) --lock frame by default
    table.insert(rFilter3Frames,i:GetName()) --load all the frames that can be moved into the global table
  end
  
  --unlock all frames
  local unlockAllFrames = function()
    for index,v in ipairs(rFilter3Frames) do 
      unlockFrame(_G[v])
    end
  end

  --lock all frames
  local lockAllFrames = function()
    for index,v in ipairs(rFilter3Frames) do 
      lockFrame(_G[v])
    end
  end
  
  --slash command functionality
  local function SlashCmd(cmd)    
    if (cmd:match"unlock") then
      unlockAllFrames()
    elseif (cmd:match"lock") then
      lockAllFrames()
    else
      print("|c0033AAFFrFilter3 命令列表:|r")
      print("|c0033AAFF\/rfilter lock|r, 鎖定")
      print("|c0033AAFF\/rfilter unlock|r, to 解鎖")
    end
  end

  SlashCmdList["rfilter"] = SlashCmd;
  SLASH_rfilter1 = "/rfilter";
  SLASH_rfilter2 = "/rf";  
--  print("|c0033AAFFrFilter3 loaded.|r")
--  print("|c0033AAFF\/rfilter|r or |c0033AAFF\/rf|r to display the command list")
  
  local createIcon = function(f,index,type)

    local gsi_name, gsi_rank, gsi_icon, gsi_powerCost, gsi_isFunnel, gsi_powerType, gsi_castingTime, gsi_minRange, gsi_maxRange = GetSpellInfo(f.spellid)
    
    local i = CreateFrame("FRAME",makeFrameName(f,type),UIParent)
    i:SetSize(f.size,f.size)
    i:SetPoint(f.pos.a1,f.pos.af,f.pos.a2,f.pos.x,f.pos.y)
    i.minsize = f.size
    
    local gl = i:CreateTexture(nil, "BACKGROUND",nil,-8)
    gl:SetTexture("Interface\\Addons\\MysteryUI\\MyMedia\\simplesquare_glow")
    gl:SetVertexColor(0, 0, 0, 1)

    local ba = i:CreateTexture(nil, "BACKGROUND",nil,-7)
    ba:SetAllPoints(i)
    ba:SetTexture("Interface\\Addons\\MysteryUI\\MyMedia\\d3portrait_back2")
    
    local t = i:CreateTexture(nil,"BACKGROUND",nil,-6)
    t:SetTexture(gsi_icon)
    t:SetTexCoord(0.1,0.9,0.1,0.9)
    if f.desaturate then
      t:SetDesaturated(1)
    end

    local bo = i:CreateTexture(nil,"BACKGROUND",nil,-4)
    bo:SetTexture("Interface\\Addons\\MysteryUI\\MyMedia\\simplesquare_roth")
    bo:SetVertexColor(0.37,0.3,0.3,1)
    bo:SetAllPoints(i)
    
    local time = i:CreateFontString(nil, "BORDER")
    time:SetTextColor(1, 0.8, 0)
    
    local count = i:CreateFontString(nil, "BORDER")
    count:SetTextColor(1, 1, 1)
    count:SetJustifyH("RIGHT")
    
    i.glow = gl
    i.border = bo
    i.back = ba
    i.time = time
    i.count = count
    i.icon = t
    i.spec = f.spec --save the spec to the icon
    applySize(i)
    appyMoveFunctionality(f,i)
    f.iconframe = i
    f.name = gsi_name
    f.rank = gsi_rank
    f.texture = gsi_icon    

  end
  
  local checkDebuff = function(f,spellid)
    if f.move_ingame and not f.iconframe.locked then --make the icon visible in case we want to move it
      f.iconframe.icon:SetAlpha(1)
      f.iconframe:SetAlpha(1)
      f.iconframe.icon:SetDesaturated(nil)
      f.iconframe.time:SetText("30m")
      f.iconframe.count:SetText("3")
      return
    end
    if f.spec and f.spec ~= GetActiveSpecGroup() then
      f.iconframe:SetAlpha(0)
      return
    end
    if not UnitExists(f.unit) and f.validate_unit then
      f.iconframe:SetAlpha(0)
      return
    end
    if not InCombatLockdown() and f.hide_ooc then
      f.iconframe:SetAlpha(0)
      return      
    end
    local tmp_spellid = f.spellid
    if spellid then
      tmp_spellid = spellid --spellid gets overwritten for spelllists
      local gsi_name, gsi_rank, gsi_icon = GetSpellInfo(spellid)
      if gsi_name then
        f.name = gsi_name
        f.rank = gsi_rank
        f.texture_list = gsi_icon
        f.iconframe.icon:SetTexture(f.texture_list)
        --print(spellid..gsi_name)
      end
    end
    if f.name and f.rank then
      local name, rank, icon, count, dispelType, duration, expires, caster, isStealable, shouldConsolidate, spID = UnitAura(f.unit, f.name, f.rank, "HARMFUL")
      --if name and (not f.ismine or (f.ismine and caster == "player")) then
      if name and (not f.ismine or (f.ismine and caster == "player")) and (not f.match_spellid or (f.match_spellid and spID == tmp_spellid)) then
        if caster == "player" and cfg.highlightPlayerSpells then
          f.iconframe.border:SetVertexColor(0.2,0.6,0.8,1)
        elseif cfg.highlightPlayerSpells then
          f.iconframe.border:SetVertexColor(0.37,0.3,0.3,1)
        end        
        f.iconframe.icon:SetAlpha(f.alpha.found.icon)
        f.iconframe:SetAlpha(f.alpha.found.frame)
        if spellid then
          f.debufffound = true
          --break out of the debuff search loop
        end
        if f.desaturate then
          f.iconframe.icon:SetDesaturated(nil)
        end
        --local value = floor((expires-GetTime())*10+0.5)/10
        if count and count > 1 then
          f.iconframe.count:SetText(count)
        else
          f.iconframe.count:SetText("")
        end
        local value = expires-GetTime()
        if value < 10 then
          f.iconframe.time:SetTextColor(1, 0.4, 0)
        else
          f.iconframe.time:SetTextColor(1, 0.8, 0)
        end
        f.iconframe.time:SetText(GetFormattedTime(value))
      else
        f.iconframe:SetAlpha(f.alpha.not_found.frame)
        f.iconframe.icon:SetAlpha(f.alpha.not_found.icon)
        if spellid then
          f.iconframe.icon:SetTexture(f.texture)
        end
        f.iconframe.time:SetText("")
        f.iconframe.count:SetText("")
        f.iconframe.time:SetTextColor(1, 0.8, 0)
        if cfg.highlightPlayerSpells then
          f.iconframe.border:SetVertexColor(0.37,0.3,0.3,1)
        end 
        if f.desaturate then
          f.iconframe.icon:SetDesaturated(1)
        end
      end
    end
  end
  
  local checkBuff = function(f,spellid)
    if f.move_ingame and not f.iconframe.locked then --make the icon visible in case we want to move it
      f.iconframe.icon:SetAlpha(1)
      f.iconframe:SetAlpha(1)
      f.iconframe.icon:SetDesaturated(nil)
      f.iconframe.time:SetText("30m")
      f.iconframe.count:SetText("3")
      return
    end
    if f.spec and f.spec ~= GetActiveTalentGroup() then
      f.iconframe:SetAlpha(0)
      return
    end
    if not UnitExists(f.unit) and f.validate_unit then
      f.iconframe:SetAlpha(0)
      return
    end
    if not InCombatLockdown() and f.hide_ooc then
      f.iconframe:SetAlpha(0)
      return      
    end
    local tmp_spellid = f.spellid
    if spellid then
      tmp_spellid = spellid --spellid gets overwritten for spelllists
      local gsi_name, gsi_rank, gsi_icon = GetSpellInfo(spellid)
      if gsi_name then
        f.name = gsi_name
        f.rank = gsi_rank
        f.texture_list = gsi_icon
        f.iconframe.icon:SetTexture(f.texture_list)
        --print(spellid..gsi_name)
      end
    end
    if f.name and f.rank then
      local name, rank, icon, count, dispelType, duration, expires, caster, isStealable, shouldConsolidate, spID = UnitAura(f.unit, f.name, f.rank, "HELPFUL")
      --if name and (not f.ismine or (f.ismine and caster == "player")) then
      if name and (not f.ismine or (f.ismine and caster == "player")) and (not f.match_spellid or (f.match_spellid and spID == tmp_spellid)) then
        if caster == "player" and cfg.highlightPlayerSpells then
          f.iconframe.border:SetVertexColor(0.2,0.6,0.8,1)
        elseif cfg.highlightPlayerSpells then
          f.iconframe.border:SetVertexColor(0.37,0.3,0.3,1)
        end
        if spellid then
          f.bufffound = true
          --break out of the buff search loop
        end
        f.iconframe.icon:SetAlpha(f.alpha.found.icon)
        f.iconframe:SetAlpha(f.alpha.found.frame)
        if f.desaturate then
          f.iconframe.icon:SetDesaturated(nil)
        end
        --local value = floor((expires-GetTime())*10+0.5)/10
        if count and count > 1 then
          f.iconframe.count:SetText(count)
        else
          f.iconframe.count:SetText("")
        end
        local value = expires-GetTime()
        if value < 10 then
          f.iconframe.time:SetTextColor(1, 0.4, 0)
        else
          f.iconframe.time:SetTextColor(1, 0.8, 0)
        end
        f.iconframe.time:SetText(GetFormattedTime(value))
      else
        f.iconframe:SetAlpha(f.alpha.not_found.frame)
        f.iconframe.icon:SetAlpha(f.alpha.not_found.icon)
        if spellid then
          f.iconframe.icon:SetTexture(f.texture)
        end
        f.iconframe.time:SetText("")
        f.iconframe.count:SetText("")
        f.iconframe.time:SetTextColor(1, 0.8, 0)
        if cfg.highlightPlayerSpells then
          f.iconframe.border:SetVertexColor(0.37,0.3,0.3,1)
        end 
        if f.desaturate then
          f.iconframe.icon:SetDesaturated(1)
        end
      end
    end
  end
  
  local checkCooldown = function(f)
    if f.move_ingame and not f.iconframe.locked then --make the icon visible in case we want to move it
      f.iconframe.icon:SetAlpha(1)
      f.iconframe:SetAlpha(1)
      f.iconframe.icon:SetDesaturated(nil)
      f.iconframe.time:SetText("30m")
      f.iconframe.count:SetText("3")
      return
    end
    if f.spec and f.spec ~= GetActiveTalentGroup() then
      f.iconframe:SetAlpha(0)
      return
    end
    if not InCombatLockdown() and f.hide_ooc then
      f.iconframe:SetAlpha(0)
      return      
    end
    if f.name and f.spellid then
      local start, duration, enable = GetSpellCooldown(f.spellid)
      if start and duration then
        local now = GetTime()        
        local value = start+duration-now
        if(value > 0) and duration > 2 then
          --item is on cooldown show time
          f.iconframe.icon:SetAlpha(f.alpha.cooldown.icon)
          f.iconframe:SetAlpha(f.alpha.cooldown.frame)
          f.iconframe.count:SetText("")
          f.iconframe.border:SetVertexColor(0.37,0.3,0.3,1)
          if f.desaturate then
            f.iconframe.icon:SetDesaturated(1)
          end
          if value < 10 then
            f.iconframe.time:SetTextColor(1, 0.4, 0)
          else
            f.iconframe.time:SetTextColor(1, 0.8, 0)
          end
          f.iconframe.time:SetText(GetFormattedTime(value))
        else
          f.iconframe:SetAlpha(f.alpha.no_cooldown.frame)
          f.iconframe.icon:SetAlpha(f.alpha.no_cooldown.icon)
          f.iconframe.time:SetText("Biu")
          f.iconframe.count:SetText("")
          f.iconframe.time:SetTextColor(0, 0.8, 0)
          f.iconframe.border:SetVertexColor(0.4,0.6,0.2,1)
          if f.desaturate then
            f.iconframe.icon:SetDesaturated(nil)
          end
        end
      end
    end
  end
  
  local searchBuffs = function()
    for i,_ in ipairs(rf3_BuffList) do 
      local f = rf3_BuffList[i]
      if f.spelllist and f.spelllist[1] then
        --print('buff spelllist exists')
        f.bufffound = false
        for k,spellid in ipairs(f.spelllist) do
          if not f.bufffound then
            checkBuff(f,spellid)
          end
        end        
      else
        checkBuff(f)
      end
    end
  end

  local searchDebuffs = function()
    for i,_ in ipairs(rf3_DebuffList) do 
      local f = rf3_DebuffList[i]
      if  f.spelllist and f.spelllist[1] then
        --print('debuff spelllist exists')
        f.debufffound = false
        for k,spellid in ipairs(f.spelllist) do
          if not f.debufffound then
            checkDebuff(f,spellid)
          end
        end
      else
        checkDebuff(f)
      end
    end
  end

  local searchCooldowns = function()
    for i,_ in ipairs(rf3_CooldownList) do 
      local f = rf3_CooldownList[i]
      checkCooldown(f)
    end
  end

  local lastupdate = 0
  local rFilterOnUpdate = function(self,elapsed)
    lastupdate = lastupdate + elapsed    
    if lastupdate > cfg.updatetime then
      lastupdate = 0
      searchBuffs()
      searchDebuffs()
      searchCooldowns()
    end
  end  
  

  
  -----------------------------
  -- CALL
  -----------------------------

  local count = 0

  for i,_ in ipairs(rf3_BuffList) do 
    local f = rf3_BuffList[i]
    if not f.icon then 
      createIcon(f,i,"Buff")
    end
    count=count+1
  end
  
  for i,_ in ipairs(rf3_DebuffList) do 
    local f = rf3_DebuffList[i]
    if not f.icon then 
      createIcon(f,i,"Debuff")
    end
    count=count+1
  end
  
  for i,_ in ipairs(rf3_CooldownList) do 
    local f = rf3_CooldownList[i]
    if not f.icon then 
      createIcon(f,i,"Cooldown")
    end
    count=count+1
  end
  
  if count > 0 then    
    local a = CreateFrame("Frame")  
    a:SetScript("OnEvent", function(self, event)
      if(event=="PLAYER_LOGIN") then
        self:SetScript("OnUpdate", rFilterOnUpdate)
      end
    end)    
    a:RegisterEvent("PLAYER_LOGIN")  
  end
