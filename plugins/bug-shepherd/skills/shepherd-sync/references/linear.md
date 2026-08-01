# Linear Adapter

Patterns for interacting with Linear via the Linear MCP server.

## Prerequisites

- Linear MCP server configured in Claude Code
- Access to the team specified in `triage.config.yaml`

## Queries

### Fetch All Open Bugs

Query issues with label "bug" in the configured team, excluding completed/cancelled states.

Use Linear MCP `list_issues` or equivalent with filters:
- Team: `{tracker_project}` (team slug)
- Label: "bug"
- State: not in ["Done", "Cancelled", "Duplicate"]
- Order: created ascending

### Detect Current Cycle

Query the active cycle for the configured team. Linear calls sprints "cycles."

### Get Full Bug Details

Fetch issue by identifier:
- Title, description, priority (0-4 scale), state
- Assignee, creator
- Comments
- Related issues
- Labels
- Cycle history

### Priority Mapping

Linear uses numeric priorities:
- 0: No priority
- 1: Urgent
- 2: High
- 3: Medium
- 4: Low

Map to Bug Shepherd's display: Urgent / High / Medium / Low / None

## Write Operations

### Add Comment

```
Issue ID: {issue_id}
Body: "Bug Shepherd Triage ({date}): {triage_result}\n\n{evidence_notes}"
```

### Update State

Transition the issue to "Cancelled" or "Done" state.

**Note:** Linear state names vary by team. Query available states first.

### Update Labels

Add "triaged" label. Create the label first if it doesn't exist.

### Assign Issue

Set the assignee to the configured team member.

## Error Handling

- **Auth failure:** "Linear connection failed. Verify your Linear MCP server is configured."
- **Team not found:** "Team '{tracker_project}' not found. Use the team slug (URL path), not display name."
- **State transition failure:** "Cannot move {identifier} to Cancelled. Check available states for this team."

## Linear-Specific Configuration

Add to `tracker_config` in `triage.config.yaml`:

```yaml
tracker_config:
  team_id: ""              # Linear team ID (UUID)
  cancelled_state: "Cancelled"  # State name for cancelled issues
  triage_label: "triaged"       # Label to add after triage
  bug_label: "bug"              # Label that identifies bugs
```
