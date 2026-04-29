# Project Instructions

> Customize this file for your project. Delete sections that don't apply.
> Run `/setupdotclaude` to auto-customize based on the codebase, or edit manually.
> Delete all `> REPLACE:` blocks when done.

## Commands

```bash
npm run dev          # start dev server (localhost:3000)
npm run build        # optimize images + build
npm run lint         # check style
npm run lint:fix     # auto-fix style
npm run typecheck    # type checking
npm test             # run full suite
```

## Stack

- **Framework**: Next.js 15 (App Router)
- **Language**: TypeScript
- **Styles**: SCSS → compiled to CSS via sass package
- **Image optimization**: sharp (build-time) + next/image (runtime)

## Architecture

- `src/app/` — App Router pages and layouts
- `src/components/` — shared components (built per-project, no UI library)
- `src/hooks/` — custom React hooks
- `src/lib/` — utility functions and helpers
- `src/types/` — shared TypeScript types
- `src/styles/` — SCSS architecture (tokens → base → layouts → shared → pages)

## Styles structure

```
src/styles/
  utils/    # _tokens.scss (CSS vars), _mixins.scss (breakpoints, helpers)
  base/     # _reset.scss, _typography.scss
  layouts/  # _grid.scss, layout primitives
  pages/    # per-page SCSS files, imported in the page component
  shared/   # reusable partials (buttons, forms, etc.)
  index.scss
```

Page-specific styles are imported directly in the component:
```ts
import '@/styles/pages/_home.scss'
```

## Key Decisions

> REPLACE: Record WHY non-obvious choices were made.

## Domain Knowledge

> REPLACE: Terms, abbreviations, or concepts specific to this project.

## Workflow

- Run typecheck after a series of code changes
- Prefer fixing root cause over workarounds
- Use plan mode (Shift+Tab) before large changes

## Don'ts

- Never hardcode values — use tokens from `src/styles/utils/_tokens.scss`
- Don't modify generated files
- Don't import styles globally unless they're truly global (base/shared)
