(define (problem problem2_1)
  (:domain logistic_planning_2)

  (:objects
    cargo drone - robot
    warehouse_loc location1 location2 - location
    workstation1 workstation2 workstation3 - workstation
    box1 box2 box3 - box
    valve1 valve2 - valve
    bolt1 bolt2 - bolt
    tool1 tool2 - tool
    carrier1 carrier2 carrier3 - carrier
    s1 s2 s3 s4 - space
  )

  (:init
    ;; graph edges
    (connected warehouse_loc location1)
    (connected warehouse_loc location2)
    (connected location1 warehouse_loc)
    (connected location1 location2)
    (connected location2 warehouse_loc)
    (connected location2 location1)
    ;; workstations location
    (ws_at_loc workstation1 location1)
    (ws_at_loc workstation2 location1)
    (ws_at_loc workstation3 location2)
    ;; robot location
    (robot_at_loc cargo warehouse_loc)
    (robot_at_loc drone warehouse_loc)
    ;; carrier owner
    (robot_has_carrier cargo carrier1)
    (robot_has_carrier drone carrier2)
    ;; robot occupation
    (robot_is_not_acting cargo)
    (robot_is_not_acting drone)
    ;; carrier space
    (free carrier1 s1)
    (free carrier1 s2)
    (free carrier1 s3)
    (free carrier2 s4)
    ;; box location
    (box_at_loc box1 warehouse_loc)
    (box_at_loc box2 warehouse_loc)
    (box_at_loc box3 warehouse_loc)
    ;; box empty
    (box_empty box1)
    (box_empty box2)
    (box_empty box3)
    ;; supplies location
    (supply_at_loc valve1 warehouse_loc)
    (supply_at_loc valve2 warehouse_loc)
    (supply_at_loc bolt1 warehouse_loc)
    (supply_at_loc bolt2 warehouse_loc)
    (supply_at_loc tool1 warehouse_loc)
    (supply_at_loc tool2 warehouse_loc)
    ;; supplies availability
    (supply_available valve1)
    (supply_available valve2)
    (supply_available bolt1)
    (supply_available bolt2)
    (supply_available tool1)
    (supply_available tool2)
  )

  (:goal
    (and
      (robot_at_loc cargo warehouse_loc)
      (robot_at_loc drone warehouse_loc)
      (has_valve workstation1)
      (has_bolt workstation1)
      (has_tool workstation1)
      (has_valve workstation2)
      (has_bolt workstation3)
      (has_tool workstation3)
    )
  )
)