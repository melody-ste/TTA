console.log("chargé")

const blocCarousels = document.querySelectorAll(".carousel");

blocCarousels.forEach((carousel) => {
  let images = carousel.querySelectorAll(".carousel-image");
  let prevBtn = carousel.querySelector(".prev");
  let nextBtn = carousel.querySelector(".next");
  let currentIndex = 0;

  function activeImg(index) {
    images.forEach((img, i) => {
      img.classList.toggle("active", i === index);
    });
  }
  activeImg(currentIndex);

  prevBtn.addEventListener("click", function () {
    // permet de faire boucle circulaire
    // exemple index = 0 , -1 pour aller en arrière, +longuerr du tableau(ex 5) => 0-1+5 = 4 ; 4 divisé par longueur tableau (donc 5)= 4/5 , le reste est 4 donc index est 4 (tableau index: 0,1,2,3,4)
    console.log("click")
    currentIndex = (currentIndex - 1 + images.length) % images.length;
    activeImg(currentIndex);
  });

  nextBtn.addEventListener("click", function () {
    // ex longueur tableau = 5; currentIndex= 4; on va au prochain donc 4+1 =5; 5/5 reste 0, nouveau currentIndex = 0
    currentIndex = (currentIndex + 1) % images.length;
    activeImg(currentIndex);
  })
})