# Error Handling

## Classification
Use typed/custom error classes with error codes — not generic `Error('something went wrong')`.

## Visibility
- Handle every rejected promise — no silent swallowing
- Log or rethrow with contextual information about what failed
- Use correlation/request IDs in logs where possible

## API responses
Consistent structure:
```ts
{ error: { code: string, message: string } }
```
Status codes: 400 validation, 401 auth, 403 authorization, 404 missing, 500 unexpected.
Never include stack traces, internal paths, or raw DB errors in responses.

## Resilience
- Transient failures (network timeouts): retry with exponential backoff
- Validation and auth errors: fail immediately, no retry
