document.addEventListener('turbo:load', () => {
  console.log("JS chargé avec Turbo !");
  const toggleBtn = document.getElementById('toggle-filter-btn');
  const filterForm = document.getElementById('filter-form-container');

  if (!toggleBtn || !filterForm) {
    console.log("toggleBtn ou filterForm introuvable");
    return;
  }

  // Pour éviter de rajouter plusieurs fois l'écouteur (si Turbo recharge plusieurs fois)
  toggleBtn.replaceWith(toggleBtn.cloneNode(true));
  const newToggleBtn = document.getElementById('toggle-filter-btn');

  newToggleBtn.addEventListener('click', (e) => {
    e.preventDefault();
    console.log("Bouton toggle cliqué");
    filterForm.classList.toggle('d-none');
  });
});
