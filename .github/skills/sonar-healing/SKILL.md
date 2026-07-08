---
name: sonar-healing
description: SonarQube issue remediation workflow for fetching issues, fixing code, reviewing fixes, and previewing diffs with y/s/r user approval.
---

This skill describes a complete Sonar remediation workflow for the agent using these tools:
- `fetch_sonar_issues`
- `fetch_rule_description_internal`
- `run_coder_agent`
- `run_reviewer_agent`
- `preview_git_diff`
- `resolve_fix`

Goal:
Process Sonar issues one at a time, generate fixes, validate them, display a git diff, and require explicit user approval before applying changes.

How to use this skill:
1. Use `fetch_sonar_issues(project_key)` to retrieve unresolved Sonar issues.
2. Process issues sequentially, never in parallel.
3. For each issue:
   - Use `fetch_rule_description_internal(rule_key)` to get the rule description.
   - Call `run_coder_agent(file_path, start_line, end_line, rule_key, error_message)` to generate a fix.
   - Call `run_reviewer_agent(file_path, fixed_code, rule_key, start_line, end_line)` to review the fix.
   - If the reviewer response is not `APPROVED`, repeat the coder/reviewer cycle until approval is obtained. While calling `run_coder_agent`, you can provide feedback from the reviewer as well as the previous fixed code to improve the fix.
4. After the reviewer approves the fix, call `preview_git_diff(file_path, start_line, end_line, new_snippet)` to generate the diff and show it to the user.
5. Ask the user for a decision:
   - `y`: approve and stage the fix.
   - `s`: skip the issue and discard the change.
   - `r`: request refinement, collect feedback, then rerun `run_coder_agent` with the feedback.
6. If the user chooses `r`, repeat the fix/review/diff cycle until the user approves with `y` or skips with `s`.
7. Continue until every issue is processed.

Important rules:
- Do not apply or stage changes without explicit `y` approval.
- Do not process more than one issue at a time.
- Only call `preview_git_diff` after the reviewer approves the candidate fix.
- If the reviewer rejects a fix, improve it before asking the user again.

This file is the skill definition for the Sonar remediation workflow and should be placed at `.github/skills/sonar-healing/SKILL.md`.