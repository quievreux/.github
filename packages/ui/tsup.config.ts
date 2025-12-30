import { defineConfig } from 'tsup';

export default defineConfig({
  entry: ['src/index.ts'],
  format: ['cjs', 'esm'],
  dts: true,
  splitting: true,
  sourcemap: true,
  clean: true,
  treeshake: true,
  external: ['react', 'react-dom', 'lucide-react'],
  esbuildOptions(options) {
    options.banner = {
      js: '"use client";', // Next.js App Router Kompatibilität
    };
  },
});
