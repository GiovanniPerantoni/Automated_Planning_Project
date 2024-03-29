(define (problem problem1_1)
  (:domain logistic_planning_1)

  (:objects
    cargo - robot
    warehouse_loc location1 location2 - location
    workstation1 workstation2 workstation3 - workstation
    box1 box2 box3 - box
    valve1 valve2 - valve
    bolt1 bolt2 - bolt
    tool1 tool2 - tool
  )

  (:init
    ;; graph edges
    (connected warehouse_loc location1)
    (connected warehouse_loc location2)
    (connected location1 warehouse_loc)
    (connected location1 location2)
    (connected location2 warehouse_loc)
    (connected location2 location1)
    ;; box location
    (box_at_loc box1 warehouse_loc)
    (box_at_loc box2 warehouse_loc)
    (box_at_loc box3 warehouse_loc)
    ;; box empty
    (box_empty box1)
    (box_empty box2)
    (box_empty box3)
    ;; robot location
    (robot_at_loc cargo warehouse_loc)
    ;; robot unloaded
    (robot_unloaded cargo)
    ; workstation location
    (ws_at_loc workstation1 location1)
    (ws_at_loc workstation2 location1)
    (ws_at_loc workstation3 location2)
    ;; supplies location
    (supply_at_loc valve1 warehouse_loc)
    (supply_at_loc valve2 warehouse_loc)
    (supply_at_loc bolt1 warehouse_loc)
    (supply_at_loc bolt2 warehouse_loc)
    (supply_at_loc tool1 warehouse_loc)
    (supply_at_loc tool2 warehouse_loc)
    ;; supplies availabity
    (supply_available valve1)
    (supply_available valve2)
    (supply_available bolt1)
    (supply_available bolt2)
    (supply_available tool1)
    (supply_available tool2)
  )

  (:goal (and
    (robot_at_loc cargo warehouse_loc)
    (has_valve workstation1)
    (has_bolt workstation1)
    (has_tool workstation1)
    (has_valve workstation2)
    (has_bolt workstation3)
    (has_tool workstation3)
  ))
)