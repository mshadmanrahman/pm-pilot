---
name: tdd-workflow
description: Test-driven development enforcement with RED-GREEN-IMPROVE cycle
origin: pm-pilot
version: 1.0.0
triggers:
  - writing new features
  - fixing bugs
  - refactoring code
  - tdd
---

# TDD Workflow

Enforce test-driven development. No implementation without a failing test first.

## When to Use

- Any new feature implementation
- Any bug fix (write test that reproduces the bug first)
- Any refactoring (ensure tests exist before changing code)

## Procedure

### Phase 1: RED (Write Failing Test)

1. Identify the behavior to implement
2. Write the test that describes expected behavior
3. Run the test: it MUST fail
4. If it passes, the test is wrong or the feature already exists

```bash
# Framework detection
jest --testPathPattern={test_file} 2>/dev/null || \
pytest {test_file} 2>/dev/null || \
go test -run {test_name} ./... 2>/dev/null || \
mvn test -Dtest={test_class} 2>/dev/null
```

### Phase 2: GREEN (Minimal Implementation)

1. Write the minimum code to make the test pass
2. No extra features, no premature optimization
3. Run the test: it MUST pass
4. If it fails, fix the implementation (not the test)

### Phase 3: IMPROVE (Refactor)

1. Clean up implementation while keeping tests green
2. Extract functions, rename variables, remove duplication
3. Run full test suite after each change
4. Verify no regressions

### Phase 4: COVERAGE

1. Check coverage meets 80% minimum:
   ```bash
   jest --coverage 2>/dev/null || \
   pytest --cov={module} 2>/dev/null || \
   go test -coverprofile=cover.out ./... 2>/dev/null
   ```
2. If below 80%, identify uncovered paths and add tests
3. Focus on branch coverage, not just line coverage

## Output Format

```
TDD Cycle: {feature name}
RED:   Test written - {test file}:{test name} - FAILS as expected
GREEN: Implementation - {impl file} - Test PASSES
IMPROVE: Refactored {what changed}
Coverage: {percent}% ({above/below} 80% target)
```

## Rules

- NEVER write implementation before a failing test
- NEVER modify tests to make them pass (fix the implementation)
- Each cycle should be small: one behavior per cycle
- Run the full suite after GREEN phase to catch regressions
- If coverage is below 80%, do not mark task as complete
- Log test failures clearly with file, line, and error message
