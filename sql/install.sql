-- ═══════════════════════════════════════════════════════════════
-- ZFUNDRY - INSTALL SQL
-- Installation propre de la base de données
-- Version: 3.0.0
-- ═══════════════════════════════════════════════════════════════

-- ─────────────────────────────────────────────────────────────
-- JOB: Fonderie
-- ─────────────────────────────────────────────────────────────
INSERT INTO `jobs` (name, label, whitelisted) VALUES
('foundry', 'Fonderie', 1);

-- ─────────────────────────────────────────────────────────────
-- GRADES: 3 niveaux
-- ─────────────────────────────────────────────────────────────
INSERT INTO `job_grades` (job_name, grade, name, label, salary, skin_male, skin_female) VALUES
('foundry', 0, 'apprentice', 'Apprenti Fondeur', 250, '{}', '{}'),
('foundry', 1, 'worker', 'Ouvrier Fondeur', 400, '{}', '{}'),
('foundry', 2, 'boss', 'Patron Fonderie', 600, '{}', '{}');

-- ─────────────────────────────────────────────────────────────
-- SOCIÉTÉ: Comptes bancaires
-- ─────────────────────────────────────────────────────────────
INSERT INTO `addon_account` (name, label, shared) VALUES
('society_foundry', 'Fonderie', 1);

INSERT INTO `addon_account_data` (account_name, money, owner) VALUES
('society_foundry', 0, NULL);

-- ═══════════════════════════════════════════════════════════════
-- NOTES D'INSTALLATION
-- ═══════════════════════════════════════════════════════════════
--
-- ✅ Job 'foundry' créé avec succès
-- ✅ 3 grades configurés (Apprenti, Ouvrier, Patron)
-- ✅ Compte société initialisé à 0$
--
-- PROCHAINES ÉTAPES:
-- 1. Copier les items de items.lua dans ox_inventory
-- 2. Configurer les positions dans config.lua
-- 3. Restart le serveur
-- 4. Utiliser /setfoundry [ID] [grade] pour attribuer le job
--
-- COMMANDES UTILES:
-- /setfoundry 1 0  -- Donner le grade Apprenti au joueur ID 1
-- /setfoundry 1 1  -- Donner le grade Ouvrier au joueur ID 1
-- /setfoundry 1 2  -- Donner le grade Patron au joueur ID 1
--
-- ═══════════════════════════════════════════════════════════════
