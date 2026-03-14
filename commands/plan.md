# /plan

Create an implementation plan before coding.

## Usage
```
/plan {feature or task description}
```

## Behavior
1. Invoke the **planner** agent from `agents/planner.md`
2. Restate requirements, identify risks, create phased plan
3. Present plan and WAIT for user approval
4. Do not write code until plan is confirmed
