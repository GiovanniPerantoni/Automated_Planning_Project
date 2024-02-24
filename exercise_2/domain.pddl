(define (domain industial_planning_2)
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

    carrier - location
    ;; space - object
    )

  ;(:constants)

  (:predicates

    ;; locations
    (connected ?l1 ?l2 - location) ; location ?l1 is connected to location ?l2

    ;; boxes
    (bal ?b - box ?l - location) ; box ?b is in the location ?l
    ; (boc ?b - box ?c - carrier) ; box ?b on robot ?r
    (bempty ?b - box) ; box ?b is empty
    (sib ?s - supply ?b - box) ; supply ?s is in box ?b

    ;; robots
    (ral ?r - robot ?l - location) ; robot ?r is at location ?l
    (rloaded ?r - robot) ; robot ?r has a boxe
    (rhc ?r - robot ?c - carrier) ; robot ?r has carrier ?c

    ;; workstations
    (wal ?w - workstation ?l - location) ; workstation ?w is at location ?l
    (wcontains ?w - workstation ?s - supply) ; workstation ?w contains supply ?s
    (has_valve ?w - workstation) ; workstation ?w has a valve
    (has_bolt ?w - workstation) ; workstation ?w has a bolt
    (has_tool ?w - workstation) ; workstation ?w has a tool 
    (supply_available ?s - supply) ; supply ?s is available
    ;; supplies
    (sal ?s - supply ?l - location) ; supply ?s is at location ?l
    (is_valve ?s - supply) ; supply ?s is a valve
    (is_bolt ?s - supply) ; supply ?s is a bolt
    (is_tool ?s - supply) ; supply ?s is a tool

    ; (has_space ?r - robot ?s - space)
    ; (is_free ?s - space)
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
    :parameters (?r - robot ?b - box ?c - carrier ?l - location)
    :precondition (and
      (ral ?r ?l) 
      (bal ?b ?l) 
      (rhc ?r ?c)
      (not (rloaded ?r))
    )
    :effect (and 
      (not (bal ?b ?l)) 
      (bal ?b ?c) 
      (rloaded ?r)
    )
  ) 

  ;; unloads the carrier of a robot with a box
  (:action unload_carrier
    :parameters (?r - robot ?b - box ?c - carrier ?l - location)
    :precondition (and
      (rloaded ?r)
      (ral ?r ?l)
      (bal ?b ?c)
    )
    :effect (and
      (not (rloaded ?r))
      (bal ?b ?l)
      (not (bal ?b ?c))
    )
  )

  ;; loads an empty box with a supply
  (:action load_supply
    :parameters (?r - robot ?l - location ?b - box ?s - supply)
    :precondition (and (ral ?r ?l) (bal ?b ?l) (sal ?s ?l) (bempty ?b) (supply_available ?s))
    :effect (and (sib ?s ?b) (not (bempty ?b)) (not (sal ?s ?l)))
  )

  ;; unloads the content of a box to a given workstation
  (:action unload_supply
    :parameters (?r - robot ?b - box ?s - supply ?l - location ?w - workstation)
    :precondition (and (ral ?r ?l) (sib ?s ?b) (bal ?b ?l) (wal ?w ?l) (not (bempty ?b)))
    :effect (and (bempty ?b) (sal ?s ?l) (wcontains ?w ?s) (not (sib ?s ?b)) (not (supply_available ?s))
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