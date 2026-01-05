Config = {}

Config.Locale = 'fr'

-- Job Configuration
Config.Job = 'foundry'
Config.JobLabel = 'Fonderie'

-- Zones de la fonderie
Config.Zones = {
    Foundry = {
        Blip = {
            Enabled = true,
            Sprite = 478,
            Color = 46,
            Scale = 0.8,
            Label = "Fonderie"
        },
        Position = vector3(1110.45, -2008.38, 35.47),
        Marker = {
            Type = 1,
            Size = {x = 1.5, y = 1.5, z = 0.5},
            Color = {r = 255, g = 165, b = 0},
            DrawDistance = 10.0,
            InteractionDistance = 2.0
        }
    },
    Jewelry = {
        Blip = {
            Enabled = true,
            Sprite = 617,
            Color = 5,
            Scale = 0.8,
            Label = "Bijouterie Fonderie"
        },
        Position = vector3(1117.45, -2008.38, 35.47),
        Marker = {
            Type = 1,
            Size = {x = 1.5, y = 1.5, z = 0.5},
            Color = {r = 255, g = 215, b = 0},
            DrawDistance = 10.0,
            InteractionDistance = 2.0
        }
    },
    Export = {
        Blip = {
            Enabled = true,
            Sprite = 478,
            Color = 2,
            Scale = 0.8,
            Label = "Point d'Exportation"
        },
        Position = vector3(1124.45, -2008.38, 35.47),
        Marker = {
            Type = 1,
            Size = {x = 1.5, y = 1.5, z = 0.5},
            Color = {r = 0, g = 255, b = 0},
            DrawDistance = 10.0,
            InteractionDistance = 2.0
        }
    },
    Garage = {
        Blip = {
            Enabled = true,
            Sprite = 50,
            Color = 46,
            Scale = 0.8,
            Label = "Garage Fonderie"
        },
        Position = vector3(1131.45, -2008.38, 35.47),
        SpawnPoint = vector4(1135.0, -2008.0, 35.47, 90.0),
        Marker = {
            Type = 36,
            Size = {x = 1.5, y = 1.5, z = 0.5},
            Color = {r = 255, g = 165, b = 0},
            DrawDistance = 10.0,
            InteractionDistance = 3.0
        }
    },
    BossActions = {
        Position = vector3(1103.45, -2008.38, 35.47),
        Marker = {
            Type = 1,
            Size = {x = 1.5, y = 1.5, z = 0.5},
            Color = {r = 255, g = 0, b = 0},
            DrawDistance = 10.0,
            InteractionDistance = 2.0
        }
    }
}

-- Véhicules de société
Config.Vehicles = {
    {label = 'Mule', model = 'mule', price = 0, category = 'transport'},
    {label = 'Caracara 2', model = 'caracara2', price = 0, category = 'utility'}
}

-- Recettes de Fonderie
Config.FoundryRecipes = {
    -- Fonte des minerais de base
    {
        label = "Lingot de Fer",
        item = "iron_ingot",
        time = 5000,
        amount = 1,
        requires = {
            {item = "iron_ore", amount = 2},
            {item = "coal_ore", amount = 2}
        }
    },
    {
        label = "Barre d'Acier",
        item = "steel_bar",
        time = 7000,
        amount = 1,
        requires = {
            {item = "iron_ingot", amount = 2},
            {item = "coal_ore", amount = 3},
            {item = "scrapmetal", amount = 1}
        }
    },
    {
        label = "Lingot d'Acier",
        item = "steel_ingot",
        time = 8000,
        amount = 1,
        requires = {
            {item = "steel_bar", amount = 2},
            {item = "coal_ore", amount = 1}
        }
    },
    {
        label = "Lingot de Cuivre",
        item = "copper_ingot",
        time = 5000,
        amount = 1,
        requires = {
            {item = "sulfur_chunk", amount = 3},
            {item = "coal_ore", amount = 1}
        }
    },
    {
        label = "Fil de Cuivre",
        item = "copper_wire",
        time = 4000,
        amount = 2,
        requires = {
            {item = "copper_ingot", amount = 1}
        }
    },
    {
        label = "Lingot d'Or (Poussière)",
        item = "gold_ingot",
        time = 8000,
        amount = 1,
        requires = {
            {item = "gold_dust", amount = 5}
        }
    },
    {
        label = "Lingot d'Or (Pépite)",
        item = "gold_ingot",
        time = 8000,
        amount = 1,
        requires = {
            {item = "gold_nugget", amount = 3}
        }
    },

    -- Items pour Hôpitaux
    {
        label = "Béquilles",
        item = "crutches",
        time = 6000,
        amount = 1,
        requires = {
            {item = "steel_ingot", amount = 2},
            {item = "scrap_metal", amount = 1}
        },
        requiredJob = "foundry",
        requiredGrade = 1
    },
    {
        label = "Fauteuil Roulant",
        item = "wheelchair",
        time = 12000,
        amount = 1,
        requires = {
            {item = "steel_ingot", amount = 5},
            {item = "iron_ingot", amount = 3},
            {item = "scrap_metal", amount = 2}
        },
        requiredJob = "foundry",
        requiredGrade = 2
    },
    {
        label = "Gilet Par-Balles (Médical)",
        item = "bulletproof_vest_medical",
        time = 10000,
        amount = 1,
        requires = {
            {item = "steel_ingot", amount = 4},
            {item = "copper_ingot", amount = 2},
            {item = "kevlar_fiber", amount = 3}
        },
        requiredJob = "foundry",
        requiredGrade = 2
    },

    -- Items pour Forces de l'Ordre
    {
        label = "Gilet Par-Balles (Police)",
        item = "bulletproof_vest_police",
        time = 10000,
        amount = 1,
        requires = {
            {item = "steel_ingot", amount = 4},
            {item = "copper_ingot", amount = 2},
            {item = "kevlar_fiber", amount = 3}
        },
        requiredJob = "foundry",
        requiredGrade = 2
    },

    -- Recyclage des armes illégales
    {
        label = "Recyclage Arme (Fer)",
        item = "iron_ingot",
        time = 8000,
        amount = 3,
        requires = {
            {item = "confiscated_weapon", amount = 1}
        },
        requiredJob = "foundry",
        requiredGrade = 1
    },
    {
        label = "Recyclage Arme (Acier)",
        item = "steel_ingot",
        time = 8000,
        amount = 2,
        requires = {
            {item = "confiscated_weapon", amount = 1}
        },
        requiredJob = "foundry",
        requiredGrade = 1
    },

    -- Items pour Gouvernement
    {
        label = "Gilet Par-Balles (Gouvernement)",
        item = "bulletproof_vest_gov",
        time = 10000,
        amount = 1,
        requires = {
            {item = "steel_ingot", amount = 4},
            {item = "copper_ingot", amount = 2},
            {item = "kevlar_fiber", amount = 3}
        },
        requiredJob = "foundry",
        requiredGrade = 2
    },

    -- Items pour Mécanos
    {
        label = "Moteur",
        item = "engine",
        time = 15000,
        amount = 1,
        requires = {
            {item = "steel_ingot", amount = 8},
            {item = "iron_ingot", amount = 5},
            {item = "copper_ingot", amount = 3},
            {item = "scrap_metal", amount = 4}
        },
        requiredJob = "foundry",
        requiredGrade = 2
    },
    {
        label = "Turbo",
        item = "turbo",
        time = 12000,
        amount = 1,
        requires = {
            {item = "steel_ingot", amount = 6},
            {item = "iron_ingot", amount = 4},
            {item = "copper_ingot", amount = 2}
        },
        requiredJob = "foundry",
        requiredGrade = 2
    },
    {
        label = "Suspension",
        item = "suspension",
        time = 10000,
        amount = 1,
        requires = {
            {item = "steel_ingot", amount = 5},
            {item = "iron_ingot", amount = 3}
        },
        requiredJob = "foundry",
        requiredGrade = 1
    },
    {
        label = "Freins",
        item = "brakes",
        time = 8000,
        amount = 1,
        requires = {
            {item = "steel_ingot", amount = 4},
            {item = "copper_ingot", amount = 2}
        },
        requiredJob = "foundry",
        requiredGrade = 1
    },
    {
        label = "Kit de Réparation",
        item = "repair_kit",
        time = 6000,
        amount = 1,
        requires = {
            {item = "steel_ingot", amount = 2},
            {item = "iron_ingot", amount = 2},
            {item = "scrap_metal", amount = 3}
        },
        requiredJob = "foundry",
        requiredGrade = 0
    }
}

-- Recettes de Bijouterie
Config.JewelryRecipes = {
    -- Taille des pierres précieuses
    {
        label = "Quartz Taillé",
        item = "cut_quartz",
        time = 4000,
        amount = 1,
        requires = {
            {item = "quartz_crystal", amount = 1}
        }
    },
    {
        label = "Émeraude Taillée",
        item = "cut_emerald",
        time = 6000,
        amount = 1,
        requires = {
            {item = "emerald_crystal", amount = 1}
        }
    },
    {
        label = "Rubis Taillé",
        item = "cut_ruby",
        time = 6000,
        amount = 1,
        requires = {
            {item = "ruby_crystal", amount = 1}
        }
    },
    {
        label = "Saphir Rose Taillé",
        item = "cut_pink_sapphire",
        time = 7000,
        amount = 1,
        requires = {
            {item = "pink_sapphire", amount = 1}
        }
    },
    {
        label = "Améthyste Taillée",
        item = "cut_amethyst",
        time = 5000,
        amount = 1,
        requires = {
            {item = "amethyst_geode", amount = 1}
        }
    },
    {
        label = "Diamant Taillé",
        item = "cut_diamond",
        time = 10000,
        amount = 1,
        requires = {
            {item = "diamond_crystal", amount = 1}
        }
    },
    {
        label = "Diamant Bleu Taillé",
        item = "cut_blue_diamond",
        time = 12000,
        amount = 1,
        requires = {
            {item = "blue_diamond", amount = 1}
        }
    },

    -- Fabrication de bijoux en or
    {
        label = "Bague en Or",
        item = "gold_ring_base",
        time = 5000,
        amount = 1,
        requires = {
            {item = "gold_ingot", amount = 1}
        },
        requiredJob = "foundry",
        requiredGrade = 1
    },
    {
        label = "Collier en Or",
        item = "gold_necklace_base",
        time = 6000,
        amount = 1,
        requires = {
            {item = "gold_ingot", amount = 2}
        },
        requiredJob = "foundry",
        requiredGrade = 1
    },
    {
        label = "Boucles d'Oreille en Or",
        item = "gold_earrings_base",
        time = 5000,
        amount = 1,
        requires = {
            {item = "gold_ingot", amount = 1}
        },
        requiredJob = "foundry",
        requiredGrade = 1
    },

    -- Bijoux avec pierres précieuses - Émeraude (Vert)
    {
        label = "Bague Émeraude",
        item = "emerald_ring",
        time = 8000,
        amount = 1,
        requires = {
            {item = "gold_ring_base", amount = 1},
            {item = "cut_emerald", amount = 1}
        },
        requiredJob = "foundry",
        requiredGrade = 2
    },
    {
        label = "Collier Émeraude",
        item = "emerald_necklace",
        time = 9000,
        amount = 1,
        requires = {
            {item = "gold_necklace_base", amount = 1},
            {item = "cut_emerald", amount = 2}
        },
        requiredJob = "foundry",
        requiredGrade = 2
    },

    -- Bijoux avec pierres précieuses - Rubis (Rouge)
    {
        label = "Bague Rubis",
        item = "ruby_ring",
        time = 8000,
        amount = 1,
        requires = {
            {item = "gold_ring_base", amount = 1},
            {item = "cut_ruby", amount = 1}
        },
        requiredJob = "foundry",
        requiredGrade = 2
    },
    {
        label = "Collier Rubis",
        item = "ruby_necklace",
        time = 9000,
        amount = 1,
        requires = {
            {item = "gold_necklace_base", amount = 1},
            {item = "cut_ruby", amount = 2}
        },
        requiredJob = "foundry",
        requiredGrade = 2
    },

    -- Bijoux avec pierres précieuses - Saphir Rose (Rose)
    {
        label = "Bague Saphir Rose",
        item = "pink_sapphire_ring",
        time = 9000,
        amount = 1,
        requires = {
            {item = "gold_ring_base", amount = 1},
            {item = "cut_pink_sapphire", amount = 1}
        },
        requiredJob = "foundry",
        requiredGrade = 2
    },
    {
        label = "Collier Saphir Rose",
        item = "pink_sapphire_necklace",
        time = 10000,
        amount = 1,
        requires = {
            {item = "gold_necklace_base", amount = 1},
            {item = "cut_pink_sapphire", amount = 2}
        },
        requiredJob = "foundry",
        requiredGrade = 2
    },

    -- Bijoux avec pierres précieuses - Améthyste (Violet)
    {
        label = "Bague Améthyste",
        item = "amethyst_ring",
        time = 8000,
        amount = 1,
        requires = {
            {item = "gold_ring_base", amount = 1},
            {item = "cut_amethyst", amount = 1}
        },
        requiredJob = "foundry",
        requiredGrade = 2
    },
    {
        label = "Collier Améthyste",
        item = "amethyst_necklace",
        time = 9000,
        amount = 1,
        requires = {
            {item = "gold_necklace_base", amount = 1},
            {item = "cut_amethyst", amount = 2}
        },
        requiredJob = "foundry",
        requiredGrade = 2
    },

    -- Bijoux avec pierres précieuses - Diamant (Blanc)
    {
        label = "Bague Diamant",
        item = "diamond_ring",
        time = 12000,
        amount = 1,
        requires = {
            {item = "gold_ring_base", amount = 1},
            {item = "cut_diamond", amount = 1}
        },
        requiredJob = "foundry",
        requiredGrade = 2
    },
    {
        label = "Collier Diamant",
        item = "diamond_necklace",
        time = 14000,
        amount = 1,
        requires = {
            {item = "gold_necklace_base", amount = 1},
            {item = "cut_diamond", amount = 2}
        },
        requiredJob = "foundry",
        requiredGrade = 2
    },
    {
        label = "Boucles d'Oreille Diamant",
        item = "diamond_earrings",
        time = 13000,
        amount = 1,
        requires = {
            {item = "gold_earrings_base", amount = 1},
            {item = "cut_diamond", amount = 2}
        },
        requiredJob = "foundry",
        requiredGrade = 2
    },

    -- Bijoux avec pierres précieuses - Diamant Bleu (Bleu)
    {
        label = "Bague Diamant Bleu",
        item = "blue_diamond_ring",
        time = 15000,
        amount = 1,
        requires = {
            {item = "gold_ring_base", amount = 1},
            {item = "cut_blue_diamond", amount = 1}
        },
        requiredJob = "foundry",
        requiredGrade = 2
    },
    {
        label = "Collier Diamant Bleu",
        item = "blue_diamond_necklace",
        time = 17000,
        amount = 1,
        requires = {
            {item = "gold_necklace_base", amount = 1},
            {item = "cut_blue_diamond", amount = 2}
        },
        requiredJob = "foundry",
        requiredGrade = 2
    }
}

-- Prix d'exportation (en $)
Config.ExportPrices = {
    -- Lingots
    iron_ingot = 150,
    steel_ingot = 300,
    copper_ingot = 200,
    gold_ingot = 800,

    -- Pierres taillées
    cut_quartz = 100,
    cut_emerald = 500,
    cut_ruby = 600,
    cut_pink_sapphire = 700,
    cut_amethyst = 450,
    cut_diamond = 1200,
    cut_blue_diamond = 1800,

    -- Bijoux de base
    gold_ring_base = 600,
    gold_necklace_base = 1000,
    gold_earrings_base = 700,

    -- Bijoux avec pierres - Émeraude
    emerald_ring = 1500,
    emerald_necklace = 2500,

    -- Bijoux avec pierres - Rubis
    ruby_ring = 1700,
    ruby_necklace = 2800,

    -- Bijoux avec pierres - Saphir Rose
    pink_sapphire_ring = 2000,
    pink_sapphire_necklace = 3200,

    -- Bijoux avec pierres - Améthyste
    amethyst_ring = 1300,
    amethyst_necklace = 2200,

    -- Bijoux avec pierres - Diamant
    diamond_ring = 3000,
    diamond_necklace = 5000,
    diamond_earrings = 4000,

    -- Bijoux avec pierres - Diamant Bleu
    blue_diamond_ring = 4500,
    blue_diamond_necklace = 7500,

    -- Items pour véhicules
    engine = 2500,
    turbo = 1800,
    suspension = 1200,
    brakes = 900,
    repair_kit = 400
}

-- Items exportables (liste des items qu'on peut vendre)
Config.ExportableItems = {
    -- Lingots
    'iron_ingot', 'steel_ingot', 'copper_ingot', 'gold_ingot',

    -- Pierres taillées
    'cut_quartz', 'cut_emerald', 'cut_ruby', 'cut_pink_sapphire',
    'cut_amethyst', 'cut_diamond', 'cut_blue_diamond',

    -- Bijoux de base
    'gold_ring_base', 'gold_necklace_base', 'gold_earrings_base',

    -- Bijoux avec pierres
    'emerald_ring', 'emerald_necklace',
    'ruby_ring', 'ruby_necklace',
    'pink_sapphire_ring', 'pink_sapphire_necklace',
    'amethyst_ring', 'amethyst_necklace',
    'diamond_ring', 'diamond_necklace', 'diamond_earrings',
    'blue_diamond_ring', 'blue_diamond_necklace',

    -- Items pour véhicules
    'engine', 'turbo', 'suspension', 'brakes', 'repair_kit'
}
