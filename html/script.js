// Variables globales
let currentData = null;
let currentUIType = null;
let currentModalAction = null;

// Mapping des items vers leurs labels
const itemLabels = {
    // Minerais bruts
    iron_ore: 'Minerai de Fer',
    copper_ore: 'Minerai de Cuivre',
    gold_ore: 'Minerai d\'Or',
    silver_ore: 'Minerai d\'Argent',
    quartz: 'Quartz Brut',
    emerald: 'Émeraude Brute',
    ruby: 'Rubis Brut',
    pink_sapphire: 'Saphir Rose Brut',
    amethyst: 'Améthyste Brute',
    diamond: 'Diamant Brut',
    blue_diamond: 'Diamant Bleu Brut',

    // Lingots (métaux fondus)
    iron_ingot: 'Lingot de Fer',
    steel_ingot: 'Lingot d\'Acier',
    copper_ingot: 'Lingot de Cuivre',
    gold_ingot: 'Lingot d\'Or',
    silver_ingot: 'Lingot d\'Argent',

    // Pierres précieuses taillées
    cut_quartz: 'Quartz Taillé',
    cut_emerald: 'Émeraude Taillée',
    cut_ruby: 'Rubis Taillé',
    cut_pink_sapphire: 'Saphir Rose Taillé',
    cut_amethyst: 'Améthyste Taillée',
    cut_diamond: 'Diamant Taillé',
    cut_blue_diamond: 'Diamant Bleu Taillé',

    // Bases de bijoux en or
    gold_ring_base: 'Anneau en Or',
    gold_necklace_base: 'Collier en Or',
    gold_earrings_base: 'Boucles d\'Oreilles en Or',

    // Bases de bijoux en argent
    silver_ring_base: 'Anneau en Argent',
    silver_necklace_base: 'Collier en Argent',
    silver_earrings_base: 'Boucles d\'Oreilles en Argent',

    // Bijoux en or avec pierres
    emerald_ring: 'Bague Émeraude',
    emerald_necklace: 'Collier Émeraude',
    ruby_ring: 'Bague Rubis',
    ruby_necklace: 'Collier Rubis',
    pink_sapphire_ring: 'Bague Saphir Rose',
    pink_sapphire_necklace: 'Collier Saphir Rose',
    amethyst_ring: 'Bague Améthyste',
    amethyst_necklace: 'Collier Améthyste',
    diamond_ring: 'Bague Diamant',
    diamond_necklace: 'Collier Diamant',
    diamond_earrings: 'Boucles Diamant',
    blue_diamond_ring: 'Bague Diamant Bleu',
    blue_diamond_necklace: 'Collier Diamant Bleu',

    // Bijoux en argent avec pierres
    silver_emerald_ring: 'Bague Argent Émeraude',
    silver_ruby_ring: 'Bague Argent Rubis',
    silver_amethyst_ring: 'Bague Argent Améthyste',
    silver_diamond_ring: 'Bague Argent Diamant'
};

function getItemLabel(itemName) {
    return itemLabels[itemName] || itemName;
}

// Écouter les messages de FiveM
window.addEventListener('message', function(event) {
    const data = event.data;

    switch(data.action) {
        case 'openCraftingUI':
            openCraftingUI(data.recipes, data.title, data.menuType);
            break;
        case 'openGarageUI':
            openGarageUI(data.vehicles);
            break;
        case 'openExportUI':
            openExportUI(data.items);
            break;
        case 'notify':
            showNotification(data.message, data.type);
            break;
        case 'showProgress':
            showProgressBar(data.duration);
            break;
        case 'hideProgress':
            hideProgressBar();
            break;
    }
});

// Fermer avec Échap
document.addEventListener('keydown', function(event) {
    if (event.key === 'Escape') {
        closeAllUIs();
    }
});

// Utilitaire
function GetParentResourceName() {
    if (window.location.href.includes('://nui_')) {
        const match = window.location.href.match(/https?:\/\/nui_(.+?)\//);
        return match ? match[1] : 'zfundry';
    }
    return 'zfundry';
}

// CRAFTING UI
function openCraftingUI(recipes, title, menuType) {
    currentData = {recipes, menuType};
    currentUIType = 'crafting';
    
    document.getElementById('craftingTitle').textContent = title;
    const recipesGrid = document.getElementById('recipesGrid');
    recipesGrid.innerHTML = '';

    recipes.forEach((recipe) => {
        const card = document.createElement('div');
        card.className = 'recipe-card' + (recipe.canCraft ? '' : ' disabled');
        
        const timeInSeconds = (recipe.time / 1000).toFixed(1);
        let gradeBadge = recipe.requiredGrade !== undefined && recipe.requiredGrade > 0 
            ? '<span class="grade-badge">Grade ' + recipe.requiredGrade + ' requis</span>' 
            : '';
        
        let ingredientsHTML = '';
        recipe.requires.forEach(ing => {
            ingredientsHTML += '<div class="ingredient-item"><span>' + getItemLabel(ing.item) + '</span><span class="ingredient-amount">' + ing.amount + 'x</span></div>';
        });

        card.innerHTML = 
            '<div class="recipe-header">' +
                '<div class="recipe-name">' + recipe.label + '</div>' +
                '<div class="recipe-time">⏱️ ' + timeInSeconds + 's</div>' +
            '</div>' +
            gradeBadge +
            '<div class="recipe-ingredients">' +
                '<div class="ingredient-title">Ingrédients requis:</div>' +
                ingredientsHTML +
            '</div>';

        if (recipe.canCraft) {
            card.addEventListener('click', () => openQuantityModal(recipe, 'craft'));
        }

        recipesGrid.appendChild(card);
    });

    document.getElementById('craftingUI').style.display = 'flex';
}

// GARAGE UI
function openGarageUI(vehicles) {
    currentData = {vehicles};
    currentUIType = 'garage';
    document.getElementById('garageUI').style.display = 'flex';
}

function showVehiclesList() {
    const list = document.getElementById('vehiclesList');
    const vehicles = currentData.vehicles;
    
    list.innerHTML = '';
    vehicles.forEach(vehicle => {
        const card = document.createElement('div');
        card.className = 'vehicle-card';
        card.innerHTML = '<div class="btn-icon">🚗</div><div class="vehicle-name">' + vehicle.label + '</div>';
        card.addEventListener('click', () => spawnVehicle(vehicle.model));
        list.appendChild(card);
    });
    
    list.style.display = 'grid';
}

function spawnVehicle(model) {
    fetch('https://' + GetParentResourceName() + '/spawnVehicle', {
        method: 'POST',
        headers: {'Content-Type': 'application/json'},
        body: JSON.stringify({model})
    });
    closeUI('garage');
}

function storeVehicle() {
    fetch('https://' + GetParentResourceName() + '/storeVehicle', {
        method: 'POST',
        headers: {'Content-Type': 'application/json'},
        body: JSON.stringify({})
    });
    closeUI('garage');
}

// EXPORT UI
function openExportUI(items) {
    currentData = {items};
    currentUIType = 'export';
    
    const exportGrid = document.getElementById('exportGrid');
    exportGrid.innerHTML = '';

    items.forEach(item => {
        const price = getExportPrice(item.name);
        const card = document.createElement('div');
        card.className = 'export-card';
        card.innerHTML = 
            '<div class="export-item-name">' + item.label + '</div>' +
            '<div class="export-item-price">💰 $' + price + ' / pièce</div>' +
            '<div class="export-item-count">Stock: ' + item.count + 'x</div>';
        card.addEventListener('click', () => openQuantityModal({
            name: item.name,
            label: item.label,
            price: price,
            maxCount: item.count
        }, 'export'));
        exportGrid.appendChild(card);
    });

    document.getElementById('exportUI').style.display = 'flex';
}

function getExportPrice(itemName) {
    const prices = {
        iron_ingot: 150, steel_ingot: 300, copper_ingot: 200, gold_ingot: 800,
        cut_quartz: 100, cut_emerald: 500, cut_ruby: 600, cut_pink_sapphire: 700,
        cut_amethyst: 450, cut_diamond: 1200, cut_blue_diamond: 1800,
        gold_ring_base: 600, gold_necklace_base: 1000, gold_earrings_base: 700,
        emerald_ring: 1500, emerald_necklace: 2500, ruby_ring: 1700, ruby_necklace: 2800,
        pink_sapphire_ring: 2000, pink_sapphire_necklace: 3200,
        amethyst_ring: 1300, amethyst_necklace: 2200,
        diamond_ring: 3000, diamond_necklace: 5000, diamond_earrings: 4000,
        blue_diamond_ring: 4500, blue_diamond_necklace: 7500,
        engine: 2500, turbo: 1800, suspension: 1200, brakes: 900, repair_kit: 400
    };
    return prices[itemName] || 100;
}

// MODAL
function openQuantityModal(data, action) {
    currentModalAction = {data, action};
    
    document.getElementById('modalItemLabel').textContent = data.label;
    document.getElementById('quantityInput').value = 1;
    
    if (action === 'craft') {
        updateIngredientsDisplay(data.requires, 1);
    } else if (action === 'export') {
        document.getElementById('ingredientsRequired').innerHTML = 
            '<div style="text-align: center; color: #4caf50; font-size: 18px; font-weight: 600;">Prix total: $' + data.price + '</div>';
    }
    
    document.getElementById('quantityModal').style.display = 'flex';
}

function closeQuantityModal() {
    document.getElementById('quantityModal').style.display = 'none';
    currentModalAction = null;
}

function increaseQuantity() {
    const input = document.getElementById('quantityInput');
    const newValue = Math.min(parseInt(input.value) + 1, 999);
    input.value = newValue;
    updateQuantityDisplay(newValue);
}

function decreaseQuantity() {
    const input = document.getElementById('quantityInput');
    const newValue = Math.max(parseInt(input.value) - 1, 1);
    input.value = newValue;
    updateQuantityDisplay(newValue);
}

document.getElementById('quantityInput').addEventListener('input', function() {
    let value = Math.max(1, Math.min(parseInt(this.value) || 1, 999));
    this.value = value;
    updateQuantityDisplay(value);
});

function updateQuantityDisplay(quantity) {
    if (!currentModalAction) return;
    
    if (currentModalAction.action === 'craft') {
        updateIngredientsDisplay(currentModalAction.data.requires, quantity);
    } else if (currentModalAction.action === 'export') {
        const totalPrice = currentModalAction.data.price * quantity;
        document.getElementById('ingredientsRequired').innerHTML = 
            '<div style="text-align: center; color: #4caf50; font-size: 18px; font-weight: 600;">Prix total: $' + totalPrice.toLocaleString() + '</div>';
    }
}

function updateIngredientsDisplay(requires, quantity) {
    let html = '<div class="ingredient-req-title">Ingrédients requis (Total):</div>';
    requires.forEach(ing => {
        html += '<div class="ingredient-req-item"><span>' + getItemLabel(ing.item) + '</span><span class="ingredient-req-amount">' + (ing.amount * quantity) + 'x</span></div>';
    });
    document.getElementById('ingredientsRequired').innerHTML = html;
}

function confirmAction() {
    if (!currentModalAction) return;
    
    const quantity = parseInt(document.getElementById('quantityInput').value);
    const {data, action} = currentModalAction;
    
    if (action === 'craft') {
        fetch('https://' + GetParentResourceName() + '/craftItem', {
            method: 'POST',
            headers: {'Content-Type': 'application/json'},
            body: JSON.stringify({recipe: data, amount: quantity, menuType: currentData.menuType})
        });
    } else if (action === 'export') {
        fetch('https://' + GetParentResourceName() + '/sellItem', {
            method: 'POST',
            headers: {'Content-Type': 'application/json'},
            body: JSON.stringify({item: data.name, amount: quantity, price: data.price})
        });
    }
    
    closeQuantityModal();
    closeAllUIs();
}

// FERMER UIs
function closeUI(type) {
    document.getElementById(type + 'UI').style.display = 'none';
    fetch('https://' + GetParentResourceName() + '/closeUI', {
        method: 'POST',
        headers: {'Content-Type': 'application/json'},
        body: JSON.stringify({})
    });
}

function closeAllUIs() {
    ['crafting', 'garage', 'export'].forEach(type => {
        document.getElementById(type + 'UI').style.display = 'none';
    });
    closeQuantityModal();
    fetch('https://' + GetParentResourceName() + '/closeUI', {
        method: 'POST',
        headers: {'Content-Type': 'application/json'},
        body: JSON.stringify({})
    });
}

// NOTIFICATIONS
function showNotification(message, type) {
    const container = document.getElementById('notificationContainer');
    const notification = document.createElement('div');
    notification.className = 'notification ' + (type || 'info');
    notification.innerHTML = 
        '<div class="notification-icon"></div>' +
        '<div class="notification-message">' + message + '</div>';
    container.appendChild(notification);
    setTimeout(() => {
        notification.style.animation = 'slideInRight 0.3s ease reverse';
        setTimeout(() => notification.remove(), 300);
    }, 5000);
}

// PROGRESS BAR
function showProgressBar(duration) {
    const progressBar = document.getElementById('progressBar');
    const progressFill = document.getElementById('progressFill');
    
    progressBar.style.display = 'block';
    progressFill.style.width = '0%';
    
    let progress = 0;
    const interval = setInterval(() => {
        progress += 100;
        const percentage = Math.min((progress / duration) * 100, 100);
        progressFill.style.width = percentage + '%';
        
        if (progress >= duration) {
            clearInterval(interval);
        }
    }, 100);
}

function hideProgressBar() {
    document.getElementById('progressBar').style.display = 'none';
}
