var acc = document.querySelectorAll(".pubs-parent button");
var i;

for (i = 0; i < acc.length; i++) {
  acc[i].addEventListener("click", function() {
    // this.classList.toggle("active");
    if (this.innerHTML == "+") {
      this.innerHTML = "-";
    } else {
      this.innerHTML = "+";
    }
    var children = this.parentNode.querySelectorAll(".pubs-children li");
    for (i = 0; i < children.length; i++) {
      if (children[i].style.display === "block") {
        children[i].style.display = "none";
      } else {
        children[i].style.display = "block";
      }
    }
  });
}
