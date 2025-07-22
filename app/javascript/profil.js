document.addEventListener("DOMContentLoaded", function () {
  // console.log("Profil.js loaded - DOM ready");

  function initializeAvatar() {
    const fileInput = document.getElementById("avatar_input");
    if (fileInput) {
      fileInput.addEventListener("change", function () {
        if (this.files.length > 0) {
          this.form.submit();
        }
      });
    }

  }

  initializeAvatar();

  setTimeout(initializeAvatarListeners, 100);
});