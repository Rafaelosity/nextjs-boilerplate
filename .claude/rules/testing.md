# Testing

## Philosophy
Tests verify behavior, not implementation details.

## Efficiency
Run individual test files after changes — don't run the full suite for every edit.

## Reliability
Fix or remove flaky tests — retrying to pass masks underlying issues.

## Mocking
Use real implementations whenever possible. Only mock at external system boundaries: network calls, file I/O, time.

## Assertions
One assertion per test. If the test name includes "and", split it.

## Naming
Test names describe actual behavior:
- ✓ `should return empty array when input is empty`
- ✗ `test1`, `handles edge case`

## Structure
Arrange → Act → Assert. No conditionals or loops inside tests.

## Anti-patterns
- No hollow assertions (`expect(true).toBe(true)`)
- Don't verify mock calls without checking arguments
