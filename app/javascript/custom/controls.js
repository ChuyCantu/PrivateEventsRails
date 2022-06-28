import "@hotwired/turbo-rails"

function fadeAndSlideOut(element, duration, func) {
    var seconds = duration / 1000;
    element.style.transition = `opacity ${seconds}s ease, margin-right ${seconds}s ease`;

    element.style.opacity = 0;
    element.style.marginRight = `-${element.clientWidth}px`;
    setTimeout(func, duration);
}

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

function SetupNotifications() {
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
    SetupNotifications();
});
// document.documentElement.addEventListener('turbo:visit', () => {
//     console.log("page changed")
// });


//! Test notification creation:
// document.documentElement.addEventListener('mousedown', (e) => {
//     if (e.button != 2)
//         return;

//     let notification = document.createElement("div");
//     let msg = document.createElement("p");
//     let btn = document.createElement("span");
//     let icon = document.createElement("i");
    
//     const isNotice = Math.floor(Math.random() * 2) == 0;

//     notification.classList.add("notification");
//     notification.classList.add(isNotice ? "notice" : "alert");
//     msg.classList.add("msg");
//     msg.innerText = isNotice ? "Notice message" : "Alert message";
//     btn.classList.add("close-btn");
//     icon.classList.add("fa-solid");
//     icon.classList.add("fa-xmark");

//     btn.appendChild(icon);
//     notification.appendChild(msg);
//     notification.appendChild(btn);

//     const notificationsContainers = document.getElementsByClassName("notifications");
//     notificationsContainers[0].appendChild(notification);
// });
