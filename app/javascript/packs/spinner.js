

document.addEventListener("DOMContentLoaded", () => {
  document.getElementById("booking-card").style.display = "none";
  setTimeout(function() {
    document.getElementById("status").style.display = "none";
    document.getElementById("booking-card").style.display = "block";
  }, 3000)
});
