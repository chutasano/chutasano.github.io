open Tyxml

let%html t = 
{|
<div>
  <h1>Introduction</h1>
  <p>I am a PhD student in the Computer Science department at McGill University. My advisor is Prof. Brigitte Pientka.</p>
  <p>Right now, I mainly work on interoperability between languages with diverse semantics. In the past, I have worked on mechanization techniques for substructural languages, (binary) session types and shared session types, security, and robotics.</p>
</div>
|}

let index = Html.html (Aux.head Aux.Home) (Html.body @@ [Aux.navbar Aux.Home] @ [t])

let pages = 
  [ (index, Aux.page_url Aux.Home);
   (Publications.src (), Aux.page_url Aux.Publications);
   (Cv.src (), Aux.page_url Aux.Cv);
   (Contact.src (), Aux.page_url Aux.Contact)]

let () =
  List.iter (fun (src, name) ->
    let ofile = open_out name in
    let fmt = Format.formatter_of_out_channel ofile in
    Html.pp () fmt src; close_out ofile)
  pages

