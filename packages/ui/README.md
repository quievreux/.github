# @quievreux/ui

Zentrales Design-System Package für Quievreux Applications.
Beinhaltet standardisierte Icons (Lucide) und CSS Design Tokens.

## Installation

```bash
npm install @quievreux/ui
# oder
pnpm add @quievreux/ui
```

Voraussetzung: `.npmrc` mit GitHub Token konfiguriert.

## Design Tokens

Importiere die Tokens in deine globale CSS-Datei:

```css
@import '@quievreux/ui/styles';
```

## Icons

Verwende die `Icon` Komponente für konsistente Größen:

```tsx
import { Icon } from '@quievreux/ui';
import { Music, Play } from 'lucide-react';

export function Player() {
  return (
    <div>
      <Icon icon={Music} size="md" />
      <Icon icon={Play} size="lg" className="text-primary" />
    </div>
  );
}
```

### Größen (Sizes)

| Token | Pixel | Tailwind |
|-------|-------|----------|
| `xs`  | 12px  | h-3 w-3  |
| `sm`  | 16px  | h-4 w-4  |
| `md`  | 20px  | h-5 w-5  |
| `lg`  | 24px  | h-6 w-6  |
| `xl`  | 32px  | h-8 w-8  |
| `2xl` | 40px  | h-10 w-10|

## Development

```bash
pnpm install
pnpm build
```

## Lizenz

UNLICENSED
