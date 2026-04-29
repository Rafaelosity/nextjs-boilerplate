#!/usr/bin/env bash
# PreToolUse hook — warns before writing content that looks like credentials

INPUT=$(cat)

if ! command -v jq &>/dev/null; then
  exit 0
fi

CONTENT=$(echo "$INPUT" | jq -r '.tool_input.content // .tool_input.new_string // ""' 2>/dev/null)

if [ -z "$CONTENT" ]; then
  exit 0
fi

FOUND=""

# AWS credentials
echo "$CONTENT" | grep -qE 'AKIA[0-9A-Z]{16}' && FOUND="AWS access key"
echo "$CONTENT" | grep -qE '"aws_secret_access_key"?\s*[:=]\s*"?[A-Za-z0-9/+=]{40}' && FOUND="AWS secret key"

# GitHub tokens
echo "$CONTENT" | grep -qE 'gh[pousr]_[A-Za-z0-9]{36}' && FOUND="GitHub token"

# OpenAI / Anthropic / Stripe style keys
echo "$CONTENT" | grep -qE '"?sk-[A-Za-z0-9]{20,}"?' && FOUND="API secret key (sk-)"

# Slack tokens
echo "$CONTENT" | grep -qE 'xox[baprs]-[0-9A-Za-z-]+' && FOUND="Slack token"

# Private key blocks
echo "$CONTENT" | grep -qE '-----BEGIN (RSA |EC |DSA |OPENSSH )?PRIVATE KEY-----' && FOUND="private key block"

# DB connection strings with credentials embedded
echo "$CONTENT" | grep -qE '(postgres|mysql|mongodb|redis):\/\/[^:]+:[^@]+@' && FOUND="DB connection string with credentials"

# Hardcoded password assignments
echo "$CONTENT" | grep -qiE '(password|passwd|secret|api_key)\s*[:=]\s*"[^"]{8,}"' && FOUND="hardcoded credential assignment"

if [ -n "$FOUND" ]; then
  echo "{\"decision\": \"ask\", \"reason\": \"Possible $FOUND detected in content — confirm this is intentional and not an accidental credential exposure\"}"
  exit 2
fi

exit 0
