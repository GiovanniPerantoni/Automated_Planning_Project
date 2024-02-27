(define (problem problem2_0)
  (:domain logistic_planning_2)

  (:objects
    robot1 - robot
    warehouse_loc location1 location2 - location
    workstation1 workstation2 workstation3 - workstation
    warehouse1 - warehouse
    box1 box2 box3 - box
    valve1 valve2 - valve
    bolt1 bolt2 - bolt
    tool1 tool2 - tool
    carrier1 - carrier
    space1 space2 space3 - space
  )

  (:init
    ; graph edges
    (connected location1 location2)
    (connected location2 location1)
    (connected warehouse_loc location1)
    (connected location1 warehouse_loc)
    (connected warehouse_loc location2)
    (connected location2 warehouse_loc)
    ; box location
    (box_at_loc box1 warehouse_loc)
    (box_at_loc box2 warehouse_loc)
    (box_at_loc box3 warehouse_loc)
    ; box empty
    (box_empty box1)
    (box_empty box2)
    (box_empty box3)
    ; robot location
    (robot_at_loc robot1 warehouse_loc)
    ; carrier owner
    (robot_has_carrier robot1 carrier1)
    ; carrier spaces
    (free carrier1 space1)
    (free carrier1 space2)
    (free carrier1 space3)
    ; workstations location
    (ws_at_loc workstation1 location1)
    (ws_at_loc workstation2 location1)
    (ws_at_loc workstation3 location2)
    ; supplies location
    (supply_at_loc valve1 warehouse_loc)
    (supply_at_loc valve2 warehouse_loc)
    (supply_at_loc bolt1 warehouse_loc)
    (supply_at_loc bolt2 warehouse_loc)
    (supply_at_loc tool1 warehouse_loc)
    (supply_at_loc tool2 warehouse_loc)
    ; supply type
    (is_valve valve1)
    (is_valve valve2)
    (is_bolt bolt1)
    (is_bolt bolt2)
    (is_tool tool1)
    (is_tool tool2)
    ; supplies availability
    (supply_available valve1)
    (supply_available valve2)
    (supply_available bolt1)
    (supply_available bolt2)
    (supply_available tool1)
    (supply_available tool2)
  )

  (:goal
    (and
      (box_at_loc box1 location1)
      (box_at_loc box2 location2)
    )
  )
)