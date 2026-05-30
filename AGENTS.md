# pt-shorts.gr — Potidania Film Festival

Static GitHub Pages site. No build step, no package manager, no tests.

## Deploy

- Pushed from `docs/` subdirectory (GitHub Pages serves from `/docs`).
- Custom domain `pt-shorts.gr` — CNAME at repo root AND `docs/CNAME` both needed.
- `git push origin main` → auto-deploys. No action / workflow file.
- Pre-commit hooks via Husky: run `npm install` after clone. Hook runs `npm run format && git add -A && npm run validate`.

## Validation (`npm run validate`)

- **CNAME check** — both root `CNAME` and `docs/CNAME` must contain `pt-shorts.gr`.
- **Image reference check** — every `<img src>` pointing to a local file must exist.
- **HTML validation** — runs `html-validate` on `docs/index.html`. Warnings only (no errors block commit).

## Structure

- `docs/index.html` — single-page site, all CSS inline in `<style>`.
- `docs/assets/` — images, logos, sponsor logos, judge photos, masterclass materials.
- Updating a hero image or button link? Edit the `<img src>` or `<a href>` directly in `index.html`.

## Content

- FilmFreeway submission button: `docs/index.html:503` — update URL yearly.
- Instagram / Facebook links in footer at bottom.
- The 2025 recap archive lives at `docs/2025/index.html` (separate page linked from footer).
- Award pages live under `docs/assets/awards/`.
- Judge bios reference profile images under `docs/assets/`.
