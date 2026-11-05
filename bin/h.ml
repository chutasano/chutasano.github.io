open Tyxml

type page =
  Home
| Publications
| Cv
| Contact

type lang =
  En
| Ja

let pages = [Home; Publications; Cv; Contact]

let page_url page lang = match (page, lang) with
| (Home, En) -> "index.html"
| (Home, Ja) -> "index_ja.html"
| (Publications, En) -> "publications.html"
| (Publications, Ja) -> "publications_ja.html"
| (Cv, _) -> "pdf/cv.pdf"
| (Contact, En) -> "contact.html"
| (Contact, Ja) -> "contact_ja.html"

let page_name page lang = match (page, lang) with
| (Home, En) -> "Home"
| (Home, Ja) -> "ホーム"
| (Publications, En) -> "Publications"
| (Publications, Ja) -> "論文 (英語)"
| (Cv, En) -> "CV (PDF)"
| (Cv, Ja) -> "履歴書 (PDF, 英語)"
| (Contact, En) -> "Contact"
| (Contact, Ja) -> "連絡先"

let%html href url text = "<a href=\""url"\">"[Html.txt text]"</a>"

let%html button text = "<button type=\"button\">"[Html.txt text]"</button>"

let mk_div clas contents =
  Html.div ~a:[Html.a_class[clas]] contents

let mk_div1 clas content =
  mk_div clas [content]


let navbar active_page lang =
  let gen_link p lang =
    if p = active_page then
      [%html "<a class=\"navactive\" href=\""(page_url p lang)"\">"[Html.txt @@ page_name p lang]"</a>"]
    else
      [%html "<a href=\""(page_url p lang)"\">"[Html.txt @@ page_name p lang]"</a>"]
  in
  let change_lang_button =
    match lang with
    | En ->
      [%html "<a href=\""(page_url active_page Ja)"\">"[Html.txt "日本語"]"</a>"]
    | Ja ->
      [%html "<a href=\""(page_url active_page En)"\">"[Html.txt "English"]"</a>"]
  in
  mk_div1 "nav" (mk_div "nav-in"
    (List.map (fun p -> gen_link p lang) pages @ [change_lang_button]))

let%html head p lang =
{|
<head>
  <meta charset="utf-8"/>
  <title>|}(Html.txt @@
    (match lang with
    | En -> "Chuta Sano: " ^ page_name p lang
    | Ja -> "佐野忠太: " ^ page_name p lang
    )){|</title>
  <link rel=stylesheet href="main.css"/>
  <script src="main.js" defer></script>
</head>
|}

let mk_html p lang body =
  Html.html (head p lang)
    (Html.body [navbar p lang ; mk_div1 "body-content" body])
