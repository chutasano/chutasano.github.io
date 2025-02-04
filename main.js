var acc = document.querySelectorAll(".pubs_parent button");
var i;

for (i = 0; i < acc.length; i++) {
  acc[i].addEventListener("click", function() {
    // this.classList.toggle("active");
    var children = this.parentNode.querySelectorAll(".pubs_children div");
    for (i = 0; i < children.length; i++) {
      if (children[i].style.display === "block") {
        children[i].style.display = "none";
      } else {
        children[i].style.display = "block";
      }
    }
  });
}
