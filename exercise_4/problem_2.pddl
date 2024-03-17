(define (problem problem4_2)
  (:domain logistic_planning_4)

  (:objects
    robot1 robot2 - robot
    warehouse_loc location1 location2 location3 - location
    workstation1 workstation2 workstation3 workstation4 - workstation
    box1 box2 box3 - box
    valve1 valve2 valve3 - valve
    bolt1 bolt2 bolt3 - bolt
    tool1 tool2 tool3 - tool
    carrier1 carrier2 - carrier
    s1 s2 s3 s4 - space
  )

  (:init
    ;; graph edges
    (connected warehouse_loc location1)
    (connected warehouse_loc location2)
    (connected warehouse_loc location3)
    (connected location1 warehouse_loc)
    (connected location1 location2)
    (connected location1 location3)
    (connected location2 warehouse_loc)
    (connected location2 location1)
    (connected location3 warehouse_loc)
    (connected location3 location1)
    ;; workstations location
    (ws_at_loc workstation1 location1)
    (ws_at_loc workstation2 location1)
    (ws_at_loc workstation3 location2)
    (ws_at_loc workstation4 location3)
    ;; box location
    (box_at_loc box1 warehouse_loc)
    (box_at_loc box2 warehouse_loc)
    (box_at_loc box3 warehouse_loc)
    ;; box empty
    (box_empty box1)
    (box_empty box2)
    (box_empty box3)
    ;; robot location
    (robot_at_loc robot1 warehouse_loc)
    (robot_at_loc robot2 warehouse_loc)
    ;; robot occupation
    (robot_is_not_acting robot1)
    ;(robot_is_not_acting robot2)
    ;; carrier owner
    (robot_has_carrier robot1 carrier1)
    (robot_has_carrier robot2 carrier2)
    ;; carrier space
    (free carrier1 s1)
    (free carrier1 s2)
    (free carrier1 s3)
    (free carrier2 s4)
    ;; supplies location
    (supply_at_loc valve1 warehouse_loc)
    (supply_at_loc valve2 warehouse_loc)
    (supply_at_loc valve3 warehouse_loc)
    (supply_at_loc bolt1 warehouse_loc)
    (supply_at_loc bolt2 warehouse_loc)
    (supply_at_loc bolt3 warehouse_loc)
    (supply_at_loc tool1 warehouse_loc)
    (supply_at_loc tool2 warehouse_loc)
    (supply_at_loc tool3 warehouse_loc)
    ;; supplies availability
    (supply_available valve1)
    (supply_available valve2)
    (supply_available valve3)
    (supply_available bolt1)
    (supply_available bolt2)
    (supply_available bolt3)
    (supply_available tool1)
    (supply_available tool2)
    (supply_available tool3)
  )

  (:goal
    (and
      (robot_at_loc robot1 warehouse_loc)
      (robot_at_loc robot2 warehouse_loc)
      (has_valve workstation1)
      (has_valve workstation3)
      (has_valve workstation4)
      (has_bolt workstation2)
      (has_bolt workstation3)
      (has_bolt workstation4)
      (has_tool workstation2)
      (has_tool workstation3)
      (has_tool workstation4)
    )
  )

  (:metric minimize
    (total-time)
  )
)
