# /code-review

Review recent code changes for quality, security, and maintainability.

## Usage
```
/code-review {optional: specific files or PR}
```

## Behavior
1. Invoke the **code-reviewer** agent from `agents/code-reviewer.md`
2. Analyze all staged/recent changes
3. Report CRITICAL, HIGH, MEDIUM issues
4. Block commit on CRITICAL issues
