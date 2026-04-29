# Frontend

## Styles
- Never hardcode raw values in components — always use tokens from `src/styles/utils/_tokens.scss`
- Page styles in `src/styles/pages/`, imported directly in the page component
- Shared partials in `src/styles/shared/`
- Grid for 2D layouts, flexbox for linear arrangements, `gap` instead of margins

## Components
- Mobile-first
- All interactive elements must be keyboard-accessible
- Meaningful alt text on all images — use `alt=""` only for decorative images
- Min touch target: 44×44px
- 4.5:1 contrast ratio for normal text

## Next.js specifics
- Use `next/image` for all images — never raw `<img>` for content images
- Use `next/link` for internal navigation
- Prefer Server Components; only add `'use client'` when you need interactivity or browser APIs
- Fonts via `next/font` with `display: swap`

## Performance
- Defer image loading below the fold (`loading="lazy"` is the default in next/image)
- Use `transform`/`opacity` for animations, not layout-triggering properties
- Respect `prefers-reduced-motion`

## Anti-patterns
- No raw hex/rgb values outside token files
- No `!important` overrides
- No centered-everything layouts
- No cookie-cutter hero→cards→CTA templates without creative intent
