// https://webcrunch.com/posts/turbo-charged-real-time-search-ruby-on-rails-7

const searchForm = document.querySelector('.searchForm');
const searchInput = document.querySelector('.searchInput');
console.log("searchForm:", searchForm);
console.log("searchInput:", searchInput);

class SearchHandler {
  constructor(form, input) {
    this.form = form;
    this.input = input;
    this.timeout = null;
    console.log("form", this.form);
    console.log("input", this.input);
  }

  search() {
    console.log("searching", this.input.value);
    clearTimeout(this.timeout);
    this.timeout = setTimeout(() => {
      console.log("demande envoyée");
      this.form.requestSubmit();
    }, 500);
  }
}

if (searchForm && searchInput) {
  const searchHandler = new SearchHandler(searchForm, searchInput);
  console.log("searchHandler", searchHandler);

  searchInput.addEventListener('input', function () {
    console.log("input event triggered:", searchInput.value);
    searchHandler.search();
  });
} else {
  console.log("Éléments de recherche non trouvés");
}