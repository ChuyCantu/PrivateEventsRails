import "@hotwired/turbo-rails"

function fadeAndSlideOut(element, duration, func) {
    var seconds = duration / 1000;
    element.style.transition = `opacity ${seconds}s ease, margin-right ${seconds}s ease`;

    element.style.opacity = 0;
    element.style.marginRight = `-${element.clientWidth}px`;
    setTimeout(func, duration);
}

// NAV BURGER: ==================================
    function initBurgerMenu() {
        const navbarBurgerItems = document.getElementsByClassName("navbar-burger-item");
        const burgerBtn = navbarBurgerItems.length > 0 ? navbarBurgerItems[0] : null;

        if (burgerBtn === null) return;

        // This should be changed to an ID since there can only be one burger menu anyways
        const burgerMenus = document.getElementsByClassName("burger-menu");
        const burgerMenu = burgerMenus.length > 0 ? burgerMenus[0] : null;

        if (burgerMenu === null) return;

        burgerBtn.addEventListener("click", () => burgerMenu.classList.toggle("hidden"));

        // const burgerItems = burgerMenu.getElementsByClassName("burger-item");
        // Array.from(burgerItems).forEach((item) => item.addEventListener("click", () => burgerMenu.classList.toggle("hidden")));

        // Check click outside the burger menu
        document.addEventListener("click", (e) => { 
            if (!burgerMenu.contains(e.target) && !burgerBtn.contains(e.target)
                && !burgerMenu.classList.contains("hidden"))
                burgerMenu.classList.toggle("hidden");
        });
    }
// ==============================================

// NOTIFICATIONS: ===============================
function onNotificationAdded(notification) {
    // Set up close button
    const closeButtons = notification.getElementsByClassName("close-btn");
    let btn = null;
    if (closeButtons.length > 0) 
        btn = closeButtons[0];
    btn?.addEventListener("click", () => fadeAndSlideOut(notification, 1000, () => notification.remove()));

    // If not manually destroyed, destroy after some time
    setTimeout(() => {
        fadeAndSlideOut(notification, 1000, () => notification.remove());
    }, 10000);
}

function setupNotifications() {
    const notificationsContainers = document.getElementsByClassName("notifications");
    Array.from(notificationsContainers).forEach(container => {
        // Check for existing notifications:
        const notifications = container.getElementsByClassName("notification");
        Array.from(notifications).forEach((notification => onNotificationAdded(notification)));

        // Also listen for new notifications:
        const config = { childList: true };
        const callback = function(mutationList, observer) {
            for (const mutation of mutationList) {
                if (mutation.type === "childList") {
                    // console.log(mutation.addedNodes.length > 0 ? "A child was added."  : "A child was or removed");
                    if (mutation.addedNodes.length > 0) {
                        mutation.addedNodes.forEach((notification) => onNotificationAdded(notification));
                    }
                }
            }
        };
        //+ docs: https://developer.mozilla.org/en-US/docs/Web/API/MutationObserver
        const observer = new MutationObserver(callback);
        observer.observe(container, config);
    });
}
// ==============================================

//+ docs:
//+ https://github.com/hotwired/turbo-rails
//+ https://turbo.hotwired.dev/reference/events
document.documentElement.addEventListener('turbo:load', () => {
    // console.log("page loaded");
    setupNotifications();
    initBurgerMenu();
});
// document.documentElement.addEventListener('turbo:visit', () => {
//     console.log("page changed")
// });
