open Tyxml

let%html t = 
{|
<div>
  <h1>Introduction</h1>
  <p>I am a PhD student in the Computer Science department at McGill University. My advisor is Prof. Brigitte Pientka. I have a Master's degree in Computer Science from Carnegie Mellon University and a Bachelor's degree in Computer Science at University of Massachusetts Lowell.</p>
  <p>Right now, I mainly work on interoperability between languages with diverse semantics. In the past, I have worked on mechanization techniques for substructural languages, (binary) session types and shared session types, security, and robotics.</p>
</div>
|}

let src () = t

