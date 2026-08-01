# Bug Shepherd Learning Log — Example Entries

> These are real (anonymized) lessons from a production triage operation.
> They show the kind of entries your learning log will accumulate over time.

## Entries

---

### PROJ-2431 | Button text overflow in translated locale | 2026-03-01

**Bug:** "Read more" button text overflows its container in Greek and German locales
**Root Cause:** Flex container with `shrink-0` prevented text wrapping. Missing `max-width` constraint.
**Iterations:** 2 (first attempt only added `whitespace-normal`, missed the width constraint)
**Category:** i18n

**Lesson:**
Text wrapping in flex containers requires three things: `whitespace-normal` to allow wrapping, a `max-width` boundary to trigger wrapping, and `min-height` to accommodate the extra line. Missing any one of these makes the fix incomplete. Always test with the longest translation, not just English.

**Pattern:**
This is the third time a long-text overflow was caused by a flex item missing a max-width constraint. Consider adding a linting rule or documentation for flex containers that display user-facing text.

**Process Note:**
We repeated a documented mistake from a previous session. The learning log had the answer, but it wasn't checked. Added a reminder to always search the log for similar bugs before investigating.

---

### PROJ-2605 | Links not clickable in footer | 2026-02-28

**Bug:** Terms of Service and Privacy Policy links in the footer can't be clicked
**Root Cause:** Links were inside a `<label>` element. The label intercepted click events before they reached the `<a>` tag.
**Iterations:** 1
**Category:** Functionality

**Lesson:**
Labels and links don't mix. When an `<a>` tag is inside a `<label>`, the label's click handler fires first and may prevent the link from navigating. This is especially tricky when the HTML is generated from a CMS with `dangerouslySetInnerHTML`, because React event handlers don't apply to the inner HTML.

**Pattern:**
CMS-generated HTML often contains unexpected element nesting. Always inspect the actual rendered HTML, not just the template.

---

### PROJ-2487 | Wrong search button label on legal pages | 2026-02-27

**Bug:** Search button says "Search Programs" on the Privacy Policy page instead of a generic label
**Root Cause:** The search component loads translations from a namespace determined by the page type. Legal pages weren't included in the switch statement, so they fell through to the default "programs" namespace.
**Iterations:** 1
**Category:** i18n

**Lesson:**
Shared layout components create hidden dependencies on page context. When a component's behavior changes based on the page it's on, every new page type must be explicitly handled. Silent fallbacks (using a default namespace) mask the problem until someone notices the wrong label.

**Pattern:**
Look for switch statements or conditional logic that maps page types to behavior. If there's a default case, check if it's truly appropriate for all cases it catches.

---

### BATCH-001 | Mass triage false cancellation | 2026-03-10

**Bug:** Two bugs were auto-cancelled that a developer was actively investigating
**Root Cause:** Playwright headless browser couldn't reproduce RTL scrolling bug and viewport-specific bug. System treated "not reproduced" as "fixed."
**Iterations:** N/A (process failure, not code)
**Category:** Infrastructure

**Lesson:**
"Agent can't reproduce" is NOT "bug doesn't exist." Headless browsers have fundamental limitations: RTL text rendering, scroll momentum, touch events, and viewport-specific behavior all work differently than in real browsers. The cost of a false cancellation (developer frustration, lost context, damaged trust) is much higher than the cost of keeping a bug open one more sprint.

**Pattern:**
Any bug involving physical interaction (scroll, touch, drag), layout edge cases (RTL, viewport breakpoints), or timing (animation, transitions) should NEVER be auto-cancelled. These categories have been added to the safety configuration.

**Process Note:**
This incident led to a complete overhaul of the triage safety rules. All non-reproduced bugs now go to human review unless they match explicit auto-cancel rules. This is the most important lesson in this log.

---

### PROJ-2625 | Pagination layout breaks on mobile | 2026-03-06

**Bug:** Pagination buttons wrap to multiple lines on mobile, overlapping other elements
**Root Cause:** Container had fixed gap but no flex-wrap handling for small screens
**Iterations:** 3 (attempted JS mobile detection, then media query, finally container-level CSS fix)
**Category:** UI/UX

**Lesson:**
Two hard rules emerged from this fix: (1) Never use JavaScript for responsive layout. It's a CSS problem. (2) Fix at the container level before the component level. The first two attempts were too clever; the final fix was two CSS properties on the parent container.

**Pattern:**
Mobile layout bugs are almost always solvable with CSS flex/grid properties on the parent container. Resist the urge to add JavaScript breakpoint detection or component-level responsive logic.

**Process Note:**
The team lead explicitly blocked the JS approach. This is now a project rule, not just a preference.
