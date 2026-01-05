let currentRecipes = [];
let currentRecipeData = null;
let currentMenuType = '';

// Écouter les messages de FiveM
window.addEventListener('message', function(event) {
    const data = event.data;

    if (data.action === 'openUI') {
        openUI(data.recipes, data.title, data.menuType);
    } else if (data.action === 'closeUI') {
        closeUI();
    } else if (data.action === 'notify') {
        showNotification(data.message, data.type);
    }
});

// Fermer l'UI avec Échap
document.addEventListener('keydown', function(event) {
    if (event.key === 'Escape') {
        closeUI();
        closeQuantityModal();
    }
});

// Ouvrir l'UI
function openUI(recipes, title, menuType) {
    currentRecipes = recipes;
    currentMenuType = menuType;

    document.getElementById('menuTitle').textContent = title;
    document.getElementById('foundryUI').style.display = 'flex';

    const recipesGrid = document.getElementById('recipesGrid');
    recipesGrid.innerHTML = '';

    recipes.forEach((recipe, index) => {
        const card = createRecipeCard(recipe, index);
        recipesGrid.appendChild(card);
    });

    // Focus sur le document pour permettre la fermeture avec Échap
    document.body.focus();
}

// Créer une carte de recette
function createRecipeCard(recipe, index) {
    const card = document.createElement('div');
    card.className = 'recipe-card';

    if (!recipe.canCraft) {
        card.classList.add('disabled');
    }

    const timeInSeconds = (recipe.time / 1000).toFixed(1);

    let gradeBadge = '';
    if (recipe.requiredGrade !== undefined && recipe.requiredGrade > 0) {
        gradeBadge = `<span class="grade-badge">Grade ${recipe.requiredGrade} requis</span>`;
    }

    let ingredientsHTML = '';
    recipe.requires.forEach(ingredient => {
        ingredientsHTML += `
            <div class="ingredient-item">
                <span>${ingredient.item}</span>
                <span class="ingredient-amount">${ingredient.amount}x</span>
            </div>
        `;
    });

    card.innerHTML = `
        <div class="recipe-header">
            <div class="recipe-name">${recipe.label}</div>
            <div class="recipe-time">⏱️ ${timeInSeconds}s</div>
        </div>
        ${gradeBadge}
        <div class="recipe-ingredients">
            <div class="ingredient-title">Ingrédients requis:</div>
            ${ingredientsHTML}
        </div>
    `;

    if (recipe.canCraft) {
        card.addEventListener('click', () => openQuantityModal(recipe, index));
    }

    return card;
}

// Ouvrir le modal de quantité
function openQuantityModal(recipe, index) {
    currentRecipeData = {recipe, index};

    document.getElementById('recipeLabel').textContent = recipe.label;
    document.getElementById('quantityInput').value = 1;

    updateIngredientsRequired(1);

    document.getElementById('quantityModal').style.display = 'flex';
}

// Fermer le modal de quantité
function closeQuantityModal() {
    document.getElementById('quantityModal').style.display = 'none';
    currentRecipeData = null;
}

// Augmenter la quantité
function increaseQuantity() {
    const input = document.getElementById('quantityInput');
    const currentValue = parseInt(input.value) || 1;
    const newValue = Math.min(currentValue + 1, 999);
    input.value = newValue;
    updateIngredientsRequired(newValue);
}

// Diminuer la quantité
function decreaseQuantity() {
    const input = document.getElementById('quantityInput');
    const currentValue = parseInt(input.value) || 1;
    const newValue = Math.max(currentValue - 1, 1);
    input.value = newValue;
    updateIngredientsRequired(newValue);
}

// Mettre à jour les ingrédients requis
function updateIngredientsRequired(quantity) {
    if (!currentRecipeData) return;

    const {recipe} = currentRecipeData;
    const container = document.getElementById('ingredientsRequired');

    let html = '<div class="ingredient-req-title">Ingrédients requis (Total):</div>';

    recipe.requires.forEach(ingredient => {
        const totalAmount = ingredient.amount * quantity;
        html += `
            <div class="ingredient-req-item">
                <span>${ingredient.item}</span>
                <span class="ingredient-req-amount">${totalAmount}x</span>
            </div>
        `;
    });

    container.innerHTML = html;
}

// Input changé manuellement
document.getElementById('quantityInput').addEventListener('input', function() {
    let value = parseInt(this.value) || 1;
    value = Math.max(1, Math.min(value, 999));
    this.value = value;
    updateIngredientsRequired(value);
});

// Confirmer le crafting
function confirmCraft() {
    if (!currentRecipeData) return;

    const quantity = parseInt(document.getElementById('quantityInput').value) || 1;
    const {recipe, index} = currentRecipeData;

    // Envoyer au client Lua
    fetch(`https://${GetParentResourceName()}/craftItem`, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({
            recipe: recipe,
            amount: quantity,
            menuType: currentMenuType
        })
    });

    closeQuantityModal();
    closeUI();
}

// Fermer l'UI
function closeUI() {
    document.getElementById('foundryUI').style.display = 'none';
    currentRecipes = [];

    // Notifier le client Lua
    fetch(`https://${GetParentResourceName()}/closeUI`, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({})
    });
}

// Afficher une notification
function showNotification(message, type = 'info') {
    const container = document.getElementById('notificationContainer');

    const notification = document.createElement('div');
    notification.className = `notification ${type}`;

    notification.innerHTML = `
        <div class="notification-icon"></div>
        <div class="notification-message">${message}</div>
    `;

    container.appendChild(notification);

    // Retirer après 5 secondes
    setTimeout(() => {
        notification.style.animation = 'slideInRight 0.3s ease reverse';
        setTimeout(() => {
            notification.remove();
        }, 300);
    }, 5000);
}

// Obtenir le nom de la ressource
function GetParentResourceName() {
    let resourceName = 'zfundry';
    if (window.location.href.includes('://nui_')) {
        const match = window.location.href.match(/https?:\/\/nui_(.+?)\//);
        if (match) {
            resourceName = match[1];
        }
    }
    return resourceName;
}
