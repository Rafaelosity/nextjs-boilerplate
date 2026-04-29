# Next.js Boilerplate

Personal Next.js starter with SCSS architecture, image optimization, and Claude Code setup.

## Stack

- **Next.js 15** — App Router
- **TypeScript**
- **SCSS** — compiled by Next.js via `sass` package
- **sharp** — build-time image optimization for `public/images/`
- **next/image** — runtime image optimization (WebP/AVIF, lazy loading)

## Getting started

```bash
# 1. Clone and install
git clone <this-repo> my-project
cd my-project
npm install

# 2. Set up env
cp .env.example .env.local

# 3. Dev
npm run dev
```

## Scripts

| Command | What it does |
|---|---|
| `npm run dev` | Start dev server on localhost:3000 |
| `npm run build` | Optimize images in `public/images/` then build |
| `npm run lint` | Check code style |
| `npm run lint:fix` | Auto-fix style issues |
| `npm run typecheck` | TypeScript check without emitting |
| `npm run optimize-images` | Manually run the sharp optimizer |

## Styles architecture

```
src/styles/
  utils/
    _tokens.scss     # CSS custom properties (colors, spacing, type, z-index)
    _mixins.scss     # Breakpoint helpers, fluid type, focus ring, etc.
  base/
    _reset.scss      # Modern CSS reset
    _typography.scss # Base body/font styles
  layouts/
    _grid.scss       # .container, .grid, .flex primitives
  pages/             # Per-page styles — import in the page component
  shared/            # Shared partials (buttons, forms, etc.) — add as needed
  index.scss         # Imports everything except pages
```

**Import page styles directly in the component:**
```ts
// src/app/page.tsx
import '@/styles/pages/_home.scss'
```

**Never hardcode values in components** — always use tokens:
```scss
// ✓
color: var(--color-text);
padding: var(--space-4);

// ✗
color: #111111;
padding: 16px;
```

## Image optimization

Drop images into `public/images/`. They are automatically compressed at build time by `scripts/optimize-images.js` with these quality settings:

| Format | Quality |
|---|---|
| JPEG | 75 |
| PNG | 80 |
| WebP | 75 |
| AVIF | 50 |

At runtime, `next/image` serves WebP or AVIF to supported browsers.

## Claude Code setup (`.claude/`)

```
.claude/
  CLAUDE.md          # Project instructions — customize per project
  settings.json      # Permissions and hooks
  rules/             # Code quality, frontend, security, error handling, testing
  agents/            # frontend-designer, code-reviewer, security-reviewer, performance-reviewer
  skills/            # /debug-fix, /ship, /tdd, /refactor, /explain, /pr-review
  hooks/             # protect-files, scan-secrets, block-dangerous-commands, format-on-save
```

**First thing when starting a new project:** open `CLAUDE.md` and fill in the `> REPLACE:` sections.

## Path aliases

Configured in `tsconfig.json`:

```ts
import { something } from '@/lib/something'
import { MyComponent } from '@/components/MyComponent'
import type { MyType } from '@/types/my-type'
```

## Using this as a template

1. Click **Use this template** on GitHub
2. Clone your new repo
3. `npm install`
4. Edit `.claude/CLAUDE.md` — fill in project name, architecture notes, domain knowledge
5. Edit `src/styles/utils/_tokens.scss` — set your project's color palette and type scale
6. Edit `src/styles/base/_typography.scss` — add your `@font-face` declarations
7. Start building in `src/app/` and `src/components/`
