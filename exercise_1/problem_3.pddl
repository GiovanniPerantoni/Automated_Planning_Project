(define (problem problem1_3)
  (:domain logistic_planning_1)

  (:objects
    robot1 - robot
    warehouse_loc location1 location2 location3 location4 - location
    workstation1 workstation2 workstation3 workstation4 - workstation
    warehouse1 - warehouse
    box1 - box
    valve1 valve2 - valve
    bolt1 bolt2 - bolt
    tool1 tool2 - tool
  )

  (:init
    ; graph edges
    (connected warehouse_loc location1)
    (connected location1 warehouse_loc)
    (connected location1 location2)
    (connected location2 location3)
    (connected location2 location4)
    (connected location3 warehouse_loc)
    (connected location3 location1)
    (connected location4 location3)
    ; box location
    (box_at_loc box1 warehouse_loc)
    ; box empty
    (box_empty box1)
    ; robot location
    (robot_at_loc robot1 warehouse_loc)
    ; robot unloaded
    (robot_unloaded robot1)
    ; workstation location
    (ws_at_loc workstation1 location2)
    (ws_at_loc workstation2 location3)
    (ws_at_loc workstation3 location4)
    (ws_at_loc workstation4 location4)
    ; supplies location
    (supply_at_loc valve1 warehouse_loc)
    (supply_at_loc valve2 warehouse_loc)
    (supply_at_loc bolt1 warehouse_loc)
    (supply_at_loc bolt2 warehouse_loc)
    (supply_at_loc tool1 warehouse_loc)
    (supply_at_loc tool2 warehouse_loc)
    ; supplies availabity
    (supply_available valve1)
    (supply_available valve2)
    (supply_available bolt1)
    (supply_available bolt2)
    (supply_available tool1)
    (supply_available tool2)
  )

  (:goal (and
    (robot_at_loc robot1 warehouse_loc)  ; 0
    (has_valve workstation1)    ; 1
    (has_valve workstation4)    ; 2
    (has_bolt workstation3)     ; 3
    (has_bolt workstation4)     ; 4
    (has_tool workstation2)     ; 5
    (has_tool workstation3)     ; 6
  ))
)