# GitHub Issues Adapter

Patterns for interacting with GitHub Issues via the `gh` CLI.

## Prerequisites

- GitHub CLI (`gh`) installed and authenticated
- Access to the repository specified in `triage.config.yaml`

## Queries

### Fetch All Open Bugs

```bash
gh issue list \
  --repo {tracker_project} \
  --label bug \
  --state open \
  --limit 500 \
  --json number,title,state,labels,createdAt,assignees,body,comments,url
```

Where `{tracker_project}` is the repo in `owner/repo` format.

If more than 500 issues, paginate:
```bash
gh api repos/{owner}/{repo}/issues \
  --method GET \
  -f state=open \
  -f labels=bug \
  -f per_page=100 \
  -f page={page_number}
```

### Detect Current Sprint/Milestone

GitHub doesn't have sprints. Use milestones as the closest equivalent:

```bash
gh api repos/{owner}/{repo}/milestones \
  --method GET \
  -f state=open \
  -f sort=due_on \
  -f direction=asc \
  --jq '.[0]'
```

The first open milestone (sorted by due date) is treated as the "current sprint."

### Get Full Bug Details

```bash
gh issue view {number} \
  --repo {tracker_project} \
  --json number,title,body,state,labels,assignees,comments,createdAt,updatedAt,milestone,url
```

### Priority Mapping

GitHub Issues don't have native priority. Bug Shepherd reads priority from labels:
- `priority: critical` or `P0` = Critical
- `priority: high` or `P1` = High
- `priority: medium` or `P2` = Medium
- `priority: low` or `P3` = Low
- No priority label = None

## Write Operations

### Add Comment

```bash
gh issue comment {number} \
  --repo {tracker_project} \
  --body "Bug Shepherd Triage ({date}): {triage_result}

{evidence_notes}"
```

### Close Issue

```bash
gh issue close {number} \
  --repo {tracker_project} \
  --reason "not planned" \
  --comment "Closed by Bug Shepherd triage: {reason}"
```

Use `--reason "not planned"` for bugs that can't be reproduced.
Use `--reason "completed"` for bugs that are fixed.

### Add Labels

```bash
gh issue edit {number} \
  --repo {tracker_project} \
  --add-label "triaged"
```

### Assign Issue

```bash
gh issue edit {number} \
  --repo {tracker_project} \
  --add-assignee {username}
```

### Add to Milestone

```bash
gh issue edit {number} \
  --repo {tracker_project} \
  --milestone "{milestone_name}"
```

## Repository Protection

**Before ANY write operation**, verify the remote:

```bash
remote_url=$(git remote get-url origin 2>/dev/null || echo "")
```

Compare against `tracker_project` to ensure you're operating on the right repository. This prevents accidentally modifying issues in a template or upstream repo.

## Error Handling

- **Auth failure:** "GitHub CLI not authenticated. Run: gh auth login"
- **Repo not found:** "Repository '{tracker_project}' not found. Use 'owner/repo' format."
- **Permission denied:** "You don't have write access to {tracker_project}. Check repository permissions."
- **Rate limit:** gh CLI handles rate limiting automatically. If exceeded: "GitHub API rate limit hit. Wait a few minutes and try again."

## GitHub-Specific Configuration

Add to `tracker_config` in `triage.config.yaml`:

```yaml
tracker_config:
  repo: "owner/repo"            # Full repository path
  bug_label: "bug"              # Label that identifies bugs
  triage_label: "triaged"       # Label to add after triage
  priority_labels:              # How priority is encoded in labels
    critical: "priority: critical"
    high: "priority: high"
    medium: "priority: medium"
    low: "priority: low"
  use_milestones: true          # Use milestones as sprint equivalent
```
