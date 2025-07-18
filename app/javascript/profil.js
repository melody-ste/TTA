document.addEventListener("DOMContentLoaded", function () {
  let fileInput = document.getElementById("avatar_input");
  let submitButton = document.getElementById("profil-submit_button");

  fileInput.addEventListener("change", function () {
    if (fileInput.files.length > 0) {
      submitButton.style.display = "inline-block";
    } else {
      submitButton.style.display = "none";
    }
  });
});