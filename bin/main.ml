open Tyxml

let mk_page page page_fn lang =
  let open H in
  (mk_html page lang (page_fn lang), page_url page lang)
  

let pages =
[
  mk_page Home Home.src En;
  mk_page Home Home.src Ja;
  mk_page Publications Publications.src En;
  mk_page Publications Publications.src Ja;
(* TODO: Fix Cv page
   (mk_html Cv (Cv.src ()), page_url Cv);
 *)
  mk_page Contact Contact.src En;
  mk_page Contact Contact.src Ja;
]

let () =
  List.iter (fun (src, name) ->
    let ofile = open_out name in
    let fmt = Format.formatter_of_out_channel ofile in
    Html.pp () fmt src; close_out ofile)
  pages

