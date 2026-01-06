-- ═══════════════════════════════════════════════════════════════
-- ZFUNDRY - Items pour ox_inventory (Version Finale)
-- Fonderie & Bijouterie + Système de Lingots
-- ═══════════════════════════════════════════════════════════════

-- ─────────────────────────────────────────────────────────────
-- 📦 MATÉRIAUX DE BASE (Matières premières)
-- ─────────────────────────────────────────────────────────────
['scrapmetal'] = {
    label = 'Ferraille',
    weight = 500,
    stack = true,
    close = true,
    description = 'Morceaux de métal récupérés',
    client = {
        image = 'scrapmetal.png',
    }
},

['iron_ore'] = {
    label = 'Minerai de Fer',
    weight = 800,
    stack = true,
    close = true,
    description = 'Minerai brut de fer',
    client = {
        image = 'iron_ore.png',
    }
},

['coal_ore'] = {
    label = 'Charbon',
    weight = 600,
    stack = true,
    close = true,
    description = 'Charbon brut pour la fonte',
    client = {
        image = 'coal_ore.png',
    }
},

['flint'] = {
    label = 'Silex',
    weight = 200,
    stack = true,
    close = true,
    description = 'Pierre de silex',
    client = {
        image = 'flint.png',
    }
},

['sulfur_chunk'] = {
    label = 'Soufre',
    weight = 400,
    stack = true,
    close = true,
    description = 'Morceau de soufre',
    client = {
        image = 'sulfur_chunk.png',
    }
},

['copper_wire'] = {
    label = 'Fil de Cuivre',
    weight = 300,
    stack = true,
    close = true,
    description = 'Fil de cuivre conducteur',
    client = {
        image = 'copper_wire.png',
    }
},

-- ─────────────────────────────────────────────────────────────
-- 💰 MÉTAUX PRÉCIEUX BRUTS
-- ─────────────────────────────────────────────────────────────
['gold_nugget'] = {
    label = 'Pépite d\'Or',
    weight = 250,
    stack = true,
    close = true,
    description = 'Pépite d\'or brut',
    client = {
        image = 'gold_nugget.png',
    }
},

['gold_dust'] = {
    label = 'Poussière d\'Or',
    weight = 100,
    stack = true,
    close = true,
    description = 'Poussière d\'or fin',
    client = {
        image = 'gold_dust.png',
    }
},

-- ─────────────────────────────────────────────────────────────
-- 💎 CRISTAUX ET PIERRES PRÉCIEUSES
-- ─────────────────────────────────────────────────────────────
['quartz_crystal'] = {
    label = 'Cristal de Quartz',
    weight = 150,
    stack = true,
    close = true,
    description = 'Cristal de quartz transparent',
    client = {
        image = 'quartz_crystal.png',
    }
},

['emerald_crystal'] = {
    label = 'Cristal d\'Émeraude',
    weight = 200,
    stack = true,
    close = true,
    description = 'Cristal d\'émeraude vert',
    client = {
        image = 'emerald_crystal.png',
    }
},

['beryl_chunk'] = {
    label = 'Béryl',
    weight = 180,
    stack = true,
    close = true,
    description = 'Morceau de béryl',
    client = {
        image = 'beryl_chunk.png',
    }
},

['green_garnet'] = {
    label = 'Grenat Vert',
    weight = 170,
    stack = true,
    close = true,
    description = 'Grenat de couleur verte',
    client = {
        image = 'green_garnet.png',
    }
},

['ruby_crystal'] = {
    label = 'Cristal de Rubis',
    weight = 200,
    stack = true,
    close = true,
    description = 'Cristal de rubis rouge',
    client = {
        image = 'ruby_crystal.png',
    }
},

['corundum_chunk'] = {
    label = 'Corindon',
    weight = 190,
    stack = true,
    close = true,
    description = 'Morceau de corindon',
    client = {
        image = 'corundum_chunk.png',
    }
},

['pink_sapphire'] = {
    label = 'Saphir Rose',
    weight = 200,
    stack = true,
    close = true,
    description = 'Saphir de couleur rose',
    client = {
        image = 'pink_sapphire.png',
    }
},

['amethyst_geode'] = {
    label = 'Géode d\'Améthyste',
    weight = 220,
    stack = true,
    close = true,
    description = 'Géode contenant de l\'améthyste',
    client = {
        image = 'amethyst_geode.png',
    }
},

['purple_quartz'] = {
    label = 'Quartz Violet',
    weight = 160,
    stack = true,
    close = true,
    description = 'Quartz de couleur violette',
    client = {
        image = 'purple_quartz.png',
    }
},

['clear_crystal'] = {
    label = 'Cristal Clair',
    weight = 150,
    stack = true,
    close = true,
    description = 'Cristal parfaitement transparent',
    client = {
        image = 'clear_crystal.png',
    }
},

['diamond_crystal'] = {
    label = 'Cristal de Diamant',
    weight = 250,
    stack = true,
    close = true,
    description = 'Cristal de diamant brut',
    client = {
        image = 'diamond_crystal.png',
    }
},

['graphite_chunk'] = {
    label = 'Graphite',
    weight = 180,
    stack = true,
    close = true,
    description = 'Morceau de graphite',
    client = {
        image = 'graphite_chunk.png',
    }
},

['blue_diamond'] = {
    label = 'Diamant Bleu',
    weight = 300,
    stack = true,
    close = true,
    description = 'Diamant bleu extrêmement rare',
    client = {
        image = 'blue_diamond.png',
    }
},

-- ─────────────────────────────────────────────────────────────
-- 🔨 BARRES ET MATÉRIAUX TRANSFORMÉS
-- ─────────────────────────────────────────────────────────────
['steel_bar'] = {
    label = 'Barre d\'Acier',
    weight = 1000,
    stack = true,
    close = true,
    description = 'Barre d\'acier de haute qualité',
    client = {
        image = 'steel_bar.png',
    }
},

-- ─────────────────────────────────────────────────────────────
-- 💰 LINGOTS D'INVESTISSEMENT (Système de marché)
-- ─────────────────────────────────────────────────────────────
['gold_ingot'] = {
    label = 'Lingot d\'Or',
    weight = 1000,
    stack = true,
    close = true,
    description = 'Lingot d\'or pur 24 carats - Valeur boursière',
    client = {
        image = 'gold_ingot.png',
    }
},

['silver_ingot'] = {
    label = 'Lingot d\'Argent',
    weight = 800,
    stack = true,
    close = true,
    description = 'Lingot d\'argent pur - Valeur boursière',
    client = {
        image = 'silver_ingot.png',
    }
},

['platinum_ingot'] = {
    label = 'Lingot de Platine',
    weight = 1200,
    stack = true,
    close = true,
    description = 'Lingot de platine pur - Très haute valeur',
    client = {
        image = 'platinum_ingot.png',
    }
},

['copper_ingot'] = {
    label = 'Lingot de Cuivre',
    weight = 600,
    stack = true,
    close = true,
    description = 'Lingot de cuivre pur - Valeur boursière',
    client = {
        image = 'copper_ingot.png',
    }
},

-- ─────────────────────────────────────────────────────────────
-- 💎 PIERRES PRÉCIEUSES TAILLÉES (Pour bijouterie)
-- ─────────────────────────────────────────────────────────────
['cut_emerald'] = {
    label = 'Émeraude Taillée',
    weight = 50,
    stack = true,
    close = true,
    description = 'Émeraude taillée pour bijouterie',
    client = {
        image = 'cut_emerald.png',
    }
},

['cut_ruby'] = {
    label = 'Rubis Taillé',
    weight = 50,
    stack = true,
    close = true,
    description = 'Rubis taillé pour bijouterie',
    client = {
        image = 'cut_ruby.png',
    }
},

['cut_sapphire'] = {
    label = 'Saphir Taillé',
    weight = 50,
    stack = true,
    close = true,
    description = 'Saphir rose taillé pour bijouterie',
    client = {
        image = 'cut_sapphire.png',
    }
},

['cut_amethyst'] = {
    label = 'Améthyste Taillée',
    weight = 50,
    stack = true,
    close = true,
    description = 'Améthyste taillée pour bijouterie',
    client = {
        image = 'cut_amethyst.png',
    }
},

['cut_diamond'] = {
    label = 'Diamant Taillé',
    weight = 60,
    stack = true,
    close = true,
    description = 'Diamant taillé pour bijouterie',
    client = {
        image = 'cut_diamond.png',
    }
},

['cut_blue_diamond'] = {
    label = 'Diamant Bleu Taillé',
    weight = 70,
    stack = true,
    close = true,
    description = 'Diamant bleu taillé - Extrêmement rare',
    client = {
        image = 'cut_blue_diamond.png',
    }
},

-- ─────────────────────────────────────────────────────────────
-- 💍 BIJOUX FINIS
-- ─────────────────────────────────────────────────────────────
['gold_ring'] = {
    label = 'Bague en Or',
    weight = 100,
    stack = true,
    close = true,
    description = 'Bague en or massif',
    client = {
        image = 'gold_ring.png',
    }
},

['gold_necklace'] = {
    label = 'Collier en Or',
    weight = 150,
    stack = true,
    close = true,
    description = 'Collier en or massif',
    client = {
        image = 'gold_necklace.png',
    }
},

['emerald_ring'] = {
    label = 'Bague Émeraude',
    weight = 120,
    stack = true,
    close = true,
    description = 'Bague en or sertie d\'une émeraude',
    client = {
        image = 'emerald_ring.png',
    }
},

['ruby_ring'] = {
    label = 'Bague Rubis',
    weight = 120,
    stack = true,
    close = true,
    description = 'Bague en or sertie d\'un rubis',
    client = {
        image = 'ruby_ring.png',
    }
},

['sapphire_ring'] = {
    label = 'Bague Saphir',
    weight = 120,
    stack = true,
    close = true,
    description = 'Bague en or sertie d\'un saphir',
    client = {
        image = 'sapphire_ring.png',
    }
},

['amethyst_ring'] = {
    label = 'Bague Améthyste',
    weight = 120,
    stack = true,
    close = true,
    description = 'Bague en or sertie d\'une améthyste',
    client = {
        image = 'amethyst_ring.png',
    }
},

['diamond_ring'] = {
    label = 'Bague Diamant',
    weight = 140,
    stack = true,
    close = true,
    description = 'Bague en or sertie d\'un diamant',
    client = {
        image = 'diamond_ring.png',
    }
},

['diamond_necklace'] = {
    label = 'Collier Diamant',
    weight = 200,
    stack = true,
    close = true,
    description = 'Collier en or serti de diamants',
    client = {
        image = 'diamond_necklace.png',
    }
},

['blue_diamond_ring'] = {
    label = 'Bague Diamant Bleu',
    weight = 160,
    stack = true,
    close = true,
    description = 'Bague en or sertie d\'un diamant bleu rare',
    client = {
        image = 'blue_diamond_ring.png',
    }
},
