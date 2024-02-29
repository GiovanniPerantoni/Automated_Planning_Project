(define (problem problem4_2)
  (:domain logistic_planning_4)

  (:objects
    robot1 robot2 robot3 - robot
    warehouse_loc location1 location2 - location
    workstation1 workstation2 workstation3 - workstation
    box1 box2 box3 - box
    valve1 valve2 - valve
    bolt1 bolt2 - bolt
    tool1 tool2 - tool
    carrier1 carrier2 carrier3 - carrier
    s1 s2 s3 s4 s5 s6 - space
  )

  (:init
    ;; graph edges
    (connected location1 location2)
    (connected location2 location1)
    (connected warehouse_loc location1)
    (connected location1 warehouse_loc)
    (connected warehouse_loc location2)
    (connected location2 warehouse_loc)
    ;; workstations location
    (ws_at_loc workstation1 location1)
    (ws_at_loc workstation2 location1)
    (ws_at_loc workstation3 location2)
    ;; robot location
    (robot_at_loc robot1 warehouse_loc)
    (robot_at_loc robot2 warehouse_loc)
    (robot_at_loc robot3 warehouse_loc)
    ;; robot occupation
    (robot_is_not_acting robot1)
    (robot_is_not_acting robot2)
    (robot_is_not_acting robot3)
    ;; carrier owner
    (robot_has_carrier robot1 carrier1)
    (robot_has_carrier robot2 carrier2)
    (robot_has_carrier robot3 carrier3)
    ;; carrier space
    (free carrier1 s1)
    (free carrier1 s2)
    (free carrier3 s5)
    (free carrier3 s6)
    (free carrier2 s3)
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
      ;; UNSOLVED

      ; (supply_in_box valve1 box1)
      ; (supply_in_box valve1 box2)

      ; (supply_at_loc valve1 location1)
      ; (supply_at_loc valve2 location2)

      (box_at_loc box1 carrier1)
      (box_at_loc box1 carrier2)
      (box_at_loc box1 carrier3)

      ;; SOLVED

    )
  )

  (:metric minimize
    (total-time)
  )
)