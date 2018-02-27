open Astwithposition
open Utils
open BatOption

module Option = BatOption
let bind x f = Option.bind f x
let id x = x

let blank_s = "_"
let blank_error x = Printf.sprintf "Error: _ not allowed in this context: line %d" x
let helper s = if s = blank_s then [ blank_error 0 ] else []

let rec blank_def (t: typesDef) =
  match t with
  | TypeT s -> helper s
  | ArrayT (s, _) -> helper s
  | SliceT (s, _) -> helper s
  | StructT l ->
    l
    |> List.map (fun (ls, ts) ->
      List.map helper ls
      |> List.flatten
      |> List.append (blank_def ts)
    )
    |> List.flatten

let rec blank_exp (e: exp node) : string list =
    match e.value with
    | Id l -> blank_kind l
    | BinaryOp (_, (a, b)) ->
      blank_exp a
      |> List.append (blank_exp b)
    | Unaryexp (_, a) -> blank_exp a
    | FuncCall (_, l) ->
      l
      |> List.map blank_exp
      |> List.flatten
    | Append (a, b) ->
      blank_exp a
      |> List.append (blank_exp b)
    | _ -> []
and blank_kind (k: kind) : string list =
  k
  |> List.map (fun x ->
    match x with
    | Variable s -> helper s
    | Array (s, l) ->
      l
      |> List.map blank_exp
      |> List.append [helper s]
      |> List.flatten
  )
  |> List.flatten

let blank_simple (s: simpleStm node) =
  match s.value with
  | Assign (_, (l, e)) ->
    e
    |> List.map blank_exp
    |> List.flatten
    |> List.append (List.map blank_kind l |> List.flatten)
  | ExpStatement e -> blank_exp e
  | DoublePlus s -> helper s
  | DoubleMinus s -> helper s
  | ShortDeclaration (l, e) ->
    e
    |> List.map blank_exp
    |> List.flatten
    |> List.append (List.map blank_kind l |> List.flatten)
  | Empty -> []

let rec blank_stm (s: stmt node) : string list =
  match s.value with
  | Block l ->
    l
    |> List.map blank_stm
    |> List.flatten
  | Print l ->
    l
    |> List.map blank_exp
    |> List.flatten
  | Println l ->
    l
    |> List.map blank_exp
    |> List.flatten
  | Declaration l ->
    l
    |> List.map (fun (s, _, es) ->
      List.map blank_exp es
      |> List.flatten
    )
    |> List.flatten
  | TypeDeclaration l ->
    l
    |> List.exists (fun (s, ts) ->
      s = blank_s || blank_def ts
    )
  | If (s, e, l, el) ->
    s
    |> bind (fun x -> Some (blank_simple x))
    |> Option.default false
    || e
      |> bind (fun x -> Some (blank_exp x))
      |> Option.default false
    || l
      |> List.exists blank_stm
    || el
      |> Option.map (fun x -> List.exists blank_stm x)
      |> Option.default false
  | Loop l ->
    (match l with
    | While (e, l) ->
      e |> Option.map blank_exp |> Option.default false
    | For (s1, e, s2, l) ->
      blank_simple s1
      || blank_simple s2
      || e |> Option.map blank_exp |> Option.default false
      || List.exists blank_stm l
    )
  | Simple s -> blank_simple s
  | Return e -> e |> Option.map blank_exp |> Option.default false
  | _ -> false

let illegal_blanks (prog: program) =
  let p, d = prog in
  let blanks =
    d
    |> List.map (fun x ->
      match x.value with
      | Var l ->
        l
        |> List.exists (fun (_, _, exps) ->
          exps
          |> List.exists (fun x -> blank_exp x)
        )
      | Fct (n, args, _, l) ->
        n = blank_s
        || List.exists blank_stm l
      | _ -> false
    ) in
  blanks |> List.exists id
