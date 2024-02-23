(define (domain industial_planning_1)
  (:requirements :strips :typing :negative-preconditions :conditional-effects)

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
    ; (whal ?w - warehouse ?l - location)       ; warehouse ?w is in location ?l

    ;; boxes
    (bal ?b - box ?l - location) ; box ?b is in the location ?l
    ; (baw ?b - box ?w - workstation) ; box ?b is in workstation ?w
    (bor ?b - box ?r - robot) ; box ?b on robot ?r
    (bempty ?b - box) ; box ?b is empty
    (sib ?s - supply ?b - box) ; supply ?s is in box ?b

    ;; robots
    (ral ?r - robot ?l - location) ; robot ?r is at location ?l
    ; (rawh ?r - robot ?wa - warehouse)    ; robot ?r is at warehouse ?wa
    (rloaded ?r - robot) ; robot ?r has a boxe

    ;; workstations
    (wal ?w - workstation ?l - location) ; workstation ?w is at location ?l
    (wcontains ?w - workstation ?s - supply) ; workstation ?w contains supply ?s
    (has_valve ?w - workstation) ; workstation ?w has a valve
    (has_bolt ?w - workstation) ; workstation ?w has a bolt
    (has_tool ?w - workstation) ; workstation ?w has a tool 

    ;; supplies
    (sal ?s - supply ?l - location) ; supply ?s is at location ?l
    (is_valve ?s - supply) ; supply ?s is a valve
    (is_bolt ?s - supply) ; supply ?s is a bolt
    (is_tool ?s - supply) ; supply ?s is a tool
  )

  ;; moves a robot between two connected locations
  (:action move
    :parameters (?r - robot ?from ?to - location)
    :precondition (and (connected ?from ?to)
      (ral ?r ?from)
    )
    :effect (and (ral ?r ?to)
      (not (ral ?r ?from))
    )
  )

  ;; moves a robot between two connected locations
  (:action move_box
    :parameters (?r - robot ?b - box ?from ?to - location)
    :precondition (and (connected ?from ?to)
      (ral ?r ?from)
      (bal ?b ?from)
      (bor ?r ?b)
    )
    :effect (and (ral ?r ?to)
      (not (ral ?r ?from))
      (not (bal ?b ?from))
      (bal ?b ?to)
    )
  )
  ;; loads an empty robot with a box
  (:action load_robot
    :parameters (?r - robot ?l - location ?b - box)
    :precondition (and (ral ?r ?l) (not (rloaded ?r)) (bal ?b ?l))
    :effect (and (rloaded ?r) (bor ?b ?r))
  )

  ;; unloads the box from a robot
  (:action unload_robot
    :parameters (?r - robot ?b - box)
    :precondition (and (not (rloaded ?r)) (bor ?b ?r))
    :effect (and (not (rloaded ?r)) (not (bor ?b ?r)))
  )

  ;; loads an empty robot with a box
  (:action load_supply
    :parameters (?r - robot ?l - location ?b - box ?s - supply)
    :precondition (and (ral ?r ?l) (bal ?b ?l) (sal ?s ?l) (bempty ?b))
    :effect (and (sib ?s ?b) (not (bempty ?b)) (not (sal ?s ?l)))
  )

  ;; unloads the box from a robot
  ; (:action unload_supply
  ;   :parameters (?r - robot ?b - box ?s - supply ?l - location ?w - workstation)
  ;   :precondition (and (ral ?r ?l) (sib ?s ?b) (bal ?b ?l) (wal ?w ?l))
  ;   :effect (and (not (rloaded ?r)) (not (bor ?b ?r)) (bempty ?b) (sal ?s ?l) (wcontains ?w ?s))
  ; )
  (:action unload_supply
    :parameters (?r - robot ?b - box ?s - supply ?l - location ?w - workstation)
    :precondition (and (ral ?r ?l) (sib ?s ?b) (bal ?b ?l) (wal ?w ?l))
    :effect (and (not (rloaded ?r)) (not (bor ?b ?r)) (bempty ?b) (sal ?s ?l) (wcontains ?w ?s)
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