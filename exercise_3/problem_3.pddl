(define 
  (problem problem3_3)
  (:domain logistic_planning_3)

  (:objects
    robot1 robot2 - robot
    warehouse_loc location1 location2 location3 location4 location5 - location
    workstation1 workstation2 workstation3 workstation4 workstation5 workstation6 - workstation
    box1 box2 box3 - box
    valve1 valve2 valve3 valve4 valve5 valve6 - valve
    bolt1 bolt2 bolt3 bolt4 - bolt
    tool1 tool2 tool3 tool4 - tool
    carrier1 carrier2 - carrier
    s1 s2 s3 s4 - space
  )

  (:htn
    :parameters ()
    :subtasks (and
      (task0 (deliver_valve workstation1))
      (task1 (deliver_valve workstation2))
      (task2 (deliver_bolt workstation3))
      (task3 (deliver_tool workstation1))
    )
    :ordering (and
      (task0 < task1)
      (task1 < task2)
      (task2 < task3)
    )
  )

  (:init
    ;; graph edges
    (connected warehouse_loc location1)
    (connected warehouse_loc location2)
    (connected warehouse_loc location5)
    (connected location1 warehouse_loc)
    (connected location1 location2)
    (connected location2 warehouse_loc)
    (connected location2 location1)
    (connected location2 location3)
    (connected location3 location2)
    (connected location3 location4)
    (connected location4 location3)
    (connected location4 location4)
    (connected location5 warehouse_loc)
    (connected location5 location4)
    ;; workstations location
    (ws_at_loc workstation1 location1)
    (ws_at_loc workstation2 location1)
    (ws_at_loc workstation3 location2)
    (ws_at_loc workstation4 location3)
    (ws_at_loc workstation5 location4)
    (ws_at_loc workstation6 location5)
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
    (supply_at_loc valve4 warehouse_loc)
    (supply_at_loc valve5 warehouse_loc)
    (supply_at_loc valve6 warehouse_loc)
    (supply_at_loc bolt1 warehouse_loc)
    (supply_at_loc bolt2 warehouse_loc)
    (supply_at_loc bolt3 warehouse_loc)
    (supply_at_loc bolt4 warehouse_loc)
    (supply_at_loc tool1 warehouse_loc)
    (supply_at_loc tool2 warehouse_loc)
    (supply_at_loc tool3 warehouse_loc)
    (supply_at_loc tool4 warehouse_loc)
    ;; supplies availabity
    (supply_available valve1)
    (supply_available valve2)
    (supply_available valve3)
    (supply_available valve4)
    (supply_available valve5)
    (supply_available valve6)
    (supply_available bolt1)
    (supply_available bolt2)
    (supply_available bolt3)
    (supply_available bolt4)
    (supply_available tool1)
    (supply_available tool2)
    (supply_available tool3)
    (supply_available tool4)
  )
)