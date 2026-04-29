#!/usr/bin/env bash
# PreToolUse hook — blocks dangerous shell commands before execution

INPUT=$(cat)

if ! command -v jq &>/dev/null; then
  exit 0
fi

COMMAND=$(echo "$INPUT" | jq -r '.tool_input.command // ""' 2>/dev/null)

if [ -z "$COMMAND" ]; then
  exit 0
fi

emit_deny() {
  echo "{\"decision\": \"deny\", \"reason\": \"$1\"}"
  exit 2
}

# Force push (allow --force-with-lease)
if echo "$COMMAND" | grep -qE 'git push.*--force(?!-with-lease)' || echo "$COMMAND" | grep -qE 'git push.*-f\b'; then
  emit_deny "Force push is blocked. Use --force-with-lease if you must override."
fi

# Push to protected branches
if echo "$COMMAND" | grep -qE 'git push (origin )?(main|master)$'; then
  emit_deny "Direct push to main/master is blocked. Open a PR instead."
fi

# Destructive rm
if echo "$COMMAND" | grep -qE 'rm\s+-[a-zA-Z]*r[a-zA-Z]*f?\s+(\/|~|\$HOME|\$\{HOME\}|\/usr|\/etc|\/var|\/sys|\/proc)'; then
  emit_deny "Destructive rm targeting system or home directory is blocked."
fi

# Drop database
if echo "$COMMAND" | grep -qiE 'DROP\s+(TABLE|DATABASE|SCHEMA)\s'; then
  emit_deny "DROP TABLE/DATABASE/SCHEMA is blocked. Run manually if intentional."
fi

# DELETE without WHERE
if echo "$COMMAND" | grep -qiE 'DELETE\s+FROM\s+\w+\s*;'; then
  emit_deny "DELETE without WHERE clause is blocked."
fi

# Pipe curl/wget to shell
if echo "$COMMAND" | grep -qE '(curl|wget).+\|\s*(ba)?sh'; then
  emit_deny "Piping remote content to shell is blocked."
fi

# git reset --hard / git clean -f
if echo "$COMMAND" | grep -qE 'git (reset --hard|clean -f)'; then
  emit_deny "git reset --hard and git clean -f are blocked. Stash or commit changes first."
fi

# npm/yarn publish (allow --dry-run)
if echo "$COMMAND" | grep -qE '(npm|yarn|pnpm) publish' && ! echo "$COMMAND" | grep -q '\-\-dry-run'; then
  emit_deny "Publishing is blocked here. Run manually with --dry-run to preview first."
fi

exit 0
