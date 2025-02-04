open Bibtex.Fields

(*val src : unit -> doc*)

let bib_name = "resources/cs.bib"
(* custom fields *)
let csc_acronym = str_field ~name:"csc_acronym"
let csc_errata = str_field ~name:"csc_errata"
let csc_hide = str_field ~name:"csc_hide" (* consider making this bool *)
let csc_parent = str_field ~name:"csc_parent"

let gen_keys () =
  let ( |>> ) database named_field =
    Database.add named_field.name (str named_field) database
  in
  default_keys
  |>> csc_acronym
  |>> csc_errata
  |>> csc_hide
  |>> csc_parent

let items_gather_children is =
  let item_gather_children i_k is =
    List.filter
      (fun (_, i) -> (match i.%{csc_parent.f} with
      | None -> false
      | Some(parent_k) -> i_k = parent_k)) is
  in
  List.fold_left
    (fun acc (k, i) ->
      if (Option.is_some i.%{csc_parent.f}) then acc (* will be included as part of some other entry*)
      else ((k, i), item_gather_children k is)::acc)
    [] is

let div_bibtex_item (_, i) =
  let author_names = Option.get i.%{authors.f} in
  let author_strs = List.map (fun n -> n.firstname ^ " " ^ n.lastname) author_names in
  let author_str = (match author_strs with
    | [] -> ""
    | [s] -> s
    | s1::[s2] -> s1 ^ " and " ^ s2
    | s::strs ->
        let len = List.length strs in
        let (str, _) = List.fold_left
          (fun (str, i) s -> if (i + 1) = len then (str ^ ", and " ^ s, i + 1) else (str ^ ", " ^ s, i + 1))
          (s, 0) strs in
        str
  ) in
  let title_str = Option.get i.%{title.f} in
  let year_str = string_of_int (Option.get i.%{year.f}) in
  let acr_str = i.%{csc_acronym.f} in
  let term_str = (match acr_str with
    | None -> year_str
    | Some(s) -> s ^ "'" ^ year_str) in
  let doi = i.%{doi.f} in
  let links = [Option.map (fun doi -> ("https://doi.org/" ^ (String.concat "/" doi), "doi")) doi] in
  let open Tyxml.Html in
  let cite = txt (author_str ^ ". " ^ title_str ^ ", " ^ term_str) in
  let cite_links = List.map (fun (url, text) -> Aux.href url text) @@ List.map Option.get @@ List.filter Option.is_some links in
  let cite_links' = match cite_links with
    | [] -> []
    | _ -> [txt " ["] @ cite_links @ [txt "]"] in
  div ([cite] @ cite_links')

let div_bibtex_entries (parent, children) =
  let divs_children = List.map div_bibtex_item children in
  if List.is_empty divs_children then div_bibtex_item parent
  else
    let div_parent = div_bibtex_item parent in
    let open Tyxml.Html in
    div ~a:[a_class["pubs_parent"]] [button [txt "+"]; div_parent; br (); div ~a:[a_class["pubs_children"]] divs_children]

let src () =
  let ifile = open_in bib_name in
  let pubs_map = Bibtex.parse ~with_keys:(gen_keys ()) (Lexing.from_channel ifile) in
  let pubs = List.sort
    (fun (_, i1) (_, i2) ->
      let y1, y2 = (Option.get i1.%{year.f}, Option.get i2.%{year.f}) in
      (* allowing months to be omitted *)
      let m1, m2 = (Option.value ~default:1 i1.%{month.f}, Option.value ~default:1 i2.%{month.f}) in
      compare (y1, m1) (y2, m2))
    (Bibtex.Database.bindings pubs_map) in
  (* if any are set to be hidden, remove them here *)
  let pubs' = List.filter (fun (_, i) -> not @@ bool_of_string @@ Option.value ~default:"false" i.%{csc_hide.f}) pubs in
  (* gather entries into lists of (i, i_list) where i_list contains all children of i *)
  let pubs'' = items_gather_children pubs' in
  let divs = List.map div_bibtex_entries (List.rev pubs'') in
  let open Tyxml.Html in
  let t1 = div [h1 [txt "Publications"]] in
  let index = html (Aux.head Aux.Publications) (body @@ [Aux.navbar Aux.Publications] @ [t1] @ divs) in
  index

