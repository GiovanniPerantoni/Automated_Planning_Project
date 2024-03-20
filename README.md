# Automated_Planning_Project
Project done for the UniTn Automated Planning course held by Professor Marco Roveri

## Running Exercise 1 and 2 problems
Inside docker:
```
planutils activate
```
```
downward --alias lama-first domain{1-2}.pddl problem_{1-2-3}.pddl
```
or
```
ff domain_file problem_file
```

## Running Exercise 3 problems
```
java -jar ./PANDA.jar -parser hddl domain3.hddl problem_{1-2-3}_{4t-5t}.pddl
```

## Running Exercise 4
Inside docker
```
planutils activate
```
```
tfd domain4.pddl problem_{1-2-3}.pddl
```
## Running Exercise 5
1. Install dependency for plansys2
```
sudo apt-get install ros-humble-behaviortree-cpp
```
2. Setup TFD path
```
export TFD_HOME=<path_to_Automated_planning>/exercise_5/src/TemporalFastDownward/downward
cd <path_to_Automated_planning>/exercise_5
```
3. Compile `tfd`
```
cd src/TemporalFastDownward && ./build && cd ../..
```
4. Build ros workspace
```
colcon build --symlink-install
source install/setup.bash
```
5. Run domain and executors
```
ros2 launch planner planner_launch.launch.py
```
6. Run plansys terminal in another shell
```
ros2 run plansys2_terminal plansys2_terminal
```
7. Source problem file
```
source <path_to_Automated_planning>/exercise_5/src/planner/pddl/problem_{0-1-2-3}
```
Type `run` to solve and execute the plan.
