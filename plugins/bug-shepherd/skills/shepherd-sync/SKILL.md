---
name: shepherd-sync
description: Pull all open bugs from Jira, Linear, or GitHub Issues into a local backlog file. Read-only. Use before a triage run, or when the local backlog is stale.
---

# /shepherd-sync — Backlog Synchronization

Pull all open bugs from your tracker into a local backlog file for offline triage.

This command only reads. It never writes to the tracker. Tracker writes happen
in `/shepherd-triage`, behind the approval gate.

## Workflow

### 1. Load Configuration

Read `.claude/triage.config.yaml` to get tracker type, project key, and team settings.

**If the config file is missing, create it before doing anything else.** This is
the first-run path for every Bug Shepherd command, so do it here rather than
sending the user away:

1. Copy the template bundled with this plugin to `.claude/triage.config.yaml`.
   It lives at `templates/triage.config.yaml` in the bug-shepherd plugin
   directory, and it ships with cautious defaults for every setting.
2. Ask the user for the four values the template leaves blank under `project`:
   `name`, `live_url`, `tracker` (jira, linear or github-issues), and
   `tracker_project`. Ask for all four in one message.
3. Uncomment the `tracker_config` block matching their tracker and fill in what
   it needs.
4. Show them the finished file and say where it is, then continue.

Do not invent values, and do not proceed with a partial config. A wrong
`live_url` makes every reproduction verdict meaningless, and a wrong
`tracker_project` points the write path at the wrong board.

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
