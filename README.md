# Automated_Planning_Project
Project done for the UniTn Automated Planning course held by Professor Marco Roveri

## Running Exercise 1 and 2 problems
```
planutils activate
downward --alias lama-first domain_file problem_file
```
or
```
ff domain_file problem_file
```

## Running Exercise 3 problems
```
java -jar ./PANDA.jar -parser hddl domain_file problem_file
```

## Running Exercise 5
```
cd <path_to_Automated_planning>/exercise_5
```
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
source <path_to_Automated_planning>/exercise_5/src/planner/pddl/problem_1
```
Type `get plan` and then `run` to execute the plan.
