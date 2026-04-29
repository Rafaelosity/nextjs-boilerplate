#!/usr/bin/env bash
# PostToolUse hook — auto-formats files after edits using Prettier (if configured)

INPUT=$(cat)

if ! command -v jq &>/dev/null; then
  exit 0
fi

FILE_PATH=$(echo "$INPUT" | jq -r '.tool_input.file_path // .tool_input.path // ""' 2>/dev/null)

if [ -z "$FILE_PATH" ] || [ ! -f "$FILE_PATH" ]; then
  exit 0
fi

# Find project root by walking up to package.json
find_root() {
  local dir="$1"
  while [ "$dir" != "/" ]; do
    [ -f "$dir/package.json" ] && echo "$dir" && return
    dir=$(dirname "$dir")
  done
}

PROJECT_ROOT=$(find_root "$(dirname "$FILE_PATH")")

if [ -z "$PROJECT_ROOT" ]; then
  exit 0
fi

# Only format if prettier is configured in the project
PRETTIER_CONFIG=$(find "$PROJECT_ROOT" -maxdepth 1 -name "prettier.config.*" -o -name ".prettierrc*" 2>/dev/null | head -1)

if [ -z "$PRETTIER_CONFIG" ]; then
  exit 0
fi

# Check if prettier binary exists
PRETTIER_BIN="$PROJECT_ROOT/node_modules/.bin/prettier"
if [ ! -x "$PRETTIER_BIN" ]; then
  exit 0
fi

# Only format supported file types
case "$FILE_PATH" in
  *.ts|*.tsx|*.js|*.jsx|*.mjs|*.cjs|*.scss|*.css|*.json|*.md)
    "$PRETTIER_BIN" --write "$FILE_PATH" --log-level silent 2>/dev/null
    ;;
esac

exit 0
