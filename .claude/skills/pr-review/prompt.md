Review the current PR or specified diff.

1. Run `git diff main...HEAD` to see all changes
2. Spawn the `code-reviewer` agent with the diff
3. Spawn the `security-reviewer` agent if the diff touches API routes, auth, or data handling
4. Spawn the `performance-reviewer` agent if the diff touches data fetching or hot paths
5. Consolidate findings — remove duplicates, sort by severity
6. Present: Blockers first, then Major, then Minor, then "Worth a second look"
7. Clean diff? Say so in one sentence.
