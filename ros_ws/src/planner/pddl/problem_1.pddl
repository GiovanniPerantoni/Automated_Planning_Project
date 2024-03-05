(define (problem problem4_1)
  (:domain logistic_planning_4)

  (:objects
    robot1 robot2 - robot
    warehouse_loc location1 location2 - location
    )

  (:init
    ;; graph edges
    (connected location1 location2)
    ;; robot location
    (robot_at_loc robot1 warehouse_loc)
  )

  (:goal
    (and
      (robot_at_loc robot1 warehouse_loc)
    )
  )

  (:metric minimize
    (total-time)
  )
)