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
| Cv -> "pdf/cv.pdf"
| Contact -> "contact.html"

let page_name page = match page with
| Home -> "Home"
| Publications -> "Publications"
| Cv -> "CV (PDF)"
| Contact -> "Contact"

let%html href url text = "<a href=\""url"\">"[Html.txt text]"</a>"

let%html button text = "<button type=\"button\">"[Html.txt text]"</button>"

let mk_div clas contents =
  Html.div ~a:[Html.a_class[clas]] contents

let mk_div1 clas content =
  mk_div clas [content]


let navbar active_page =
  let gen_link p =
    if p = active_page then
      [%html "<a class=\"navactive\" href=\""(page_url p)"\">"[Html.txt @@ page_name p]"</a>"]
    else
      [%html "<a href=\""(page_url p)"\">"[Html.txt @@ page_name p]"</a>"]
  in
  mk_div1 "nav" (mk_div "nav-in" (List.map gen_link pages))

let%html head p =
{|
<head>
  <title>|}(Html.txt @@ ("Chuta Sano: " ^ page_name p)){|</title>
  <link rel=stylesheet href="main.css"/>
  <script src="main.js" defer></script>
</head>
|}



let mk_html p body =
  Html.html (head p)
    (Html.body [navbar p ; mk_div1 "body-content" body])
