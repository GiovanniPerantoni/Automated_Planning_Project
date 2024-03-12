## Running Exercise 5
1. Build ros workspace
```
colcon build --symlink-install
source install/setup.bash
```
2. Run domain and executors
```
ros2 launch planner planner_launch.launch.py
```
3. Run plansys terminal in another shell
```
ros2 run plansys2_terminal plansys2_terminal
```
1. Source problem file (one between `problem_1`, `problem_2`)
```
source src/planner/pddl/problem_1
```
Type `get plan` and then `run` to execute the plan.