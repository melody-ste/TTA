

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
    currentIndex = (currentIndex - 1 + images.length) % images.length;
    activeImg(currentIndex);
  });

  nextBtn.addEventListener("click", function () {
    currentIndex = (currentIndex + 1) % images.length;
    activeImg(currentIndex);
  })
})