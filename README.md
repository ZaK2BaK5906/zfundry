# 🔥 ZFundry - Script de Fonderie & Bijouterie

Script complet de fonderie et bijouterie pour FiveM avec UI personnalisée en vanilla JavaScript.

## 📋 Caractéristiques

### 🏭 Système de Fonderie
- Fonte de minerais (fer, acier, cuivre, or)
- Fabrication d'items pour différents jobs
- Recyclage d'armes confisquées
- Système de grades avec permissions

### 💎 Système de Bijouterie
- Taille de pierres précieuses
- Fabrication de bijoux en or
- Bijoux avec pierres serties (émeraude, rubis, saphir rose, améthyste, diamant, diamant bleu)
- Export/vente de bijoux

### 🚗 Garage Société
- Mule (transport)
- Caracara 2 (utilitaire)
- Système de clés compatible

### 💰 Point d'Exportation
- Vente de tous les items fabriqués
- Prix configurables
- Système de vente en masse (optionnel)

### 👔 Items par Catégorie

#### Hôpitaux
- Béquilles
- Fauteuil Roulant
- Gilet Par-Balles (Médical)

#### Forces de l'Ordre
- Gilet Par-Balles (Police)
- Recyclage d'armes confisquées → matières premières

#### Gouvernement
- Gilet Par-Balles (Gouvernement)
- Lingots d'or (réserves)

#### Mécanos
- Moteurs
- Turbo
- Suspension
- Freins
- Kit de Réparation

## 📦 Installation

### 1. Prérequis
- ESX Framework
- ox_inventory
- oxmysql
- esx_society (optionnel mais recommandé)

### 2. Installation du Script

```bash
# 1. Placer le dossier zfundry dans votre dossier resources
cp -r zfundry [votre_serveur]/resources/

# 2. Ajouter dans server.cfg
ensure zfundry
```

### 3. Base de Données

Exécuter le fichier SQL:
```bash
mysql -u votre_utilisateur -p votre_base_de_donnees < zfundry.sql
```

Ou importer manuellement `zfundry.sql` via phpMyAdmin/HeidiSQL.

### 4. Configuration des Items (ox_inventory)

**IMPORTANT:** Copier tous les items du fichier `ox_inventory_items.lua` dans votre fichier `ox_inventory/data/items.lua`

### 5. Images des Items

Placer les images des items dans `ox_inventory/web/images/` avec les noms correspondants:
- `iron_ore.png`
- `scrapmetal.png`
- `kevlar_fiber.png`
- `iron_ingot.png`
- `steel_bar.png`
- `steel_ingot.png`
- `copper_ingot.png`
- `copper_wire.png`
- `gold_ingot.png`
- `crutches.png`
- `wheelchair.png`
- `bulletproof_vest.png`
- `engine.png`
- `turbo.png`
- `suspension.png`
- `brakes.png`
- `repair_kit.png`
- `cut_quartz.png`
- `cut_emerald.png`
- `cut_ruby.png`
- `cut_pink_sapphire.png`
- `cut_amethyst.png`
- `cut_diamond.png`
- `cut_blue_diamond.png`
- `gold_ring.png`
- `gold_necklace.png`
- `gold_earrings.png`
- `emerald_ring.png`
- `emerald_necklace.png`
- `ruby_ring.png`
- `ruby_necklace.png`
- `pink_sapphire_ring.png`
- `pink_sapphire_necklace.png`
- `amethyst_ring.png`
- `amethyst_necklace.png`
- `diamond_ring.png`
- `diamond_necklace.png`
- `diamond_earrings.png`
- `blue_diamond_ring.png`
- `blue_diamond_necklace.png`
- `confiscated_weapon.png`

## ⚙️ Configuration

### Positions des Zones

Modifier les positions dans `config.lua`:

```lua
Config.Zones = {
    Foundry = {
        Position = vector3(1110.45, -2008.38, 35.47), -- Votre position
        -- ...
    },
    -- ... autres zones
}
```

### Recettes de Crafting

Ajouter/modifier des recettes dans `config.lua`:

```lua
Config.FoundryRecipes = {
    {
        label = "Nom de l'Item",
        item = "nom_item",
        time = 5000, -- Temps en ms
        amount = 1, -- Quantité produite
        requires = {
            {item = "ingredient1", amount = 2},
            {item = "ingredient2", amount = 1}
        },
        requiredJob = "foundry", -- Optionnel
        requiredGrade = 1 -- Optionnel
    }
}
```

### Prix d'Exportation

Modifier les prix dans `config.lua`:

```lua
Config.ExportPrices = {
    iron_ingot = 150,
    steel_ingot = 300,
    -- ...
}
```

### Véhicules de Société

Modifier les véhicules dans `config.lua`:

```lua
Config.Vehicles = {
    {label = 'Mule', model = 'mule', price = 0, category = 'transport'},
    {label = 'Caracara 2', model = 'caracara2', price = 0, category = 'utility'}
}
```

## 🎮 Utilisation

### Grades du Job
- **Grade 0** - Apprenti Fondeur (250$/h)
- **Grade 1** - Ouvrier Fondeur (400$/h)
- **Grade 2** - Patron Fonderie (600$/h)

### Commandes Admin

```lua
-- Donner le job Fonderie à un joueur
/setfoundry [ID] [grade]

-- Exemples:
/setfoundry 1 0  -- Donner grade apprenti au joueur ID 1
/setfoundry 2 2  -- Donner grade patron au joueur ID 2
```

### Points d'Intérêt

1. **🔥 Fonderie** - Fabrication d'items métalliques
2. **💎 Bijouterie** - Taille de pierres et fabrication de bijoux
3. **📦 Exportation** - Vente des items fabriqués
4. **🚗 Garage** - Sortir/ranger les véhicules de société
5. **👔 Actions Patron** - Menu de gestion (grade boss uniquement)

## 🎨 Personnalisation

### UI
L'interface est entièrement personnalisable via:
- `html/style.css` - Styles et couleurs
- `html/script.js` - Fonctionnalités JavaScript
- `html/index.html` - Structure HTML

### Couleurs
Modifier les couleurs principales dans `style.css`:
```css
/* Orange principal */
background: linear-gradient(135deg, #ff6b00 0%, #ff9500 100%);

/* Changer pour bleu par exemple */
background: linear-gradient(135deg, #0066ff 0%, #0095ff 100%);
```

## 🐛 Dépannage

### L'UI ne s'ouvre pas
- Vérifier que jQuery est bien chargé
- Vérifier la console F8 pour les erreurs
- S'assurer que `ui_page` est bien défini dans `fxmanifest.lua`

### Items non disponibles
- Vérifier que les items sont ajoutés dans ox_inventory
- Vérifier que les images sont présentes
- Redémarrer ox_inventory après ajout des items

### Le job ne fonctionne pas
- Vérifier que le SQL a bien été importé
- Vérifier que esx_society est démarré
- Redémarrer le serveur après import SQL

## 📝 Logs

Les logs sont affichés dans la console serveur:
```
[ZFundry] Script de Fonderie & Bijouterie chargé avec succès!
[ZFundry] XX recettes de fonderie disponibles
[ZFundry] XX recettes de bijouterie disponibles
[ZFundry Export] Système d'exportation chargé!
```

## 🤝 Support

Pour tout problème ou suggestion:
1. Vérifier la documentation
2. Vérifier les logs serveur
3. Vérifier la console F8

## 📄 Licence

Ce script est fourni tel quel. Vous êtes libre de le modifier selon vos besoins.

## 🔧 Compatibilité

- ✅ ESX Legacy
- ✅ ox_inventory
- ✅ oxmysql
- ✅ Compatible avec la plupart des scripts de véhicules
- ✅ Compatible avec la plupart des scripts de clés de véhicules

## 🎯 Roadmap

- [ ] Support QB-Core
- [ ] Système de level/expérience
- [ ] Minijeux pour le crafting
- [ ] Support pour d'autres inventaires

---

**Développé avec ❤️ pour la communauté FiveM**

**Version:** 1.0.0
