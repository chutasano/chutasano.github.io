(lang dune 3.13)

(name main)

(generate_opam_files true)

(authors "Chuta Sano")

(maintainers "chutasano@gmail.com")

(source (github "chutasano/chutasano.github.io"))

(package
  (name main)
  (synopsis "webgen")
  (depends 
    (ocaml (>= 5.0.0))
    dune)
  )
