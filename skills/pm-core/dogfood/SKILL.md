---
name: dogfood
description: |
  Systematic web app QA using Playwright browser automation. Tests across viewports, checks navigation flows, form submissions, error states, accessibility basics, and visual consistency. Produces a structured bug report. Triggers on: "dogfood", "QA", "find bugs", "test this app".
origin: pm-pilot
version: 1.0.0
---

# Dogfood

Systematically explore a web application to find bugs, UX issues, and quality problems. Uses browser automation to test across viewports and produce a structured bug report with reproduction steps and screenshots.

## When to Activate

- User says "dogfood", "QA this", "find bugs", "test this app"
- User provides a URL and asks for quality feedback
- User says "exploratory test", "bug hunt"

## Input

Required:
- **Target URL**: The web app to test

Optional:
- **Scope**: Focus area (e.g., "billing page", "onboarding flow"). Default: full app.
- **Authentication**: Credentials if login is required.
- **Viewports**: Default: desktop (1280x800), tablet (768x1024), mobile (375x812).

## Execution

### Step 1: Initialize

Create output directory for screenshots and report:
```bash
mkdir -p {output_dir}/screenshots {output_dir}/videos
```

Open the target URL in a browser session. Take an initial screenshot.

### Step 2: Authenticate (if needed)

If the app requires login, fill credentials and save auth state. For OTP or email codes, ask the user and wait.

### Step 3: Orient

Take an annotated screenshot of the landing page. Identify main navigation elements. Map out sections to visit.

### Step 4: Explore Systematically

Work through the app section by section:

1. **Navigation**: Visit each top-level section. Check all links work.
2. **Forms**: Fill and submit forms. Test empty submissions, invalid input, boundary values.
3. **Interactive elements**: Click buttons, open dropdowns/modals, toggle switches.
4. **Error states**: Trigger error conditions. Check error messages are helpful.
5. **Empty states**: Check what happens with no data.
6. **Responsive**: Resize to tablet and mobile viewports. Check layout.
7. **Console**: Check browser console for JS errors and failed network requests.
8. **Accessibility basics**: Check focus order, alt text on images, color contrast.

At each page, take a screenshot and check the console.

### Step 5: Document Issues

Document each issue as you find it. Do not batch for later.

**For interactive/behavioral issues**: Record a video, take step-by-step screenshots, write numbered repro steps.

**For static/visual issues** (typos, misalignment, broken layout): A single annotated screenshot is sufficient.

Each issue gets:
- Unique ID (ISSUE-001, ISSUE-002, ...)
- Severity: Critical / High / Medium / Low
- Category: Functional / Visual / UX / Performance / Accessibility / Console Error
- Reproduction steps
- Screenshot(s) or video reference
- Expected vs actual behavior

### Step 6: Wrap Up

Aim for 5-10 well-documented issues. Depth of evidence beats quantity.

Update summary counts. Close the browser session.

## Output Format

```markdown
# Dogfood Report: {App Name}
**URL:** {url} | **Date:** {date} | **Tester:** AI (pm-pilot)

## Summary
- Critical: {count}
- High: {count}
- Medium: {count}
- Low: {count}
- **Total:** {count}

## Viewports Tested
- Desktop (1280x800): Yes/No
- Tablet (768x1024): Yes/No
- Mobile (375x812): Yes/No

## Issues

### ISSUE-001: {Short title}
- **Severity:** {Critical/High/Medium/Low}
- **Category:** {Functional/Visual/UX/Performance/Accessibility}
- **Page:** {URL or page name}
- **Viewport:** {Desktop/Tablet/Mobile}

**Steps to Reproduce:**
1. {Step} [screenshot: issue-001-step-1.png]
2. {Step} [screenshot: issue-001-step-2.png]

**Expected:** {what should happen}
**Actual:** {what actually happens}
**Screenshot:** {path}
**Video:** {path or N/A}

---
(Repeat for each issue)

## Pages Tested
- {Page 1}: {status}
- {Page 2}: {status}

## Console Errors
- {Error message} on {page} ({count} occurrences)
```

## Rules

- **Repro is everything**: Every issue needs proof. Interactive bugs need step-by-step screenshots. Static bugs need one annotated screenshot.
- **Document as you go**: Write each issue immediately. Do not batch.
- **Test like a user**: Try realistic workflows. Enter realistic data.
- **Check the console**: Many issues are invisible in the UI but visible in JS errors.
- **No source code**: Test as a user, not a code auditor. All findings come from browser observation.
- **Be efficient**: Spend more time on core features, less on peripheral pages.
- **Never delete output**: Do not remove screenshots or report files mid-session.
