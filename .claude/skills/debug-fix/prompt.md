Find and fix the bug described by the user or visible in recent errors.

1. Read error output or failing test carefully
2. Identify the root cause — not just the symptom
3. Trace the call path: where does the bad value originate?
4. Propose the minimal fix that addresses the root cause
5. Check if the same pattern exists elsewhere in the codebase
6. Run `npm run typecheck` after fixing
7. Confirm the fix with a brief explanation of what was wrong and why the fix works
