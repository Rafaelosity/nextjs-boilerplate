# Code Quality

## Core philosophy
Functions do one thing. Three similar lines > a helper used once. Don't add features beyond what was asked.

## Naming
- Files: PascalCase for components (`UserCard.tsx`), kebab-case for utils (`format-date.ts`)
- Booleans: prefix with `is`, `has`, `should`, `can`
- Functions: verb-first (`getUser`, `validateEmail`, `formatDate`)
- Constants: `SCREAMING_SNAKE_CASE`
- Event handlers: `handle*` internally, `on*` as props
- Avoid abbreviations — only universally known ones (`id`, `url`) are acceptable

## Comments
Explain WHY, never WHAT. Rename instead of commenting. No dead code, no commented-out blocks.

## Imports order
1. Builtins (`node:fs`)
2. External packages (`next`, `react`)
3. Internal aliases (`@/lib/`, `@/types/`)
4. Relative imports (`./Component`)
5. Types (`import type`)

## Organization
- Public functions before private helpers
- Code reads top-to-bottom like a story
- Error handling at system boundaries only — no repeated catch-and-rethrow
- Composition over inheritance
