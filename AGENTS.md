# Agent Guidelines

## Commands
- **Build**: `pnpm build` (workspace) or `pnpm run build` (package)
- **Lint**: `pnpm lint` (workspace) or `pnpm run lint` (package) 
- **Type Check**: `pnpm run typecheck` (package only)
- **Dev**: `pnpm run dev` (package watch mode)
- **Clean**: `pnpm run clean` (package only)

## Code Style
- **TypeScript**: Strict mode enabled, no unused locals/parameters
- **Imports**: Use `import { Component } from 'lucide-react'` pattern, organize external imports first
- **Naming**: PascalCase for components, camelCase for variables/props
- **Components**: Export interfaces, use JSDoc comments with examples
- **Props**: Destructure with defaults, use `Omit` for extending Lucide props
- **Classes**: Use Tailwind utility classes, trim whitespace with `.trim()`
- **Accessibility**: Include `aria-label` and `aria-hidden` props
- **Error Handling**: Use TypeScript strict mode for compile-time safety

## Project Structure
- Monorepo with pnpm workspaces
- UI package in `packages/ui/` with React components
- Build output to `dist/` with ESM/CJS dual exports
- Use tsup for bundling, ESLint + TypeScript for linting