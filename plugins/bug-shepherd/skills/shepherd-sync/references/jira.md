# Jira Adapter

Patterns for interacting with Jira via the Atlassian MCP server.

## Prerequisites

- Atlassian MCP server configured in Claude Code
- Access to the Jira project specified in `triage.config.yaml`

## Queries

### Fetch All Open Bugs

```
JQL: project = {tracker_project} AND issuetype = Bug AND status NOT IN (Done, Cancelled) ORDER BY priority ASC, created ASC
```

Note: Jira's `priority ASC` sorts Highest first (1=Highest, 5=Lowest). This ensures the local backlog is pre-sorted by priority for `/shepherd-triage`.

Paginate with max 100 results per page. Continue with:
```
project = {tracker_project} AND issuetype = Bug AND status NOT IN (Done, Cancelled) AND created > "{last_created_date}" ORDER BY priority ASC, created ASC
```

Use `searchJiraIssuesUsingJql` MCP tool.

### Detect Current Sprint

```
JQL: project = {tracker_project} AND sprint in openSprints()
```

Extract sprint name and ID from the first result's sprint field.

### Get Full Bug Details

Use `getJiraIssue` MCP tool with the issue key. Retrieves:
- Summary, description, priority, status
- Assignee, reporter
- Comments (chronological)
- Sprint history
- Linked issues
- Labels

### Get Available Transitions

Use `getTransitionsForJiraIssue` to find transition IDs for:
- "Cancelled" (typically ID 3, but varies by workflow)
- "In Progress", "Code Review", "Done"

**Always query transitions dynamically.** Never hardcode transition IDs.

## Write Operations

### Add Comment

Use `addCommentToJiraIssue` MCP tool:
```
Key: {issue_key}
Body: "Bug Shepherd Triage ({date}): {triage_result}\n\n{evidence_notes}"
```

### Transition Issue

Use `transitionJiraIssue` MCP tool:
```
Key: {issue_key}
Transition ID: {dynamically queried}
```

### Edit Issue (assign, sprint, labels)

Use `editJiraIssue` MCP tool:
```
Key: {issue_key}
Fields:
  assignee: { accountId: "{team.assignee_id}" }
  sprint: { id: {sprint_id} }  # Note: plain integer, not object with name
  labels: ["triaged", "bug-shepherd"]
```

**Important Jira quirk:** The sprint field accepts a plain integer ID, not an object.

### Look Up User Account ID

Use `lookupJiraAccountId` MCP tool to find the account ID for a user by email or display name. Store this in `triage.config.yaml` as `team.assignee_id`.

## Error Handling

- **Auth failure:** "Jira connection failed. Verify your Atlassian MCP server is configured: check Claude Code MCP settings."
- **Project not found:** "Project '{tracker_project}' not found. Check the project key in triage.config.yaml."
- **Rate limit:** Jira Cloud has generous limits. If hit, wait 5 seconds and retry once.
- **Transition not available:** "Cannot transition {key} to Cancelled. Current status may not allow this transition. Check Jira workflow."

## Jira-Specific Configuration

Add to `tracker_config` in `triage.config.yaml`:

```yaml
tracker_config:
  cloud_id: ""           # Your Jira Cloud ID (found in Atlassian admin)
  cancelled_label: "cancelled"  # Label to add when cancelling
  triage_label: "triaged"       # Label to add after triage
  bug_type_name: "Bug"          # Issue type name (case-sensitive)
```
