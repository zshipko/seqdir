module Entry : sig
  type t = [ `Dir of string | `File of string ]

  val filename : t -> string
  val pp : Format.formatter -> t -> unit
  val equal : t -> t -> bool
end

val list : ?max_depth:int -> string -> Entry.t Seq.t
(** [list ~max_depth path] will create a sequence of [Entry.t] with files from [path].

    [max_depth] determines how deep to recurse. When [max_depth] is 0 no directories will
    be listed (including those in [path]) and when [max_depth] < 0 all nested directories
    will be traversed.
*)
