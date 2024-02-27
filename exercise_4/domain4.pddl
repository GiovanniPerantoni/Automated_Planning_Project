(define (domain logistic_planning_2)
  (:requirements :strips :typing ::durative-actions)

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
    (box_at_loc ?b - box ?l - location)              ; box ?b is in the location ?l
    (box_empty ?b - box)                         ; box ?b is empty
    (box_full ?b - box)                                   ; box ?b is full
    (supply_in_box ?s - supply ?b - box)                ; supply ?s is in box ?b
    ;; robots
    (robot_at_loc ?r - robot ?l - location)            ; robot ?r is at location ?l
    (robot_has_carrier ?r - robot ?c - carrier)             ; robot ?r has carrier ?c
    ;; workstations
    (ws_at_loc ?w - workstation ?l - location)      ; workstation ?w is at location ?l
    (ws_contains_supply ?w - workstation ?s - supply)  ; workstation ?w contains supply ?s
    (has_valve ?w - workstation)              ; workstation ?w has a valve
    (has_bolt ?w - workstation)               ; workstation ?w has a bolt
    (has_tool ?w - workstation)               ; workstation ?w has a tool 
    (supply_available ?s - supply)            ; supply ?s is available
    ;; supplies
    (supply_at_loc ?s - supply ?l - location)           ; supply ?s is at location ?l
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
      (robot_at_loc ?r ?from)
      (robot_has_carrier ?r ?c)
    )
    :effect (and
      (not (robot_at_loc ?r ?from))
      (robot_at_loc ?r ?to)
    )
  )

  ;; loads the carrier of a robot with a box
  (:action load_carrier
    :parameters (?r - robot ?c - carrier ?b - box ?s - space ?l - location)
    :precondition (and
      (robot_at_loc ?r ?l)
      (box_at_loc ?b ?l)
      (robot_has_carrier ?r ?c)
      (free ?c ?s)
    )
    :effect (and
      (not (box_at_loc ?b ?l))
      (box_at_loc ?b ?c)
      (not (free ?c ?s))
      (occupied ?c ?s)
    )
  )

  ;; unloads the carrier of a robot with a box
  (:action unload_carrier
    :parameters (?r - robot ?c - carrier ?b - box ?s - space ?l - location)
    :precondition (and
      (robot_at_loc ?r ?l)
      (box_at_loc ?b ?c)
      (robot_has_carrier ?r ?c)
      (occupied ?c ?s)
    )
    :effect (and
      (box_at_loc ?b ?l)
      (not (box_at_loc ?b ?c))
      (free ?c ?s)
      (not (occupied ?c ?s))
      )
  )

  ;; loads an empty box with a supply
  (:action load_supply
    :parameters (?r - robot ?l - location ?b - box ?s - supply)
    :precondition (and 
      (robot_at_loc ?r ?l) 
      (box_at_loc ?b ?l) 
      (supply_at_loc ?s ?l) 
      (box_empty ?b) 
      (supply_available ?s)
    )
    :effect (and 
      (supply_in_box ?s ?b) 
      (not (box_empty ?b)) 
      (box_full ?b)
      (not (supply_at_loc ?s ?l))
    )
  )

  ;; unloads the content of a box to a given workstation
  (:action unload_supply
    :parameters (?r - robot ?b - box ?s - supply ?l - location ?w - workstation)
    :precondition (and 
      (robot_at_loc ?r ?l) 
      (supply_in_box ?s ?b) 
      (box_at_loc ?b ?l) 
      (ws_at_loc ?w ?l) 
      (box_full ?b)
    )
    :effect (and 
      (box_empty ?b) 
      (not (box_full ?b))
      (supply_at_loc ?s ?l) 
      (ws_contains_supply ?w ?s) 
      (not (supply_in_box ?s ?b)) 
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