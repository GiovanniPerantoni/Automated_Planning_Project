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

## Running Exercise 4
This requires the ros workspace of ex. 5 to be compiled.
Scenarios are tested using `POPF` and `TFD` with `plansys2` planners

- Run `popf` 
```
cd <path_to_Automated_planning>/exercise_4/
```
```
ros2 run popf popf domain4.pddl problem_{1-2-3}.pddl
```
- Run `tfd` manually (we followed [this](https://github.com/sea-bass/TemporalFastDownward/tree/master/example) README example)

```
${TFD_HOME}/translate/translate.py ./domain4.pddl ./problem_1.pddl
${TFD_HOME}/preprocess/preprocess < output.sas
${TFD_HOME}/search/search y Y a T 10 t 5 e r O 1 C 1 p ./pddlplan < ./output
cat pddlplan.1
``` 

## Running Exercise 5
```
cd <path_to_Automated_planning>/exercise_5
```
1. Compile `tfd`
```
./src/TemporalFastDownward/build
```
2. Build ros workspace
```
colcon build --symlink-install
source install/setup.bash
```
1. Run domain and executors
```
ros2 launch planner planner_launch.launch.py
```
1. Run plansys terminal in another shell
```
ros2 run plansys2_terminal plansys2_terminal
```
1. Source problem file (one between `problem_1`, `problem_2`)
```
source <path_to_Automated_planning>/exercise_5/src/planner/pddl/problem_1
```
Type `get plan` and then `run` to execute the plan.
