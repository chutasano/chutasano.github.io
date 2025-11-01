open Tyxml

let pages = let open Aux in [
(mk_html Home (Home.src ()), page_url Home);
(mk_html Publications (Publications.src ()), page_url Publications);
(* TODO: Fix Cv page
   (mk_html Cv (Cv.src ()), page_url Cv);
 *)
(mk_html Contact (Contact.src ()), page_url Contact);
]

let () =
  List.iter (fun (src, name) ->
    let ofile = open_out name in
    let fmt = Format.formatter_of_out_channel ofile in
    Html.pp () fmt src; close_out ofile)
  pages

