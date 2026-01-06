// Variables globales
let currentData = null;
let currentUIType = null;
let currentModalAction = null;

// Mapping des items vers leurs labels
const itemLabels = {
    // Matériaux de base
    scrapmetal: 'Ferraille',
    iron_ore: 'Minerai de Fer',
    coal_ore: 'Charbon',
    flint: 'Silex',
    sulfur_chunk: 'Soufre',
    copper_wire: 'Fil de Cuivre',

    // Métaux précieux bruts
    gold_nugget: 'Pépite d\'Or',
    gold_dust: 'Poussière d\'Or',

    // Cristaux et pierres précieuses
    quartz_crystal: 'Cristal de Quartz',
    emerald_crystal: 'Cristal d\'Émeraude',
    beryl_chunk: 'Béryl',
    green_garnet: 'Grenat Vert',
    ruby_crystal: 'Cristal de Rubis',
    corundum_chunk: 'Corindon',
    pink_sapphire: 'Saphir Rose',
    amethyst_geode: 'Géode d\'Améthyste',
    purple_quartz: 'Quartz Violet',
    clear_crystal: 'Cristal Clair',
    diamond_crystal: 'Cristal de Diamant',
    graphite_chunk: 'Graphite',
    blue_diamond: 'Diamant Bleu',

    // Matériaux transformés
    steel_bar: 'Barre d\'Acier',

    // Lingots d'investissement
    gold_ingot: 'Lingot d\'Or',
    silver_ingot: 'Lingot d\'Argent',
    platinum_ingot: 'Lingot de Platine',
    copper_ingot: 'Lingot de Cuivre',

    // Pierres précieuses taillées
    cut_emerald: 'Émeraude Taillée',
    cut_ruby: 'Rubis Taillé',
    cut_sapphire: 'Saphir Taillé',
    cut_amethyst: 'Améthyste Taillée',
    cut_diamond: 'Diamant Taillé',
    cut_blue_diamond: 'Diamant Bleu Taillé',

    // Bijoux finis
    gold_ring: 'Bague en Or',
    gold_necklace: 'Collier en Or',
    emerald_ring: 'Bague Émeraude',
    ruby_ring: 'Bague Rubis',
    sapphire_ring: 'Bague Saphir',
    amethyst_ring: 'Bague Améthyste',
    diamond_ring: 'Bague Diamant',
    diamond_necklace: 'Collier Diamant',
    blue_diamond_ring: 'Bague Diamant Bleu'
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
        // Barres et lingots de base
        steel_bar: 500,

        // Lingots d'investissement
        gold_ingot: 8000,
        silver_ingot: 2000,
        platinum_ingot: 12000,
        copper_ingot: 600,

        // Pierres taillées
        cut_emerald: 800,
        cut_ruby: 900,
        cut_sapphire: 850,
        cut_amethyst: 750,
        cut_diamond: 1500,
        cut_blue_diamond: 2500,

        // Bijoux bases
        gold_ring: 1200,
        gold_necklace: 1800,

        // Bijoux avec pierres
        emerald_ring: 2200,
        ruby_ring: 2400,
        sapphire_ring: 2300,
        amethyst_ring: 2000,
        diamond_ring: 3500,
        diamond_necklace: 6000,
        blue_diamond_ring: 5500
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
