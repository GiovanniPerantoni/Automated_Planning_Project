(define (domain logistic_planning_4)
  (:requirements :strips :typing :durative-actions)

  (:types
    location - object ; can contain workstations robots and boxes
    carrier - location ; contains boxes if it has free spaces
    workstation - object ; can get boxes and contain supplies
    robot - object ; can pick up boxes, fill them, unload them and move between locations
    ; warehouse - location ; contains supplies
    space - object ; determines how many spaces a carrier has
    box - object ; can contain supplies
    supply - object ; required by workstations
    valve - supply ; type of supply
    bolt - supply ; type of supply
    tool - supply ; type of supply
    )

  (:predicates
    ;; locations
    (connected ?l1 ?l2 - location) ; location ?l1 is connected to location ?l2
    ;; boxes
    (box_at_loc ?b - box ?l - location) ; box ?b is in the location ?l
    (box_empty ?b - box) ; box ?b is empty
    (box_full ?b - box) ; box ?b is full
    (supply_in_box ?s - supply ?b - box) ; supply ?s is in box ?b
    ;; robots
    (robot_at_loc ?r - robot ?l - location) ; robot ?r is at location ?l
    (robot_has_carrier ?r - robot ?c - carrier) ; robot ?r has carrier ?c
    ;; workstations
    (ws_at_loc ?w - workstation ?l - location) ; workstation ?w is at location ?l
    ; (ws_contains_supply ?w - workstation ?s - supply) ; workstation ?w contains supply ?s
    (has_valve ?w - workstation) ; workstation ?w has a valve
    (has_bolt ?w - workstation) ; workstation ?w has a bolt
    (has_tool ?w - workstation) ; workstation ?w has a tool 
    (supply_available ?s - supply) ; supply ?s is available
    ;; supplies
    (supply_at_loc ?s - supply ?l - location) ; supply ?s is at location ?l
    ; (is_valve ?s - supply) ; supply ?s is a valve
    ; (is_bolt ?s - supply) ; supply ?s is a bolt
    ; (is_tool ?s - supply) ; supply ?s is a tool
    ; carrier space
    (free ?c - carrier ?s - space) ; space ?s is not used carrier ?c
    (occupied ?c - carrier ?s - space) ; space ?s is used by carrier ?c
  )

  (:durative-action move_carrier
    :parameters (?r - robot ?c - carrier ?from ?to - location)
    :duration (= ?duration 1)
    :condition (and
      (at start(connected ?from ?to))
      (at start(robot_at_loc ?r ?from))
      (at start(robot_has_carrier ?r ?c))
    )
    :effect (and
      (at start(not (robot_at_loc ?r ?from)))
      (at start(robot_at_loc ?r ?to))
    )
  )

  ;; loads the carrier of a robot with a box
  (:durative-action load_carrier
    :parameters (?r - robot ?c - carrier ?b - box ?s - space ?l - location)
    :duration (= ?duration 1)
    :condition (and
      (at start(robot_at_loc ?r ?l))
      (at start(box_at_loc ?b ?l))
      (at start(robot_has_carrier ?r ?c))
      (at start(free ?c ?s))
    )
    :effect (and
      (at start(not (box_at_loc ?b ?l)))
      (at start(box_at_loc ?b ?c))
      (at start(not (free ?c ?s)))
      (at start(occupied ?c ?s))
    )
  )

  ;; unloads the carrier of a robot with a box
  (:durative-action unload_carrier
    :parameters (?r - robot ?c - carrier ?b - box ?s - space ?l - location)
    :duration (= ?duration 1)
    :condition (and
      (at start(robot_at_loc ?r ?l))
      (at start(box_at_loc ?b ?c))
      (at start(robot_has_carrier ?r ?c))
      (at start(occupied ?c ?s))
    )
    :effect (and
      (at start(box_at_loc ?b ?l))
      (at start(not (box_at_loc ?b ?c)))
      (at start(free ?c ?s))
      (at start(not (occupied ?c ?s)))
    )
  )

  ;; loads an empty box with a supply
  (:durative-action load_supply
    :parameters (?r - robot ?l - location ?b - box ?s - supply)
    :duration (= ?duration 1)
    :condition (and
      (at start(robot_at_loc ?r ?l))
      (at start(box_at_loc ?b ?l))
      (at start(supply_at_loc ?s ?l))
      (at start(box_empty ?b))
      (at start(supply_available ?s))
    )
    :effect (and
      (at start(supply_in_box ?s ?b))
      (at start(not (box_empty ?b)))
      (at start(box_full ?b))
      (at start(not (supply_at_loc ?s ?l)))
    )
  )

  ;; unloads the content of a box to a given workstation 
  (:durative-action unload_valve
    :parameters (?r - robot ?b - box ?valve - valve ?l - location ?w - workstation)
    :duration (= ?duration 1)
    :condition (and
      (at start (robot_at_loc ?r ?l))
      (at start (supply_in_box ?valve ?b))
      (at start (box_at_loc ?b ?l))
      (at start (ws_at_loc ?w ?l))
      (at start (box_full ?b))
    )
    :effect (and
      (at start (box_empty ?b))
      (at start (not (box_full ?b)))
      (at start (supply_at_loc ?valve ?l))
      (at start (not (supply_in_box ?valve ?b)))
      (at start (not (supply_available ?valve)))
      (at start (has_valve ?w))
    )
  )

  ;; unloads the content of a box to a given workstation 
  (:durative-action unload_bolt
    :parameters (?r - robot ?b - box ?bolt - bolt ?l - location ?w - workstation)
    :duration (= ?duration 1)
    :condition (and
      (at start (robot_at_loc ?r ?l))
      (at start (supply_in_box ?bolt ?b))
      (at start (box_at_loc ?b ?l))
      (at start (ws_at_loc ?w ?l))
      (at start (box_full ?b))
    )
    :effect (and
      (at start (box_empty ?b))
      (at start (not (box_full ?b)))
      (at start (supply_at_loc ?bolt ?l))
      (at start (not (supply_in_box ?bolt ?b)))
      (at start (not (supply_available ?bolt)))
      (at start (has_bolt ?w))
    )
  )

  ;; unloads the content of a box to a given workstation 
  (:durative-action unload_tool
    :parameters (?r - robot ?b - box ?tool - tool ?l - location ?w - workstation)
    :duration (= ?duration 1)
    :condition (and
      (at start (robot_at_loc ?r ?l))
      (at start (supply_in_box ?tool ?b))
      (at start (box_at_loc ?b ?l))
      (at start (ws_at_loc ?w ?l))
      (at start (box_full ?b))
    )
    :effect (and
      (at start (box_empty ?b))
      (at start (not (box_full ?b)))
      (at start (supply_at_loc ?tool ?l))
      (at start (not (supply_in_box ?tool ?b)))
      (at start (not (supply_available ?tool)))
      (at start (has_tool ?w))
    )
  )
)