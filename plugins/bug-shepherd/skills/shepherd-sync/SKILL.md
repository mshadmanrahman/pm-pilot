---
name: shepherd-sync
description: Sync triage results back into Jira, Linear, or GitHub Issues using the matching tracker adapter. Use after a triage run to update the tracker.
---

# /shepherd-sync — Backlog Synchronization

Pull all open bugs from your tracker into a local backlog file for offline triage.

## Workflow

### 1. Load Configuration

Read `.claude/triage.config.yaml` to get tracker type, project key, and team settings.

If config file is missing:
```
"Config not found. Run the Bug Shepherd installer or create .claude/triage.config.yaml manually."
"See: https://github.com/YOUR_USERNAME/bug-shepherd#configuration"
```

### 2. Detect Tracker and Load Adapter

Based on `project.tracker` in config, load the matching adapter bundled with this skill in `references/`:
- `jira`: Read `references/jira.md` for Jira-specific query patterns
- `linear`: Read `references/linear.md` for Linear-specific patterns
- `github-issues`: Read `references/github-issues.md` for GitHub Issues patterns

### 3. Pull Open Bugs

Execute the tracker-specific query to fetch ALL open bugs. Handle pagination.

**For Jira** (via Atlassian MCP):
- Use JQL: `project = {tracker_project} AND issuetype = Bug AND status NOT IN (Done, Cancelled) ORDER BY created ASC`
- Paginate: fetch up to 100 per page, continue with `created > {last_date}` until no more results

**For Linear** (via Linear MCP):
- Query: open issues with label "bug" in the configured team
- Paginate using cursor

**For GitHub Issues** (via gh CLI):
- Query: `gh issue list --repo {repo} --label bug --state open --limit 500 --json number,title,state,labels,createdAt,assignees,body`

### 4. Detect Current Sprint (if applicable)

For Jira: Query `sprint in openSprints()` to find the active sprint name and ID.
For Linear: Get current cycle.
For GitHub: Skip (no sprint concept).

Store sprint info for later use by `/shepherd-triage`.

### 5. Write Local Backlog

Write results to `.claude/backlog-live.md`:

```markdown
# Bug Backlog — {project.name}
> Last synced: {ISO 8601 UTC timestamp}
> Sprint: {sprint_name} (ID: {sprint_id})
> Total open bugs: {count}

| Key | Status | Priority | Created | Assignee | Summary | Triaged |
|-----|--------|----------|---------|----------|---------|---------|
| {key} | {status} | {priority} | {date} | {assignee} | {summary} | {yes/no} |
```

Cross-reference with existing triage logs to mark bugs as "Triaged" if they've been checked before.

### 6. Report Delta

Compare with previous backlog (if exists):
- New bugs since last sync
- Bugs removed (closed/cancelled externally)
- Status changes

Output:
```
Backlog synced: {count} open bugs
  +{new} new since last sync
  -{removed} closed/cancelled externally
  ~{changed} status changes
Sprint: {sprint_name}
```

## Auto-Sync Rule

Other commands (`/shepherd-start`, `/shepherd-triage`) should auto-run this sync if `backlog-live.md` is older than 24 hours. Check the "Last synced" timestamp in the file header.

## Error Handling

- Tracker auth failure: "Tracker connection failed. Check your MCP configuration for {tracker}."
- Empty results: "No open bugs found in {tracker_project}. Either the backlog is clear or the project key is wrong."
- Pagination timeout: Report partial results with warning.
