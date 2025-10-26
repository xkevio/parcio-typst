const slides = document.getElementsByClassName("slide");
let slide_idx = 0;

function next() {
  if (slide_idx < slides.length) {
    slide_idx++;
  }

  location.href = `#${slide_idx}`;
}

function prev() {
  if (slide_idx > 1) {
    slide_idx--;
  }

  location.href = `#${slide_idx}`;
}

document.addEventListener("keydown", e => {
  switch (e.key) {
    case "ArrowLeft":
      prev();
      break;
    case "ArrowRight":
      next();
      break;
  }
});
