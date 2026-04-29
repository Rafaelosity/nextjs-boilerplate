# Security

Applies to: API routes (`app/api/`), middleware, server actions, auth.

## Input
- Validate all user input at the system boundary — never trust request parameters
- Use parameterized queries, never string concatenation for DB/command operations
- Sanitize output to prevent XSS — use framework escaping

## Tokens & secrets
- Never log sensitive data: secrets, tokens, passwords, PII
- Short-lived auth tokens; refresh tokens server-side only
- Use constant-time comparison for secrets (avoid timing attacks)

## API routes
- Add CORS and CSP headers
- Rate-limit authentication endpoints
- Return generic errors to clients — never expose stack traces, internal paths, or raw DB errors
- 400 for validation, 401 for auth, 403 for authorization, 404 for missing, 500 for unexpected

## Files
- Never commit `.env`, `.env.local`, or any credentials file
- `.claude/hooks/scan-secrets.sh` will warn before writes that look like credentials
