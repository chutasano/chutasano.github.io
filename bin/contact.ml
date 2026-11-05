open Tyxml

let email = "chuta.sano@mail.mcgill.ca"

let%html txt_en =
{|
<div>
  <h1>To Contact Me...</h1>
  <p><a href="|}("mailto:" ^ email){|">|}[Html.txt email]{|</a></p>
  <p>TODO: Add instructions on what subject line, email address, and tone you should use when contacting me once I'm sufficiently senior enough. For now, I will read all emails.</p>
</div>
|}

let%html txt_ja =
{|
<div>
  <h1>連絡先</h1>
  <p><a href="|}("mailto:" ^ email){|">|}[Html.txt email]{|</a></p>
</div>
|}

let src lang =
  match lang with
  | H.En -> txt_en
  | H.Ja -> txt_ja
