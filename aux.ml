open Tyxml

type page =
  Home
| Publications

let pages = [Home; Publications]

let page_url page = match page with
| Home -> "index.html"
| Publications -> "publications.html"

let page_name page = match page with
| Home -> "Home"
| Publications -> "Publications"


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
  <title>|}(Html.txt @@ page_name p){|</title>
  <link rel=stylesheet href="main.css"/>
</head>
|}

let%html href url text = "<a href=\""url"\">"[Html.txt text]"</a>"
