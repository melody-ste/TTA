
const searchForm = document.querySelector('.searchForm');
const searchInput = document.querySelector('.searchInput');


class SearchHandler {
  constructor(form, input) {
    this.form = form;
    this.input = input;
    this.timeout = null;
  }

  search() {

    clearTimeout(this.timeout);
    this.timeout = setTimeout(() => {
      this.form.requestSubmit();
    }, 500);
  }
}

if (searchForm && searchInput) {
  const searchHandler = new SearchHandler(searchForm, searchInput);

  searchInput.addEventListener('input', function () {

    searchHandler.search();
  });
} else {
  console.log("Éléments de recherche non trouvés");
}