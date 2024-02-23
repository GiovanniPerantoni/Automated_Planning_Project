(define (domain industial_planning_1)
  (:requirements :strips ::typing)
  
  (:types
    location - object       ; can contain workstations robots and boxes
    warehouse - loaction    ; location where the supplies are picked up
    workstation - location  ; can get boxes and contain supplies
    robot - object          ; can pick up boxes, fill them, unload them and move between locations
    box - object            ; can contain supplies
    supply - object         ; required by workstations
    valve - supply          ; type of supply
    bolt - supply           ; type of supply
    tool - supply           ; type of supply
  )

  ;(:constants)

  (:predicates
    (connected ?l1 ?l2 - location)        ; location ?l1 is connected to location ?l2
    (waal ?a - warehouse ?l - location)   ; warehouse ?a is at location ?l
    (wal ?w - workstation ?l - location)  ; workstation ?w is in location ?l
    ; (bal ?b - box ?l - location)          ; box ?b is in location ?l
    
    (baw ?b - box ?w - workstation)       ; box ?b is in workstation ?w
    (bempty ?b - box)                     ; box ?b is empty
    (bcontains ?b - box ?s - supply)      ; box ?b contains supply s ;;TODO: verificare funzioni typing 
    
    (rat ?r - robot ?l - location)        ; robot ?r is at location ?l
    (rempty ?r - robot)                   ; robot ?r has no boxes
    (box_on_robot ?b - box ?r - robot)    ; box ?b in on robot ?r

  )

  (:action ...
  )

)