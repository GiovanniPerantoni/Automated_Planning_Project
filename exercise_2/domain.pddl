(define (domain industial_planning_2)
  (:requirements :strips :typing :negative-preconditions :conditional-effects)

  (:types
    location - object     ; can contain workstations robots and boxes
    warehouse - location  ; contains supplies
    workstation - object  ; can get boxes and contain supplies
    robot - object        ; can pick up boxes, fill them, unload them and move between locations
    carrier - location    ; contains boxes if it has free spaces
    space - object        ; determines how many spaces a carrier has
    box - object          ; can contain supplies
    supply - object       ; required by workstations
    valve - supply        ; type of supply
    bolt - supply         ; type of supply
    tool - supply         ; type of supply
  )

  (:predicates
    ;; locations
    (connected ?l1 ?l2 - location)            ; location ?l1 is connected to location ?l2
    ;; boxes
    (bal ?b - box ?l - location)              ; box ?b is in the location ?l
    (bempty ?b - box)                         ; box ?b is empty
    (bfull ?b - box)                                   ; box ?b is full
    (sib ?s - supply ?b - box)                ; supply ?s is in box ?b
    ;; robots
    (ral ?r - robot ?l - location)            ; robot ?r is at location ?l
    (rhc ?r - robot ?c - carrier)             ; robot ?r has carrier ?c
    ;; workstations
    (wal ?w - workstation ?l - location)      ; workstation ?w is at location ?l
    (wcontains ?w - workstation ?s - supply)  ; workstation ?w contains supply ?s
    (has_valve ?w - workstation)              ; workstation ?w has a valve
    (has_bolt ?w - workstation)               ; workstation ?w has a bolt
    (has_tool ?w - workstation)               ; workstation ?w has a tool 
    (supply_available ?s - supply)            ; supply ?s is available
    ;; supplies
    (sal ?s - supply ?l - location)           ; supply ?s is at location ?l
    (is_valve ?s - supply)                    ; supply ?s is a valve
    (is_bolt ?s - supply)                     ; supply ?s is a bolt
    (is_tool ?s - supply)                     ; supply ?s is a tool
    ;; carrier space
    (free ?c - carrier ?s - space)            ; space ?s is not used carrier ?c
    (occupied ?c - carrier ?s - space)        ; space ?s is used by carrier ?c
  )

  ;; moves a robot with its carrier to a new location
  (:action move_carrier
    :parameters (?r - robot ?c - carrier ?from ?to - location)
    :precondition (and
      (connected ?from ?to)
      (ral ?r ?from)
      (rhc ?r ?c)
    )
    :effect (and
      (not (ral ?r ?from))
      (ral ?r ?to)
    )
  )

  ;; loads the carrier of a robot with a box
  (:action load_carrier
    :parameters (?r - robot ?c - carrier ?b - box ?s - space ?l - location)
    :precondition (and
      (ral ?r ?l)
      (bal ?b ?l)
      (rhc ?r ?c)
      (free ?c ?s)
    )
    :effect (and
      (not (bal ?b ?l))
      (bal ?b ?c)
      (not (free ?c ?s))
      (occupied ?c ?s)
    )
  )

  ;; unloads the carrier of a robot with a box
  (:action unload_carrier
    :parameters (?r - robot ?c - carrier ?b - box ?s - space ?l - location)
    :precondition (and
      (ral ?r ?l)
      (bal ?b ?c)
      (rhc ?r ?c)
      (occupied ?c ?s)
    )
    :effect (and
      (bal ?b ?l)
      (not (bal ?b ?c))
      (free ?c ?s)
      (not (occupied ?c ?s))
      )
  )

  ;; loads an empty box with a supply
  (:action load_supply
    :parameters (?r - robot ?l - location ?b - box ?s - supply)
    :precondition (and 
      (ral ?r ?l) 
      (bal ?b ?l) 
      (sal ?s ?l) 
      (bempty ?b) 
      (supply_available ?s)
    )
    :effect (and 
      (sib ?s ?b) 
      (not (bempty ?b)) 
      (bfull ?b)
      (not (sal ?s ?l))
    )
  )

  ;; unloads the content of a box to a given workstation
  (:action unload_supply
    :parameters (?r - robot ?b - box ?s - supply ?l - location ?w - workstation)
    :precondition (and 
      (ral ?r ?l) 
      (sib ?s ?b) 
      (bal ?b ?l) 
      (wal ?w ?l) 
      (bfull ?b)
    )
    :effect (and 
      (bempty ?b) 
      (not bfull ?b)
      (sal ?s ?l) 
      (wcontains ?w ?s) 
      (not (sib ?s ?b)) 
      (not (supply_available ?s))
      (when
        (is_valve ?s)
        (has_valve ?w))
      (when
        (is_bolt ?s)
        (has_bolt ?w))
      (when
        (is_tool ?s)
        (has_tool ?w))
    )
  )
)