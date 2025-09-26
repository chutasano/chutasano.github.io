open Tyxml

type page =
  Home
| Publications
| Cv
| Contact

let pages = [Home; Publications; Cv; Contact]

let page_url page = match page with
| Home -> "index.html"
| Publications -> "publications.html"
| Cv -> "cv.html"
| Contact -> "contact.html"

let page_name page = match page with
| Home -> "Home"
| Publications -> "Publications"
| Cv -> "CV"
| Contact -> "Contact"


let navbar active_page =
  let gen_link p =
    if p = active_page then
      [%html "<li class=\"navactive\"><a href=\""(page_url p)"\">"[Html.txt @@ page_name p]"</a></li>"]
    else
      [%html "<li><a href=\""(page_url p)"\">"[Html.txt @@ page_name p]"</a></li>"]
  in
  [%html"<div class=\"nav\"><ul>"(List.map gen_link pages)"</ul></div>"]

let%html head p =
{|
<head>
  <title>|}(Html.txt @@ ("Chuta Sano: " ^ page_name p)){|</title>
  <link rel=stylesheet href="main.css"/>
  <script src="main.js" defer></script>
</head>
|}

let%html href url text = "<a href=\""url"\">"[Html.txt text]"</a>"

let%html button text = "<button type=\"button\">"[Html.txt text]"</button>"
