(define (problem problem1_2)
  (:domain logistic_planning_1)

  (:objects
    robot1 - robot
    warehouse_loc location1 location2 location3 - location
    workstation1 workstation2 workstation3 - workstation
    warehouse1 - warehouse
    box1 box2 box3 - box
    valve1 valve2 - valve
    bolt1 bolt2 - bolt
    tool1 tool2 - tool
  )

  (:init
    ; graph edges
    (connected warehouse_loc location1)
    (connected location1 warehouse_loc)
    (connected location1 location2)
    (connected location2 location1)
    (connected location1 location3)
    (connected location3 location1)
    ; box location
    (bal box1 warehouse_loc)
    (bal box2 warehouse_loc)
    (bal box3 warehouse_loc)
    ; box empty
    (bempty box1)
    (bempty box2)
    (bempty box3)
    ; robot location
    (ral robot1 warehouse_loc)
    ; workstation location
    (wal workstation1 location2)
    (wal workstation2 location2)
    (wal workstation3 location3)
    ; supplies location
    (sal valve1 warehouse_loc)
    (sal valve2 warehouse_loc)
    (sal bolt1 warehouse_loc)
    (sal bolt2 warehouse_loc)
    (sal tool1 warehouse_loc)
    (sal tool2 warehouse_loc)
    ; supply type
    (is_valve valve1)
    (is_valve valve2)
    (is_bolt bolt1)
    (is_bolt bolt2)
    (is_tool tool1)
    (is_tool tool2)
    ; supplies availabity
    (supply_available valve1)
    (supply_available valve2)
    (supply_available bolt1)
    (supply_available bolt2)
    (supply_available tool1)
    (supply_available tool2)
  )

  (:goal (and
    (ral robot1 warehouse_loc)  ;goal 1
    (has_valve workstation1)    ;goal 2
    (has_bolt workstation1)     ;goal 3
    (has_tool workstation1)     ;goal 4
    (has_valve workstation2)    ;goal 5
    (has_bolt workstation3)     ;goal 6
    (has_tool workstation3)     ;goal 7
  ))
)