// Attendre que le DOM soit chargé et gérer Turbo
document.addEventListener('DOMContentLoaded', initializeFavorites);
document.addEventListener('turbo:load', initializeFavorites);

function initializeFavorites() {
  const heart_containers = document.querySelectorAll(".favorite-container");

  heart_containers.forEach(container => {
    const fav_icon = container.querySelector(".heart-icon");

    if (fav_icon && !fav_icon.hasAttribute('data-listener-added')) {
      fav_icon.setAttribute('data-listener-added', 'true');

      fav_icon.addEventListener("click", (event) => {
        event.preventDefault();

        const canLike = container.dataset.userCanLike === "true";
        if (!canLike) {
          return; // Ne fait rien
        }

        const architectId = container.dataset.architectId;
        const isLiked = fav_icon.dataset.liked === "true";

        fetch(`/architects/${architectId}/${isLiked ? 'unlike' : 'like'}`, {
          method: isLiked ? 'DELETE' : 'POST',
          headers: {
            'X-CSRF-Token': document.querySelector('[name="csrf-token"]').content,
            'Accept': 'text/javascript'
          }
        })
          .then(response => response.text())
          .then(script => {
            eval(script);
          })
          .catch(error => {
            console.error('Erreur lors de la requête:', error);
          });
      });
    }
  });
}
