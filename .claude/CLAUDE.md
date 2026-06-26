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

- **Framework**: Next.js 16 (App Router)
- **Language**: TypeScript
- **Components**: Radix UI (headless, accessible primitives)
- **Styles**: CSS Modules (`.module.css`) + plain CSS for globals
- **Image optimization**: sharp (build-time) + next/image (runtime)

## Architecture

- `src/app/` — App Router pages and layouts
- `src/components/` — shared components, each with its own `.module.css`
- `src/hooks/` — custom React hooks
- `src/lib/` — utility functions and helpers
- `src/types/` — shared TypeScript types
- `src/styles/` — global styles (tokens → base → layouts → shared)

## Styles structure

```
src/styles/
  tokens.css          # :root { CSS custom properties } — all design tokens
  utils/
    helpers.css       # utility classes (visually-hidden, truncate, flex-center…)
    breakpoints.ts    # breakpoint constants for use in JS/TS
  base/
    reset.css
    typography.css
  layouts/
    grid.css          # .container, .grid, .flex
  shared/
    placeholder.css   # reusable partials (add buttons, forms, etc. here)
  pages/
    *.module.css      # per-page styles, imported in the page component
  index.css           # imports all global styles — imported once in layout.tsx
```

Component styles live next to the component:
```
src/components/Button/
  Button.tsx
  Button.module.css
  index.ts
```

Page-specific styles use CSS Modules:
```ts
import styles from '@/styles/pages/home.module.css'
```

## Components

- Use Radix UI primitives for interactive elements (Dialog, DropdownMenu, Select, Tooltip…)
- Wrap Radix components in your own component with a `.module.css` file for styling
- Use `asChild` prop (via `@radix-ui/react-slot`) to render as a different element (e.g. Link)
- See `src/components/Button/` as the reference pattern

## Key Decisions

> REPLACE: Record WHY non-obvious choices were made.

## Domain Knowledge

> REPLACE: Terms, abbreviations, or concepts specific to this project.

## Workflow

- Run typecheck after a series of code changes
- Prefer fixing root cause over workarounds
- Use plan mode (Shift+Tab) before large changes

## Don'ts

- Never hardcode values — use tokens from `src/styles/tokens.css`
- Don't import styles globally unless they're truly global (base/shared)
- Don't add Tailwind — styles belong in `.module.css` files
- Don't use inline `style={{}}` props for anything that could be a CSS Module rule
