#!/usr/bin/env bash
# PreToolUse hook — blocks writes to sensitive or generated files

INPUT=$(cat)
FILE_PATH=$(echo "$INPUT" | jq -r '.tool_input.file_path // .tool_input.path // ""' 2>/dev/null)

if [ -z "$FILE_PATH" ] || ! command -v jq &>/dev/null; then
  exit 0
fi

emit() {
  local decision="$1"
  local reason="$2"
  echo "{\"decision\": \"$decision\", \"reason\": \"$reason\"}"
  exit 2
}

BASENAME=$(basename "$FILE_PATH")
LOWER=$(echo "$FILE_PATH" | tr '[:upper:]' '[:lower:]')

# Block credential and key files
case "$LOWER" in
  *.pem|*.key|*.crt|*.p12|*.pfx) emit "deny" "Refusing to write to certificate/key file: $FILE_PATH" ;;
  *id_rsa*|*id_ed25519*|*id_dsa*) emit "deny" "Refusing to write to SSH key file: $FILE_PATH" ;;
  *credentials.json|*.npmrc|*.pypirc) emit "deny" "Refusing to write to credentials file: $FILE_PATH" ;;
  *.gen.ts|*.generated.*|*.min.js|*.min.css) emit "deny" "Refusing to write to generated/minified file: $FILE_PATH" ;;
esac

# Block .git internals
if echo "$FILE_PATH" | grep -q '\.git/'; then
  emit "deny" "Refusing to write inside .git/: $FILE_PATH"
fi

# Block secrets directory
if echo "$FILE_PATH" | grep -qE '(^|/)secrets/'; then
  emit "deny" "Refusing to write to secrets/: $FILE_PATH"
fi

# Block lock files
case "$BASENAME" in
  package-lock.json|yarn.lock|pnpm-lock.yaml)
    emit "deny" "Lock files are managed by the package manager — don't edit directly"
    ;;
esac

# Ask for confirmation before touching .claude/settings.json
if echo "$FILE_PATH" | grep -q '\.claude/settings\.json'; then
  echo "{\"decision\": \"ask\", \"reason\": \"Editing .claude/settings.json changes permissions and hooks — confirm this is intentional\"}"
  exit 2
fi

exit 0
