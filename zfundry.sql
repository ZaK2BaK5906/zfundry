-- =====================================================
-- ZFundry - Script de Fonderie & Bijouterie
-- Installation SQL
-- =====================================================

-- Ajouter le job Fonderie
INSERT INTO `jobs` (`name`, `label`) VALUES
('foundry', 'Fonderie');

-- Ajouter les grades du job
INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_female`) VALUES
('foundry', 0, 'apprentice', 'Apprenti Fondeur', 250, '{}', '{}'),
('foundry', 1, 'worker', 'Ouvrier Fondeur', 400, '{}', '{}'),
('foundry', 2, 'boss', 'Patron Fonderie', 600, '{}', '{}');

-- Créer l'entreprise (société)
INSERT INTO `addon_account` (`name`, `label`, `shared`) VALUES
('society_foundry', 'Fonderie', 1);

INSERT INTO `datastore` (`name`, `label`, `shared`) VALUES
('society_foundry', 'Fonderie', 1);

INSERT INTO `addon_inventory` (`name`, `label`, `shared`) VALUES
('society_foundry', 'Fonderie', 1);

-- =====================================================
-- Items pour ox_inventory
-- À AJOUTER MANUELLEMENT dans ox_inventory/data/items.lua
-- =====================================================

--[[

-- ========== MATÉRIAUX DE BASE ==========

['iron_ore'] = {
    label = 'Minerai de Fer',
    weight = 800,
    stack = true,
    close = true,
    description = 'Minerai brut de fer extrait de la mine',
    client = {
        image = 'iron_ore.png',
    }
},

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

['kevlar_fiber'] = {
    label = 'Fibre de Kevlar',
    weight = 200,
    stack = true,
    close = true,
    description = 'Fibre de kevlar pour gilets pare-balles',
    client = {
        image = 'kevlar_fiber.png',
    }
},

['confiscated_weapon'] = {
    label = 'Arme Confisquée',
    weight = 2000,
    stack = true,
    close = true,
    description = 'Arme illégale confisquée par la police',
    client = {
        image = 'confiscated_weapon.png',
    }
},

-- ========== LINGOTS & MATÉRIAUX TRANSFORMÉS ==========

['iron_ingot'] = {
    label = 'Lingot de Fer',
    weight = 1000,
    stack = true,
    close = true,
    description = 'Lingot de fer purifié',
    client = {
        image = 'iron_ingot.png',
    }
},

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

['steel_ingot'] = {
    label = 'Lingot d\'Acier',
    weight = 1200,
    stack = true,
    close = true,
    description = 'Lingot d\'acier raffiné',
    client = {
        image = 'steel_ingot.png',
    }
},

['copper_ingot'] = {
    label = 'Lingot de Cuivre',
    weight = 900,
    stack = true,
    close = true,
    description = 'Lingot de cuivre pur',
    client = {
        image = 'copper_ingot.png',
    }
},

['copper_wire'] = {
    label = 'Fil de Cuivre',
    weight = 100,
    stack = true,
    close = true,
    description = 'Fil de cuivre pour électronique',
    client = {
        image = 'copper_wire.png',
    }
},

['gold_ingot'] = {
    label = 'Lingot d\'Or',
    weight = 1500,
    stack = true,
    close = true,
    description = 'Lingot d\'or pur 24 carats',
    client = {
        image = 'gold_ingot.png',
    }
},

-- ========== ITEMS HÔPITAL ==========

['crutches'] = {
    label = 'Béquilles',
    weight = 1500,
    stack = false,
    close = true,
    description = 'Béquilles pour aider à la marche',
    client = {
        image = 'crutches.png',
    }
},

['wheelchair'] = {
    label = 'Fauteuil Roulant',
    weight = 8000,
    stack = false,
    close = true,
    description = 'Fauteuil roulant médical',
    client = {
        image = 'wheelchair.png',
    }
},

['bulletproof_vest_medical'] = {
    label = 'Gilet Par-Balles (Médical)',
    weight = 3000,
    stack = false,
    close = true,
    description = 'Gilet pare-balles pour le personnel médical',
    client = {
        image = 'bulletproof_vest.png',
    }
},

-- ========== ITEMS POLICE ==========

['bulletproof_vest_police'] = {
    label = 'Gilet Par-Balles (Police)',
    weight = 3000,
    stack = false,
    close = true,
    description = 'Gilet pare-balles pour les forces de l\'ordre',
    client = {
        image = 'bulletproof_vest.png',
    }
},

-- ========== ITEMS GOUVERNEMENT ==========

['bulletproof_vest_gov'] = {
    label = 'Gilet Par-Balles (Gouvernement)',
    weight = 3000,
    stack = false,
    close = true,
    description = 'Gilet pare-balles pour le gouvernement',
    client = {
        image = 'bulletproof_vest.png',
    }
},

-- ========== ITEMS MÉCANO ==========

['engine'] = {
    label = 'Moteur',
    weight = 15000,
    stack = true,
    close = true,
    description = 'Moteur pour véhicule',
    client = {
        image = 'engine.png',
    }
},

['turbo'] = {
    label = 'Turbo',
    weight = 8000,
    stack = true,
    close = true,
    description = 'Turbocompresseur pour amélioration moteur',
    client = {
        image = 'turbo.png',
    }
},

['suspension'] = {
    label = 'Suspension',
    weight = 10000,
    stack = true,
    close = true,
    description = 'Kit de suspension pour véhicule',
    client = {
        image = 'suspension.png',
    }
},

['brakes'] = {
    label = 'Freins',
    weight = 6000,
    stack = true,
    close = true,
    description = 'Système de freinage complet',
    client = {
        image = 'brakes.png',
    }
},

['repair_kit'] = {
    label = 'Kit de Réparation',
    weight = 3000,
    stack = true,
    close = true,
    description = 'Kit de réparation pour véhicules',
    client = {
        image = 'repair_kit.png',
    }
},

-- ========== PIERRES TAILLÉES ==========

['cut_quartz'] = {
    label = 'Quartz Taillé',
    weight = 50,
    stack = true,
    close = true,
    description = 'Quartz taillé et poli',
    client = {
        image = 'cut_quartz.png',
    }
},

['cut_emerald'] = {
    label = 'Émeraude Taillée',
    weight = 50,
    stack = true,
    close = true,
    description = 'Émeraude taillée et polie',
    client = {
        image = 'cut_emerald.png',
    }
},

['cut_ruby'] = {
    label = 'Rubis Taillé',
    weight = 50,
    stack = true,
    close = true,
    description = 'Rubis taillé et poli',
    client = {
        image = 'cut_ruby.png',
    }
},

['cut_pink_sapphire'] = {
    label = 'Saphir Rose Taillé',
    weight = 50,
    stack = true,
    close = true,
    description = 'Saphir rose taillé et poli',
    client = {
        image = 'cut_pink_sapphire.png',
    }
},

['cut_amethyst'] = {
    label = 'Améthyste Taillée',
    weight = 50,
    stack = true,
    close = true,
    description = 'Améthyste taillée et polie',
    client = {
        image = 'cut_amethyst.png',
    }
},

['cut_diamond'] = {
    label = 'Diamant Taillé',
    weight = 50,
    stack = true,
    close = true,
    description = 'Diamant taillé et poli',
    client = {
        image = 'cut_diamond.png',
    }
},

['cut_blue_diamond'] = {
    label = 'Diamant Bleu Taillé',
    weight = 50,
    stack = true,
    close = true,
    description = 'Diamant bleu rare taillé et poli',
    client = {
        image = 'cut_blue_diamond.png',
    }
},

-- ========== BIJOUX DE BASE ==========

['gold_ring_base'] = {
    label = 'Bague en Or',
    weight = 100,
    stack = true,
    close = true,
    description = 'Bague en or sans pierre',
    client = {
        image = 'gold_ring.png',
    }
},

['gold_necklace_base'] = {
    label = 'Collier en Or',
    weight = 150,
    stack = true,
    close = true,
    description = 'Collier en or sans pierre',
    client = {
        image = 'gold_necklace.png',
    }
},

['gold_earrings_base'] = {
    label = 'Boucles d\'Oreille en Or',
    weight = 80,
    stack = true,
    close = true,
    description = 'Boucles d\'oreille en or sans pierre',
    client = {
        image = 'gold_earrings.png',
    }
},

-- ========== BIJOUX AVEC ÉMERAUDE ==========

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

['emerald_necklace'] = {
    label = 'Collier Émeraude',
    weight = 200,
    stack = true,
    close = true,
    description = 'Collier en or serti d\'émeraudes',
    client = {
        image = 'emerald_necklace.png',
    }
},

-- ========== BIJOUX AVEC RUBIS ==========

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

['ruby_necklace'] = {
    label = 'Collier Rubis',
    weight = 200,
    stack = true,
    close = true,
    description = 'Collier en or serti de rubis',
    client = {
        image = 'ruby_necklace.png',
    }
},

-- ========== BIJOUX AVEC SAPHIR ROSE ==========

['pink_sapphire_ring'] = {
    label = 'Bague Saphir Rose',
    weight = 120,
    stack = true,
    close = true,
    description = 'Bague en or sertie d\'un saphir rose',
    client = {
        image = 'pink_sapphire_ring.png',
    }
},

['pink_sapphire_necklace'] = {
    label = 'Collier Saphir Rose',
    weight = 200,
    stack = true,
    close = true,
    description = 'Collier en or serti de saphirs roses',
    client = {
        image = 'pink_sapphire_necklace.png',
    }
},

-- ========== BIJOUX AVEC AMÉTHYSTE ==========

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

['amethyst_necklace'] = {
    label = 'Collier Améthyste',
    weight = 200,
    stack = true,
    close = true,
    description = 'Collier en or serti d\'améthystes',
    client = {
        image = 'amethyst_necklace.png',
    }
},

-- ========== BIJOUX AVEC DIAMANT ==========

['diamond_ring'] = {
    label = 'Bague Diamant',
    weight = 120,
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

['diamond_earrings'] = {
    label = 'Boucles d\'Oreille Diamant',
    weight = 100,
    stack = true,
    close = true,
    description = 'Boucles d\'oreille en or serties de diamants',
    client = {
        image = 'diamond_earrings.png',
    }
},

-- ========== BIJOUX AVEC DIAMANT BLEU ==========

['blue_diamond_ring'] = {
    label = 'Bague Diamant Bleu',
    weight = 120,
    stack = true,
    close = true,
    description = 'Bague en or sertie d\'un diamant bleu rare',
    client = {
        image = 'blue_diamond_ring.png',
    }
},

['blue_diamond_necklace'] = {
    label = 'Collier Diamant Bleu',
    weight = 200,
    stack = true,
    close = true,
    description = 'Collier en or serti de diamants bleus rares',
    client = {
        image = 'blue_diamond_necklace.png',
    }
},

]]--
