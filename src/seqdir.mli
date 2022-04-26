module File : sig
  type t = [ `Dir of string | `File of string ]

  val to_string : t -> string
  val pp : Format.formatter -> t -> unit
  val equal : t -> t -> bool
end

val list : ?max_depth:int -> string -> File.t Seq.t
