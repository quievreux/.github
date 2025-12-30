---
title: "Using @quievreux/ui in External Projects"
type: "implementation"
audience: "developer"
status: "approved"
priority: "high"
version: "1.0.0"
created: "2025-12-30"
updated: "2025-12-30"
tags: ["setup", "configuration", "ui", "design-system"]
---
# Using @quievreux/ui in External Projects
## Prerequisites
- [Node.js 20+]
- [pnpm or npm]  
- [GitHub Personal Access Token (PAT) with `read:packages` scope]
## Step 1: Authentication Setup
Since the package is hosted on the **GitHub Package Registry** (not public npm), you must configure authentication.
Create or edit the `.npmrc` file in the **root directory** of your consuming project:
```ini
# .npmrc
@quievreux:registry=https://npm.pkg.github.com
//npm.pkg.github.com/:_authToken=${GITHUB_TOKEN}
```
### Environment Variables
- **Local Development:** Set a `GITHUB_TOKEN` environment variable containing your PAT.
- **CI/CD:** Ensure `GITHUB_TOKEN` is available to the install step.
## Step 2: Installation
Install the package using your package manager:
```bash
# pnpm (recommended)
pnpm add @quievreux/ui
# npm
npm install @quievreux/ui
```
## Step 3: Styling Integration
You must import the design tokens for the styles to appear correctly.
### Option A: Global CSS (Simple)
Add this to your `globals.css` or main entry CSS file:
```css
@import '@quievreux/ui/styles';
@tailwind base;
@tailwind components;
@tailwind utilities;
```
### Option B: Tailwind Integration (Recommended)
To enable Tailwind Intellisense and use the tokens (colors, spacing) as utility classes:
Modify your `tailwind.config.ts`:
```typescript
import type { Config } from "tailwindcss";
const config: Config = {
  content: [
    "./src/**/*.{js,ts,jsx,tsx,mdx}",
    // 👇 IMPORTANT: Include the package in content scan
    "./node_modules/@quievreux/ui/dist/**/*.{js,mjs}"
  ],
  theme: {
    extend: {
      // Map CSS variables to Tailwind colors
      colors: {
        primary: "hsl(var(--q-color-primary))",
        secondary: "hsl(var(--q-color-secondary))",
      }
    },
  },
  plugins: [],
};
export default config;
```
## Step 4: Component Usage
Imports components directly from the package. Note that you need to pass `lucide-react` icons to the `Icon` component.
```tsx
import { Icon } from '@quievreux/ui';
import { Rocket, Settings } from 'lucide-react';
export default function Dashboard() {
  return (
    <div className="p-4">
      <h1>Welcome</h1>
      
      {/* Standard Icon (20px) */}
      <Icon icon={Rocket} /> 
      
      {/* Large Colored Icon using Tailwind classes */}
      <Icon 
        icon={Settings} 
        size="xl" 
        className="text-primary hover:text-primary-hover transition-colors" 
      />
    </div>
  );
}
```
## Configuration
### Required Environment Variables
| Variable     | Description                  | Example | Required |
| ------------ | ---------------------------- | ------- | -------- |
| GITHUB_TOKEN | PAT with read:packages scope | ghp_... | yes      |
## Troubleshooting
### Issue: 401 Unauthorized during install
**Symptoms:** `npm install` fails with a 401 error or "Unable to authenticate".
**Solution:**
1. Verify your `.npmrc` is in the project root.
2. Ensure `GITHUB_TOKEN` environment variable is set in your terminal.
3. Check that the PAT has `read:packages` permission.
### Issue: Styles missing / Icons unstyled
**Symptoms:** Icons appear but have wrong sizes or colors don't work.
**Solution:**
1. Check if `@import '@quievreux/ui/styles';` is present in your CSS.
2. If using Tailwind, verify the `content` array in `tailwind.config.ts` includes the node_modules path.
