document.addEventListener("DOMContentLoaded", function () {
  console.log("Profil.js loaded - DOM ready");

  // Fonction pour initialiser les listeners d'avatar
  function initializeAvatarListeners() {
    let fileInput = document.getElementById("avatar_input");
    let submitButton = document.getElementById("profil-submit_button");

    console.log("fileInput found:", !!fileInput);
    console.log("submitButton found:", !!submitButton);

    if (fileInput && submitButton) {
      console.log("Both elements found, setting up event listener");

      fileInput.addEventListener("change", function () {
        console.log("File input changed, files count:", fileInput.files.length);
        if (fileInput.files.length > 0) {
          submitButton.style.display = "inline-block";
          console.log("Submit button shown");
        } else {
          submitButton.style.display = "none";
          console.log("Submit button hidden");
        }
      });

      console.log("Event listener attached successfully");
    } else {
      console.log("Missing elements - fileInput:", !!fileInput, "submitButton:", !!submitButton);
    }
  }

  // Initialiser immédiatement
  initializeAvatarListeners();

  // Réessayer après un petit délai au cas où les éléments ne seraient pas encore dans le DOM
  setTimeout(initializeAvatarListeners, 100);
});