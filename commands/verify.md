# /verify

Run verification loop: build, test, lint.

## Usage
```
/verify {optional: specific check}
```

## Behavior
1. Run build and check for errors
2. Run test suite and report failures
3. Run linter if configured
4. If any step fails, attempt fix and re-verify (max 3 attempts)
5. Report final status: all green or remaining issues
