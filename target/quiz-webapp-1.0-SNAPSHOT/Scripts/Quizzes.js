document.addEventListener("DOMContentLoaded", function () {
    const categoryDropdown = document.getElementById("categoryDropdown");
    const categoryMenu = document.getElementById("categoryMenu");
    const userDropdown = document.getElementById("userDropdown");
    const userMenu = document.getElementById("userMenu");

    categoryDropdown.addEventListener("click", function (e) {
        e.stopPropagation();
        categoryMenu.classList.toggle("hidden");
        userMenu.classList.add("hidden");
    });

    userDropdown.addEventListener("click", function (e) {
        e.stopPropagation();
        userMenu.classList.toggle("hidden");
        categoryMenu.classList.add("hidden");
    });

    document.addEventListener("click", function () {
        categoryMenu.classList.add("hidden");
        userMenu.classList.add("hidden");
    });
});

document.addEventListener("DOMContentLoaded", function () {
    const searchInput = document.querySelector(".search-input");
    const filterSelects = document.querySelectorAll(".filter-select");

    searchInput.addEventListener("input", function () {
        console.log("Search:", this.value);
    });

    filterSelects.forEach((select) => {
        select.addEventListener("change", function () {
            console.log("Filter changed:", this.value);
        });
    });
});

document.addEventListener("DOMContentLoaded", function () {
    const categoryCards = document.querySelectorAll(".category-card");

    categoryCards.forEach((card) => {
        card.addEventListener("click", function () {
            const categoryName = this.querySelector("h3").textContent;
            console.log("Category selected:", categoryName);
        });
    });
});
