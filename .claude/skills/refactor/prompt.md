Safely refactor the specified code.

1. Confirm existing tests cover the code — if not, write characterization tests first
2. Make one change at a time; run tests after each
3. Preserve all existing behavior — this is not the time for new features
4. Common targets: extract function, rename for clarity, remove duplication, simplify conditionals
5. Run `npm run typecheck` and `npm run lint` at the end
6. Summarize what changed and why
