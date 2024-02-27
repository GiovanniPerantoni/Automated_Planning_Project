(define (domain logistic_planning_1)
  (:requirements :strips :typing)

  (:types
    location - object ; can contain workstations robots and boxes
    warehouse - location ; contains supplies
    workstation - object ; can get boxes and contain supplies
    robot - object ; can pick up boxes, fill them, unload them and move between locations
    box - object ; can contain supplies
    supply - object ; required by workstations
    valve - supply ; type of supply
    bolt - supply ; type of supply
    tool - supply ; type of supply
    )

  ;(:constants)

  (:predicates

    ;; locations
    (connected ?l1 ?l2 - location) ; location ?l1 is connected to location ?l2

    ;; boxes
    (box_at_loc ?b - box ?l - location) ; box ?b is in the location ?l
    (box_on_robot ?b - box ?r - robot) ; box ?b on robot ?r
    (box_empty ?b - box) ; box ?b is empty
    (box_full ?b - box) ; box ?b is full
    (supply_in_box ?s - supply ?b - box) ; supply ?s is in box ?b

    ;; robots
    (robot_at_loc ?r - robot ?l - location) ; robot ?r is at location ?l
    (robot_unloaded ?r - robot) ; robot ?r doesen't have a box
    (robot_loaded ?r - robot) ; robot ?r has a boxe

    ;; workstations
    (ws_at_loc ?w - workstation ?l - location) ; workstation ?w is at location ?l
    (ws_contains ?w - workstation ?s - supply) ; workstation ?w contains supply ?s
    (has_valve ?w - workstation) ; workstation ?w has a valve
    (has_bolt ?w - workstation) ; workstation ?w has a bolt
    (has_tool ?w - workstation) ; workstation ?w has a tool 
    (supply_available ?s - supply) ; supply ?s is available
    ;; supplies
    (supply_at_loc ?s - supply ?l - location) ; supply ?s is at location ?l
  )

  ;; moves a robot between two connected locations
  (:action move
    :parameters (?r - robot ?from ?to - location)
    :precondition (and
      (connected ?from ?to)
      (robot_at_loc ?r ?from)
      (robot_unloaded ?r)
    )
    :effect (and
      (robot_at_loc ?r ?to)
      (not (robot_at_loc ?r ?from))
    )
  )

  ;; loads an empty robot with a box
  (:action load_robot
    :parameters (?r - robot ?b - box ?l - location)
    :precondition (and
      (robot_at_loc ?r ?l)
      (robot_unloaded ?r)
      (box_at_loc ?b ?l)
    )
    :effect (and
      (not (robot_unloaded ?r))
      (robot_loaded ?r)
      (box_on_robot ?b ?r)
      (not (box_at_loc ?b ?l))
    )
  )

  ;; moves a robot between two connected locations
  (:action move_box
    :parameters (?r - robot ?b - box ?from ?to - location)
    :precondition (and
      (connected ?from ?to)
      (robot_at_loc ?r ?from)
      (box_on_robot ?b ?r)
    )
    :effect (and
      (robot_at_loc ?r ?to)
      (not (robot_at_loc ?r ?from))
      (not (box_at_loc ?b ?from))
      (box_at_loc ?b ?to)
    )
  )

  ;; unloads the box from a robot
  (:action unload_robot
    :parameters (?r - robot ?b - box)
    :precondition (and
      (robot_loaded ?r)
      (box_on_robot ?b ?r)
    )
    :effect (and
      (not (robot_loaded ?r))
      (robot_unloaded ?r)
      (not (box_on_robot ?b ?r))
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

  ;; unloads the content of a box to a given workstation (:action unload_supply
  (:action unload_valve
    :parameters (?r - robot ?b - box ?valve - valve ?l - location ?w - workstation)
    :precondition (and
      (robot_at_loc ?r ?l)
      (supply_in_box ?valve ?b)
      (box_at_loc ?b ?l)
      (ws_at_loc ?w ?l)
      (box_full ?b)
      ;; (is_valve ?s)
    )
    :effect (and
      (box_empty ?b)
      (not (box_full ?b))
      (supply_at_loc ?valve ?l)
      (ws_contains ?w ?valve)
      (not (supply_in_box ?valve ?b))
      (not (supply_available ?valve))
      (has_valve ?w)
    )
  )

  (:action unload_bolt
    :parameters (?r - robot ?b - box ?bolt - bolt ?l - location ?w - workstation)
    :precondition (and
      (robot_at_loc ?r ?l)
      (supply_in_box ?bolt ?b)
      (box_at_loc ?b ?l)
      (ws_at_loc ?w ?l)
      (box_full ?b)
      ;; (is_bolt ?bolt)
    )
    :effect (and
      (box_empty ?b)
      (not (box_full ?b))
      (supply_at_loc ?bolt ?l)
      (ws_contains ?w ?bolt)
      (not (supply_in_box ?bolt ?b))
      (not (supply_available ?bolt))
      (has_bolt ?w)
    )
  )
  (:action unload_tool
    :parameters (?r - robot ?b - box ?tool - tool ?l - location ?w - workstation)
    :precondition (and
      (robot_at_loc ?r ?l)
      (supply_in_box ?tool ?b)
      (box_at_loc ?b ?l)
      (ws_at_loc ?w ?l)
      (box_full ?b)
      ; (is_tool ?tool)
    )
    :effect (and
      (box_empty ?b)
      (not (box_full ?b))
      (supply_at_loc ?tool ?l)
      (ws_contains ?w ?tool)
      (not (supply_in_box ?tool ?b))
      (not (supply_available ?tool))
      (has_tool ?w)
    )
  )
)