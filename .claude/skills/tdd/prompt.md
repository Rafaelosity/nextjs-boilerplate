Work in red-green-refactor cycles for the described feature or fix.

1. **Red**: Write a failing test that describes the expected behavior
2. **Green**: Write the minimal code to make it pass — no more
3. **Refactor**: Clean up without changing behavior; re-run tests to confirm
4. Repeat until the feature is complete

Rules:
- One cycle at a time — don't write multiple failing tests ahead
- Test behavior, not implementation
- Each test name should read as a sentence describing what the code does
