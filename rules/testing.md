# Testing

## Coverage: 80% minimum

## TDD Mandatory
1. Write test first (RED)
2. Run test, confirm FAIL
3. Write minimal implementation (GREEN)
4. Run test, confirm PASS
5. Refactor (IMPROVE)
6. Verify coverage (80%+)

## Test Types (all required)
- **Unit**: Individual functions, utilities, components
- **Integration**: API endpoints, database operations
- **E2E**: Critical user flows

## Rules
- Fix implementation, not tests (unless tests are wrong)
- Check test isolation on failures
- Verify mocks are correct
- No skipped tests in CI
