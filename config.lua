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
            Scale = 0.5,
            Label = "Fonderie"
        },
        Position = vector3(2522.05, 4123.94, 38.77)
    },
    Jewelry = {
        Blip = {
            Enabled = true,
            Sprite = 617,
            Color = 5,
            Scale = 0.5,
            Label = "Bijouterie Fonderie"
        },
        Position = vector3(2531.70, 4118.53, 38.96)
    },
    Export = {
        Blip = {
            Enabled = true,
            Sprite = 478,
            Color = 2,
            Scale = 0.5,
            Label = "Point d'Exportation"
        },
        Position = vector3(2538.45, 4113.38, 38.96)
    },
    Garage = {
        Blip = {
            Enabled = true,
            Sprite = 50,
            Color = 46,
            Scale = 0.5,
            Label = "Garage Fonderie"
        },
        Position = vector3(2528.82, 4112.27, 38.87),
        SpawnPoint = vector4(2531.7524, 4113.0405, 38.7625, 227.8244)
    }
}

-- Véhicules de société
Config.Vehicles = {
    {label = 'Mule', model = 'mule', price = 0, category = 'transport'},
    {label = 'Caracara 2', model = 'caracara2', price = 0, category = 'utility'}
}

-- ═══════════════════════════════════════════════════════════════
-- RECETTES DE FONDERIE
-- ═══════════════════════════════════════════════════════════════

Config.FoundryRecipes = {
    -- ─────────────────────────────────────────────────────────
    -- BARRES ET LINGOTS DE BASE
    -- ─────────────────────────────────────────────────────────
    {
        label = "Barre d'Acier",
        item = "steel_bar",
        time = 8000,
        amount = 1,
        requires = {
            {item = "iron_ore", amount = 3},
            {item = "coal_ore", amount = 2},
            {item = "scrapmetal", amount = 1}
        },
        requiredGrade = 0
    },

    -- ─────────────────────────────────────────────────────────
    -- LINGOTS D'INVESTISSEMENT (Pour le marché boursier)
    -- ─────────────────────────────────────────────────────────
    {
        label = "Lingot d'Or",
        item = "gold_ingot",
        time = 12000,
        amount = 1,
        requires = {
            {item = "gold_nugget", amount = 5},
            {item = "gold_dust", amount = 3},
            {item = "coal_ore", amount = 2}
        },
        requiredGrade = 0
    },
    {
        label = "Lingot d'Argent",
        item = "silver_ingot",
        time = 10000,
        amount = 1,
        requires = {
            {item = "quartz_crystal", amount = 4},
            {item = "flint", amount = 2},
            {item = "coal_ore", amount = 2}
        },
        requiredGrade = 0
    },
    {
        label = "Lingot de Platine",
        item = "platinum_ingot",
        time = 15000,
        amount = 1,
        requires = {
            {item = "clear_crystal", amount = 6},
            {item = "graphite_chunk", amount = 3},
            {item = "sulfur_chunk", amount = 2},
            {item = "coal_ore", amount = 3}
        },
        requiredGrade = 1
    },
    {
        label = "Lingot de Cuivre",
        item = "copper_ingot",
        time = 6000,
        amount = 1,
        requires = {
            {item = "copper_wire", amount = 5},
            {item = "coal_ore", amount = 1}
        },
        requiredGrade = 0
    }
}

-- ═══════════════════════════════════════════════════════════════
-- RECETTES DE BIJOUTERIE
-- ═══════════════════════════════════════════════════════════════

Config.JewelryRecipes = {
    -- ─────────────────────────────────────────────────────────
    -- TAILLE DES PIERRES PRÉCIEUSES
    -- ─────────────────────────────────────────────────────────
    {
        label = "Émeraude Taillée",
        item = "cut_emerald",
        time = 5000,
        amount = 1,
        requires = {
            {item = "emerald_crystal", amount = 1},
            {item = "beryl_chunk", amount = 1},
            {item = "green_garnet", amount = 1}
        },
        requiredGrade = 0
    },
    {
        label = "Rubis Taillé",
        item = "cut_ruby",
        time = 5000,
        amount = 1,
        requires = {
            {item = "ruby_crystal", amount = 1},
            {item = "corundum_chunk", amount = 1}
        },
        requiredGrade = 0
    },
    {
        label = "Saphir Taillé",
        item = "cut_sapphire",
        time = 5000,
        amount = 1,
        requires = {
            {item = "pink_sapphire", amount = 1},
            {item = "corundum_chunk", amount = 1}
        },
        requiredGrade = 0
    },
    {
        label = "Améthyste Taillée",
        item = "cut_amethyst",
        time = 5000,
        amount = 1,
        requires = {
            {item = "amethyst_geode", amount = 1},
            {item = "purple_quartz", amount = 1}
        },
        requiredGrade = 0
    },
    {
        label = "Diamant Taillé",
        item = "cut_diamond",
        time = 8000,
        amount = 1,
        requires = {
            {item = "diamond_crystal", amount = 1},
            {item = "clear_crystal", amount = 1},
            {item = "graphite_chunk", amount = 1}
        },
        requiredGrade = 0
    },
    {
        label = "Diamant Bleu Taillé",
        item = "cut_blue_diamond",
        time = 12000,
        amount = 1,
        requires = {
            {item = "blue_diamond", amount = 1},
            {item = "diamond_crystal", amount = 2},
            {item = "clear_crystal", amount = 2}
        },
        requiredGrade = 1
    },

    -- ─────────────────────────────────────────────────────────
    -- BIJOUX EN OR (Bases)
    -- ─────────────────────────────────────────────────────────
    {
        label = "Bague en Or",
        item = "gold_ring",
        time = 6000,
        amount = 1,
        requires = {
            {item = "gold_ingot", amount = 1},
            {item = "gold_nugget", amount = 2}
        },
        requiredGrade = 0
    },
    {
        label = "Collier en Or",
        item = "gold_necklace",
        time = 8000,
        amount = 1,
        requires = {
            {item = "gold_ingot", amount = 1},
            {item = "gold_nugget", amount = 3},
            {item = "copper_wire", amount = 1}
        },
        requiredGrade = 0
    },

    -- ─────────────────────────────────────────────────────────
    -- BIJOUX EN OR AVEC PIERRES
    -- ─────────────────────────────────────────────────────────
    {
        label = "Bague Émeraude",
        item = "emerald_ring",
        time = 10000,
        amount = 1,
        requires = {
            {item = "gold_ring", amount = 1},
            {item = "cut_emerald", amount = 1}
        },
        requiredGrade = 0
    },
    {
        label = "Bague Rubis",
        item = "ruby_ring",
        time = 10000,
        amount = 1,
        requires = {
            {item = "gold_ring", amount = 1},
            {item = "cut_ruby", amount = 1}
        },
        requiredGrade = 0
    },
    {
        label = "Bague Saphir",
        item = "sapphire_ring",
        time = 10000,
        amount = 1,
        requires = {
            {item = "gold_ring", amount = 1},
            {item = "cut_sapphire", amount = 1}
        },
        requiredGrade = 0
    },
    {
        label = "Bague Améthyste",
        item = "amethyst_ring",
        time = 10000,
        amount = 1,
        requires = {
            {item = "gold_ring", amount = 1},
            {item = "cut_amethyst", amount = 1}
        },
        requiredGrade = 0
    },
    {
        label = "Bague Diamant",
        item = "diamond_ring",
        time = 15000,
        amount = 1,
        requires = {
            {item = "gold_ring", amount = 1},
            {item = "cut_diamond", amount = 1}
        },
        requiredGrade = 1
    },
    {
        label = "Collier Diamant",
        item = "diamond_necklace",
        time = 18000,
        amount = 1,
        requires = {
            {item = "gold_necklace", amount = 1},
            {item = "cut_diamond", amount = 3}
        },
        requiredGrade = 1
    },
    {
        label = "Bague Diamant Bleu",
        item = "blue_diamond_ring",
        time = 20000,
        amount = 1,
        requires = {
            {item = "gold_ring", amount = 1},
            {item = "cut_blue_diamond", amount = 1}
        },
        requiredGrade = 1
    }
}

-- ═══════════════════════════════════════════════════════════════
-- PRIX D'EXPORT
-- ═══════════════════════════════════════════════════════════════

Config.ExportPrices = {
    -- Barres et lingots de base
    steel_bar = 500,

    -- Lingots d'investissement (prix fixes pour l'export, le marché utilise son propre système)
    gold_ingot = 8000,
    silver_ingot = 2000,
    platinum_ingot = 12000,
    copper_ingot = 600,

    -- Pierres taillées
    cut_emerald = 800,
    cut_ruby = 900,
    cut_sapphire = 850,
    cut_amethyst = 750,
    cut_diamond = 1500,
    cut_blue_diamond = 2500,

    -- Bijoux bases
    gold_ring = 1200,
    gold_necklace = 1800,

    -- Bijoux avec pierres
    emerald_ring = 2200,
    ruby_ring = 2400,
    sapphire_ring = 2300,
    amethyst_ring = 2000,
    diamond_ring = 3500,
    diamond_necklace = 6000,
    blue_diamond_ring = 5500
}
