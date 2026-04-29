Prepare and ship the current changes.

1. Run `npm run typecheck` — fix any errors before continuing
2. Run `npm run lint` — fix any errors
3. Show a `git diff --staged` summary of what will be committed
4. Write a conventional commit message: `type(scope): description`
   - Types: feat, fix, refactor, style, docs, chore, test
5. `git add` only relevant files (never .env, credentials, lock files)
6. `git commit` with the message
7. `git push`
8. If a PR is needed, create it with `gh pr create` including a summary and test plan
