-- ═══════════════════════════════════════════════════════════════
-- ZFUNDRY - CLEAN SQL
-- Reset complet de la base de données
-- ATTENTION: Ce script supprime toutes les données existantes!
-- ═══════════════════════════════════════════════════════════════

-- Supprimer le job
DELETE FROM `jobs` WHERE `name` = 'foundry';
DELETE FROM `job_grades` WHERE `job_name` = 'foundry';

-- Supprimer les comptes société
DELETE FROM `addon_account` WHERE `name` = 'society_foundry';
DELETE FROM `addon_account_data` WHERE `account_name` = 'society_foundry';

-- Supprimer les employés actuels
UPDATE `users` SET `job` = 'unemployed', `job_grade` = 0 WHERE `job` = 'foundry';

PRINT '✅ Base de données nettoyée avec succès!';
PRINT '⚠️  Tous les employés foundry ont été renvoyés au chômage';
PRINT '📋 Vous pouvez maintenant exécuter install.sql pour une installation propre';
