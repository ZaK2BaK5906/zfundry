# 🏭 ZFundry - Système de Fonderie, Bijouterie & Marché des Lingots

> Script professionnel de fonderie et bijouterie avec système boursier des lingots pour ESX Legacy

<div align="center">

![Version](https://img.shields.io/badge/version-3.0.0-blue.svg)
![ESX](https://img.shields.io/badge/ESX-Legacy-green.svg)
![License](https://img.shields.io/badge/license-Custom-orange.svg)

</div>

## 📋 Vue d'ensemble

ZFundry est un système complet de fonderie et bijouterie incluant un marché boursier des lingots. Les joueurs peuvent transformer des matières premières en produits finis, créer des bijoux de luxe, et investir dans des lingots dont les cours fluctuent en temps réel.

### ✨ Points Forts

- **39 items uniques** logiques et cohérents
- **Marché boursier dynamique** avec 4 types de lingots
- **Interface tablette moderne** non-responsive (taille fixe)
- **Compatible multi-target** (ox_target, qtarget, qb-target)
- **System de grades** avec restrictions
- **Garage d'entreprise** avec véhicules personnalisables
- **0 dépendances jQuery** - 100% Vanilla JavaScript

---

## 🎯 Fonctionnalités

### 🔨 Fonderie
- Transformation de matières premières en lingots
- Fabrication de barres d'acier
- Système de crafting avec temps de production
- Animation et barre de progression
- Restrictions par grade

### 💎 Bijouterie
- Taille de pierres précieuses (6 types)
- Création de bijoux en or (9 types)
- Système de qualité des pierres
- Export et vente des créations

### 💰 Marché des Lingots (★ NOUVEAU)
Le cœur du système économique permettant aux joueurs et entreprises de stocker leur richesse en lingots dont la valeur fluctue.

**4 Lingots Disponibles:**
- 🥇 **Or** - Prix base: 10,000$ (haute valeur)
- 🥈 **Argent** - Prix base: 2,500$ (moyenne valeur)
- ⚪ **Platine** - Prix base: 15,000$ (très haute valeur)
- 🟤 **Cuivre** - Prix base: 800$ (basse valeur)

**Système Boursier:**
- 📊 Fluctuations automatiques toutes les 10 minutes
- 📈 Variation par cycle: -5% à +5%
- 📉 Limites globales: -15% à +20% du prix de base
- 📜 Historique des 10 dernières valeurs
- 🎯 Tendances en temps réel (↑ hausse / ↓ baisse / → stable)
- 💱 Achat/vente instantanés
- 💼 Stockage de richesse physique

**Commande:**
```
/or - Ouvrir l'interface du marché des lingots
```

### 🎨 Interface Utilisateur

**Design Tablette Dark:**
- Style tablette professionnelle avec bezel
- Fond noir ultra moderne (#0a0a0a)
- Camera notch (style iPad)
- Animations fluides (cubic-bezier)
- **Taille fixe: 1100px × 80vh** (non-responsive)
- Police: Inter (clean et moderne)

**5 Interfaces:**
1. 🔥 **Fonderie** - Crafting des métaux
2. 💎 **Bijouterie** - Création de bijoux
3. 📦 **Export** - Vente des produits
4. 🚗 **Garage** - Gestion des véhicules
5. 📊 **Marché** - Trading de lingots ★

### 🎯 Système Target
- **Auto-détection**: ox_target, qtarget, qb-target
- **Mode debug** intégré (boîtes rouges)
- **Zones configurables** avec min/maxZ
- **Fallback automatique** si playerLoaded rate

### 🗺️ Blips & Zones
- **Blip Fonderie**: Visible par tous (orange, scale 0.5)
- **Blips Job**: Visible uniquement pour les employés
  - Bijouterie (vert)
  - Export (vert)
  - Garage (orange)
- **Positions personnalisables** via config.lua

### 👥 Système de Job

**3 Grades:**
| Grade | Nom | Salaire | Permissions |
|-------|-----|---------|-------------|
| 0 | Apprenti | 250$/h | Recettes de base |
| 1 | Ouvrier | 400$/h | Toutes recettes |
| 2 | Patron | 600$/h | Gestion complète |

### 🚗 Garage Entreprise
- **Véhicules par défaut**: Mule, Caracara2
- **Système de clés**: wasabi_carlock, qb-vehiclekeys
- **Système de fuel**: LegacyFuel, ox_fuel
- **Spawn personnalisé** avec heading
- **Plaque société**: FOUNDRY

---

## 📦 Items (39 au total)

### 🪨 Matériaux de Base (6)
```
scrapmetal      - Ferraille
iron_ore        - Minerai de Fer
coal_ore        - Charbon
flint           - Silex
sulfur_chunk    - Soufre
copper_wire     - Fil de Cuivre
```

### 💰 Métaux Précieux Bruts (2)
```
gold_nugget     - Pépite d'Or
gold_dust       - Poussière d'Or
```

### 💎 Cristaux et Pierres Précieuses (14)
```
quartz_crystal    - Cristal de Quartz
emerald_crystal   - Cristal d'Émeraude
beryl_chunk       - Béryl
green_garnet      - Grenat Vert
ruby_crystal      - Cristal de Rubis
corundum_chunk    - Corindon
pink_sapphire     - Saphir Rose
amethyst_geode    - Géode d'Améthyste
purple_quartz     - Quartz Violet
clear_crystal     - Cristal Clair
diamond_crystal   - Cristal de Diamant
graphite_chunk    - Graphite
blue_diamond      - Diamant Bleu (RARE)
```

### 🔨 Matériaux Transformés (1)
```
steel_bar       - Barre d'Acier
```

### 💰 Lingots d'Investissement (4)
```
gold_ingot      - Lingot d'Or (10,000$ base)
silver_ingot    - Lingot d'Argent (2,500$ base)
platinum_ingot  - Lingot de Platine (15,000$ base)
copper_ingot    - Lingot de Cuivre (800$ base)
```

### 💎 Pierres Taillées (6)
```
cut_emerald       - Émeraude Taillée
cut_ruby          - Rubis Taillé
cut_sapphire      - Saphir Taillé
cut_amethyst      - Améthyste Taillée
cut_diamond       - Diamant Taillé
cut_blue_diamond  - Diamant Bleu Taillé
```

### 💍 Bijoux Finis (9)
```
gold_ring           - Bague en Or
gold_necklace       - Collier en Or
emerald_ring        - Bague Émeraude
ruby_ring           - Bague Rubis
sapphire_ring       - Bague Saphir
amethyst_ring       - Bague Améthyste
diamond_ring        - Bague Diamant
diamond_necklace    - Collier Diamant
blue_diamond_ring   - Bague Diamant Bleu
```

---

## 🛠️ Installation

### Prérequis
```
✅ ESX Legacy
✅ ox_inventory
✅ oxmysql
✅ ox_target OU qtarget OU qb-target
```

### Étape 1: Base de données

**Installation Propre:**
```sql
-- Exécuter: sql/install.sql
```

**Reset Complet (si déjà installé):**
```sql
-- 1. Exécuter: sql/clean.sql
-- 2. Puis: sql/install.sql
```

### Étape 2: Items ox_inventory

Copier **tout le contenu** de `items.lua` dans votre `ox_inventory/data/items.lua`

**Note:** Remplacer les anciennes définitions si elles existent

### Étape 3: Installation du script

1. Placer `zfundry` dans `/resources/`
2. Ajouter dans `server.cfg`:
```cfg
ensure zfundry
```

3. Restart le serveur:
```
restart zfundry
```

### Étape 4: Configuration

Modifier `config.lua` selon vos coordonnées et préférences.

---

## ⚙️ Configuration

### Positions des Zones

```lua
Config.Zones = {
    Foundry = {
        Position = vector3(2522.05, 4123.94, 38.77),
        Blip = {
            Enabled = true,
            Sprite = 478,
            Color = 46,
            Scale = 0.5,
            Label = "Fonderie"
        }
    },
    -- ...
}
```

### Recettes de Crafting

```lua
Config.FoundryRecipes = {
    {
        label = 'Lingot d\'Or',
        item = 'gold_ingot',
        time = 10000, -- 10 secondes
        amount = 1,
        requires = {
            {item = 'gold_nugget', amount = 5},
            {item = 'coal_ore', amount = 2}
        },
        requiredGrade = 0 -- Grade minimum
    }
}
```

### Marché des Lingots

**Paramètres (server/market.lua):**
```lua
-- Prix de base
IngotPrices = {
    gold_ingot = 10000,
    silver_ingot = 2500,
    platinum_ingot = 15000,
    copper_ingot = 800
}

-- Variations
PriceVariation = {
    min = -15,  -- -15%
    max = 20    -- +20%
}

-- Update toutes les 10 minutes (600000ms)
```

---

## 🎮 Utilisation

### Pour les Joueurs

**1. Rejoindre le Job:**
```
/setfoundry [ID] [grade]
```

**2. Crafting:**
- Se rendre aux zones (target ox_target)
- Sélectionner une recette
- Choisir la quantité
- Attendre la fabrication

**3. Trading de Lingots:**
```
/or
```
- Consulter les cours actuels
- Voir les tendances (↑↓→)
- Acheter: Cash → Lingot
- Vendre: Lingot → Cash

**4. Export:**
- Aller au point d'exportation
- Sélectionner les items
- Confirmer la vente

**5. Garage:**
- Sortir un véhicule
- Ranger le véhicule actuel

### Pour le Patron

Accès complet + gestion du marché des lingots pour la société

---

## 📝 Commandes

| Commande | Description | Permission |
|----------|-------------|------------|
| `/or` | Ouvrir le marché des lingots | Tous |
| `/zfdebug` | Informations de debug | Tous |
| `/setfoundry [ID] [grade]` | Attribuer le job | Admin |

---

## 🐛 Dépannage

### Les targets ne s'affichent pas
1. Vérifier ox_target est bien started
2. Taper `/zfdebug` pour voir les infos
3. Vérifier la console F8
4. Mode debug activé = boîtes rouges visibles

### L'UI ne s'ouvre pas
1. Vérifier les erreurs F8
2. S'assurer que le job est correct
3. Restart le script: `restart zfundry`

### Prix des lingots ne changent pas
1. Vérifier la console serveur
2. Le système update toutes les 10 min
3. Forcer un update: restart zfundry

---

## 📊 Structure du Projet

```
zfundry/
├── fxmanifest.lua
├── config.lua
├── README.md
├── items.lua              (ox_inventory items)
├── sql/
│   ├── install.sql       (Installation propre)
│   └── clean.sql         (Reset database)
├── client/
│   └── main.lua
├── server/
│   ├── main.lua
│   ├── export.lua
│   └── market.lua        ★ Système boursier
└── html/
    ├── index.html
    ├── style.css
    └── script.js
```

---

## 🔧 Technologies

- **Framework**: ESX Legacy
- **Database**: oxmysql
- **Inventory**: ox_inventory
- **Target**: ox_target / qtarget / qb-target
- **UI**: Vanilla JavaScript (0 jQuery)
- **Font**: Inter (Google Fonts)

---

## 📄 Licence

Ce script est fourni "tel quel" sans garantie. Libre de modification.

---

## 👥 Crédits

**Développeur**: ZFundry Team
**Version**: 3.0.0
**Date**: 2025-01-06
**Framework**: ESX Legacy

---

<div align="center">

**Développé avec ❤️ pour la communauté FiveM**

[GitHub](https://github.com) • [Discord](#) • [Documentation](#)

</div>
