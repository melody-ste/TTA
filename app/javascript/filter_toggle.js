document.addEventListener('DOMContentLoaded', () => {
  const toggleBtn = document.getElementById('toggle-filter-btn');
  const filterForm = document.getElementById('filter-form-container');

  toggleBtn.addEventListener('click', (e) => {
    e.preventDefault();
    if (filterForm.style.display === 'none') {
      filterForm.style.display = 'block';
      toggleBtn.style.display = 'none';
    }
  });
});