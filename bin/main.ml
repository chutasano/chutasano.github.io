open Tyxml

let%html t = 
{|
<div>
  <h1>Hello World</h1>
  <p>I think I am a PhD student at McGill University</p>
  <p>The only content of interest so far is my publications page -- sorry.</p>
</div>
|}

let index = Html.html (Aux.head Aux.Home) (Html.body @@ [Aux.navbar Aux.Home] @ [t])

let pages = 
  [ (index, "index.html");
   (Publications.src (), "publications.html");
   (Contact.src (), "contact.html")]

let () =
  List.iter (fun (src, name) ->
    let ofile = open_out name in
    let fmt = Format.formatter_of_out_channel ofile in
    Html.pp () fmt src; close_out ofile)
  pages

