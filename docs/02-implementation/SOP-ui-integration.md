---
title: "SOP: Integrating @quievreux/ui Design System"
type: "implementation"
audience: "developer"
status: "approved"
priority: "critical"
version: "1.0.0"
created: "2025-12-30"
updated: "2025-12-30"
tags: ["standard-procedure", "ui", "onboarding"]
---

# Standard Operating Procedure (SOP): Integrating @quievreux/ui

## Executive Summary
This procedure outlines the mandatory steps to integrate the centralized Design System (`@quievreux/ui`) into application repositories. Adherence to this guide ensures visual consistency and maintainability across the ecosystem.

---

## 1. Authentication Configuration

The package is hosted on **GitHub Packages**. Access requires authentication via Personal Access Token (PAT).

### 1.1 Project Configuration
Create a `.npmrc` file in the project's root directory:

```ini
@quievreux:registry=https://npm.pkg.github.com
//npm.pkg.github.com/:_authToken=${GITHUB_TOKEN}
```

### 1.2 Environment Setup
- **Local Development:** Developers must have a `GITHUB_TOKEN` environment variable set with `read:packages` scope.
- **CI/CD (GitHub Actions):** The workflow must expose the token to the installation step:
  ```yaml
  - name: Install Dependencies
    run: npm ci
    env:
      GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
  ```

---

## 2. Dependencies

Install the UI package and its peer dependencies using your package manager:

```bash
# Install package
npm install @quievreux/ui

# Ensure peer dependencies are present (if not automatically installed)
npm install lucide-react
```

---

## 3. Tailwind CSS Integration

To enable the design tokens and ensure the library's styles are included in the build, update `tailwind.config.ts`:

```typescript
import type { Config } from "tailwindcss";

const config: Config = {
  content: [
    "./src/**/*.{js,ts,jsx,tsx,mdx}",
    // ⬇️ CRITICAL: Add this line to scan the UI package for utility classes
    "./node_modules/@quievreux/ui/dist/**/*.{js,mjs}"
  ],
  theme: {
    extend: {
      // Map CSS Variables to Tailwind Colors
      colors: {
        primary: {
          DEFAULT: "hsl(var(--q-color-primary))",
          hover: "hsl(var(--q-color-primary-hover))",
          active: "hsl(var(--q-color-primary-active))",
        },
        secondary: {
          DEFAULT: "hsl(var(--q-color-secondary))",
          hover: "hsl(var(--q-color-secondary-hover))",
          active: "hsl(var(--q-color-secondary-active))",
        }
      }
    },
  },
  plugins: [],
};
export default config;
```

---

## 4. Global Styles

Import the Design System's CSS tokens in your application's entry CSS file (e.g., `globals.css`):

```css
/* Import Design Tokens */
@import '@quievreux/ui/styles';

@tailwind base;
@tailwind components;
@tailwind utilities;
```

---

## 5. Usage Guidelines

### 5.1 Icons
**Rule:** Always use the `Icon` wrapper component to maintain consistent sizing relative to the text scale.

```tsx
import { Icon } from '@quievreux/ui';
import { Rocket } from 'lucide-react';

// ✅ CORRECT:
<Icon icon={Rocket} size="md" />

// ❌ INCORRECT:
<Rocket className="w-5 h-5" />
```

### 5.2 Version Management
The package uses Semantic Versioning.
- **Bug Fixes:** Automatic patch updates (`^0.1.x`) are safe.
- **New Features:** Require minor updates.
- **Updates:** Run `npm update @quievreux/ui` to fetch the latest version.
