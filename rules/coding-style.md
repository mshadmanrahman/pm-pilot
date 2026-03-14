# Coding Style

## Immutability (CRITICAL)
Create new objects, NEVER mutate existing ones.
```
WRONG:  modify(original, field, value)  // changes in-place
RIGHT:  update(original, field, value)  // returns new copy
```

## File Organization
- 200-400 lines typical, 800 max
- High cohesion, low coupling
- Organize by feature/domain, not by type
- Extract utilities from large modules

## Error Handling
- Handle errors explicitly at every level
- User-friendly messages in UI code
- Detailed context in server logs
- Never silently swallow errors

## Input Validation
- Validate all user input before processing
- Use schema-based validation where available
- Fail fast with clear messages
- Never trust external data

## Quality Checklist
- [ ] Readable, well-named code
- [ ] Functions under 50 lines
- [ ] Files under 800 lines
- [ ] No nesting deeper than 4 levels
- [ ] Proper error handling
- [ ] No hardcoded values (use constants/config)
- [ ] No mutation (immutable patterns)
