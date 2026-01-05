# 🚀 Installation Rapide - ZFundry

## ⚡ En 5 étapes

### 1️⃣ Copier le Script
```bash
# Copier zfundry dans votre dossier resources
resources/[zfundry]/zfundry/
```

### 2️⃣ Server.cfg
```cfg
ensure zfundry
```

### 3️⃣ Base de Données
Importer `zfundry.sql` dans votre base de données MySQL

### 4️⃣ Items ox_inventory
Copier le contenu de `ox_inventory_items.lua` dans:
```
ox_inventory/data/items.lua
```

### 5️⃣ Images
Télécharger les images (voir `IMAGES_NEEDED.txt`) et les placer dans:
```
ox_inventory/web/images/
```

## ✅ C'est tout!

Redémarrer votre serveur et c'est bon!

## 📍 Positions par Défaut

Les zones sont configurées autour de ces coordonnées:
- **Fonderie**: `1110.45, -2008.38, 35.47`
- **Bijouterie**: `1117.45, -2008.38, 35.47`
- **Export**: `1124.45, -2008.38, 35.47`
- **Garage**: `1131.45, -2008.38, 35.47`
- **Boss Actions**: `1103.45, -2008.38, 35.47`

**⚠️ IMPORTANT:** Modifier ces positions dans `config.lua` selon votre serveur!

## 🎮 Commandes Admin

```lua
/setfoundry [ID] [grade]
```

Exemples:
```lua
/setfoundry 1 0  -- Grade Apprenti
/setfoundry 1 1  -- Grade Ouvrier
/setfoundry 1 2  -- Grade Patron
```

## 🐛 Problèmes Courants

### L'UI ne s'ouvre pas
✅ Vérifier que les fichiers HTML sont bien dans `html/`
✅ Vérifier la console F8

### Items manquants
✅ Redémarrer ox_inventory après ajout des items
✅ Vérifier que les images sont présentes

### Job non fonctionnel
✅ Vérifier que le SQL est bien importé
✅ Redémarrer le serveur

## 📖 Documentation Complète

Voir `README.md` pour plus de détails
