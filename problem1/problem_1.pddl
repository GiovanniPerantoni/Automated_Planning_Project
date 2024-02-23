(define (problem ass1)
  (:domain industial_planning_1)

  (:objects
    r1 - robot
    lwh l1 l2 - location
    ws1 ws2 ws3 - workstation
    wh - warehouse
    b1 b2 b3 - box
    v1 v2 - valve
    bo1 bo2 - bolt
    t1 t2 - tool
  )
  
    (:init
      ; graph edges
      (connected l1 l2)
      (connected l2 l1)
      (connected lwh l1)
      (connected l1 lwh)
      (connected lwh l2)
      (connected l2 lwh)
      ; box location
      (bal b1 lwh)
      (bal b2 lwh)
      (bal b3 lwh)
      ; box empty
      (bempty b1)
      (bempty b2)
      (bempty b3)
      ; robot location
      (ral r1 lwh)
      ; workstations location
      (wal ws1 l1)
      (wal ws2 l1)
      (wal ws3 l2)
      ; supplies location
      (sal v1 lwh)
      (sal v2 lwh)
      (sal bo1 lwh)
      (sal bo2 lwh)
      (sal t1 lwh)
      (sal t2 lwh) 
    )
  
    (:goal
      (and
        (ral r1 lwh)
        (has_valve ws1)
        (has_bolt ws1)
        (has_tool ws1)
        (has_valve ws2)
        (has_bolt ws3)
        (has_tool ws3)
      )
    )
)