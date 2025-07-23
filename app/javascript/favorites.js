const heart_container = document.querySelector(".favorite-container");
const fav_icon = heart_container.querySelector(".heart-icon");

fav_icon.addEventListener("click", (event) => {
  event.preventDefault();
  if (fav_icon.classList.contains("fa-regular")) {
    fav_icon.classList.remove("fa-regular", "text-muted");
    fav_icon.classList.add("fa-solid", "text-danger");
    fav_icon.setAttribute("data-liked", "true");
  } else {
    fav_icon.classList.remove("fa-solid", "text-danger");
    fav_icon.classList.add("fa-regular", "text-muted");
    fav_icon.setAttribute("data-liked", "false");
  }

  // compteuur de  likes

  heart_container.querySelector(".likes-count").textContent = data.likes_count;

});
