#!/usr/bin/env python3
# file used to be able to visualize the generated planner with the vscode PDDL extension
def main():
    with open("sas_plan_capitalized.plan", "w+") as output:
        with open("sas_plan", "r") as input:
            lines = input.readlines()
            # save output to a new file
            for line in lines[:-1]:
                output.write(line.upper())
            

if __name__ == "__main__":
    main()