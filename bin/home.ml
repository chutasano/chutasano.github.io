open Tyxml

let%html txt_en = 
{|
<div>
  <h1>Introduction</h1>
  <p>I am a PhD student in the Computer Science department at McGill University. My advisor is Prof. Brigitte Pientka. I have a Master's degree in Computer Science from Carnegie Mellon University and a Bachelor's degree in Computer Science at University of Massachusetts Lowell.</p>
  <p>Right now, I mainly work on interoperability between languages with diverse semantics. In the past, I have worked on mechanization techniques for substructural languages, (binary) session types and shared session types, security, and robotics.</p>
</div>
|}

let%html txt_ja = 
{|
<div>
  <h1>自己紹介</h1>
  <p>マギル大学のComputer Science（計算機科学）学科の博士課程の学生です。指導教員はBrigitte Pientka教授です。カーネギーメロン大学でComputer Scienceの修士号を、マサチューセッツ大学ローウェル校でComputer Scienceの学士号を取得しました。</p>
  <p>現在、主に多様なセマンティクスを持つ言語間の相互運用性(interoperability)に取り組んでいます。過去には、proof assistant/mechanization、(binary/shared) session type、セキュリティ、ロボティクスに取り組んできました</p>
</div>
|}

let src lang = match lang with
  H.En -> txt_en
| H.Ja -> txt_ja

