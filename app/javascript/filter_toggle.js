document.addEventListener('turbo:load', () => {
  const toggleBtn = document.getElementById('toggle-filter-btn');
  const filterForm = document.getElementById('filter-form-container');

  if (!toggleBtn || !filterForm) {
    return;
  }

  // Pour éviter de rajouter plusieurs fois l'écouteur (si Turbo recharge plusieurs fois)
  toggleBtn.replaceWith(toggleBtn.cloneNode(true));
  const newToggleBtn = document.getElementById('toggle-filter-btn');

  newToggleBtn.addEventListener('click', (e) => {
    e.preventDefault();
    filterForm.classList.toggle('d-none');
  });
});
