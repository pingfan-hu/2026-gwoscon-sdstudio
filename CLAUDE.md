# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Quarto Reveal.js presentation for Pingfan Hu's talk at GW OSCON 2026 (March 23, 2026).

**Talk title:** *sdstudio: A Companion Package for Designing and Managing surveydown Surveys*

---

## Build Commands

```bash
quarto render     # Build to _site/
quarto preview    # Live preview with hot reload
```

Slides are auto-deployed to GitHub Pages via `.github/workflows/quarto-publish.yml` on every push to `main`.

---

## Done Condition

`quarto render` exits 0 with no warnings.

`figs/*.html` files are not processed by Quarto — validate them by opening directly in a browser. The iframe height in `index.qmd` may need manual tuning after content changes.

## Notes for Claude

- The global CLAUDE.md task-file workflow (`tasks/todo.md`, `tasks/lessons.md`) does not apply to this project. This is a single-file presentation repo with no build pipeline or tests.

---

## Key Technical Details

### Styling (`styles/slides.scss`)

Single SCSS file (no separate CSS file). Key variables:
- **Font:** TsangerJinKai (serif-style), Maple Mono for code
- **Colors:** background `#F8F7F0`, text `#564232`, purple headings/links `#5654A2`, teal code `#2C8475`, amber `#FFB84D`
- **Code blocks:** background `#EDEDED`, font-size `0.6em`

**Text color utility classes** (use as `[text]{.classname}` in slides):

| Class | Hex | Description |
|-------|-----|-------------|
| `.purple` | `#5654A2` | Purple |
| `.teal` | `#2C8475` | Teal (also surveydown brand color) |
| `.amber` | `#FFB84D` | Amber/golden (also sdstudio brand color) |
| `.navy` | `#2C3E50` | Navy |
| `.coral` | `#D45F47` | Warm coral-red |
| `.rose` | `#B5476A` | Muted berry |
| `.sage` | `#4A7A5A` | Earthy green |
| `.slate` | `#5A6B80` | Cool blue-gray |
| `.gold` | `#C4881A` | Rich gold |
| `.blue` | `#3A7DC9` | Cornflower blue |

### Custom Slide Classes

Apply to slide headers as `.classname`:

| Class | Effect |
|-------|--------|
| `.dark-centered` | Navy background, light text, centered — for section dividers |
| `.light-centered` | Centered text on light background |
| `.black-centered` | Black background, light text |
| `.purple-border` | 2px purple border (for images/GIFs) |
| `.round-image` | Circular crop for headshots |
| `.bubble-left` | Speech bubble pointing left (absolute positioned) |
| `.bubble-top` | Speech bubble pointing up (absolute positioned) |
| `.four-by-three-grid` | 4×3 CSS grid layout (used for question type list) |
| `.grid-container` | Centered flexbox grid for feature boxes |
| `.centered-container` | Bordered orange-text box (for feature labels) |
| `.img-middle` | Vertically centers inline images |

### Interactive HTML Diagrams (`figs/studio-*.html`)

Self-contained HTML files embedded via `<iframe>` for rich interactive slides. All share the same design system: TsangerJinKai font, `#F8F7F0` background, `2px solid #5654A2` border, `border-radius: 14px`. Embed pattern:

```html
<iframe src="figs/studio-something.html" style="width:100%; height:280px; border:none;"></iframe>
```

| File | Slide purpose |
|------|--------------|
| `studio-workflow.html` | 6-step sdstudio workflow |
| `studio-icons.html` | Editing & Controlling icon groups with hover dark-fill effect |
| `studio-editing.html` | GUI vs Script two-card comparison |
| `studio-views.html` | Desktop vs Mobile two-card comparison |
| `studio-responses.html` | Local vs Database two-card comparison |
| `studio-summary.html` | 3×2 feature grid summary |
| `studio-closing.html` | surveydown + sdstudio comparison with two stacked sub-cards per side |
| `surveydown-intro.html` | surveydown + Quarto + Shiny = survey equation (legacy: uses base64 images) |
| `surveydown-problem.html` | Two-card problem statement (Code-Only, Learning Curve) |
| `surveydown-transition.html` | Transition slide between surveydown and sdstudio sections |
| `surveydown-component.html` | surveydown component overview |
| `surveydown-features.html` | surveydown feature cards |

**Design conventions for ALL HTML files — follow these strictly when creating new ones:**

#### Structure
- `body { background: transparent; overflow: hidden; }` — blends into slide, no scrollbars
- Outer container: `background: #FFFFFF; border: 2px solid #5654A2; border-radius: 14px;`
- Font: TsangerJinKai loaded via CDN (see existing files for `@font-face` snippet)
- Icons: Lucide via `<script src="https://unpkg.com/lucide@latest/dist/umd/lucide.min.js">`

#### Colors
- surveydown brand = teal `#2C8475`; sdstudio brand = amber `#FFB84D`
- Primary accent (borders, operators) = purple `#5654A2`
- Body text = `#564232`; icon gold on light bg = `#C4881A`
- Card backgrounds: teal tint `rgba(44,132,117,0.10)`, amber tint `rgba(255,184,77,0.12)`

#### Hover behavior (hover-only — no click/active)
Every interactive element (cards, logo items, result images) must follow this exact pattern:

```css
.card {
  transition: transform 0.18s, background 0.18s, border-color 0.18s;
  will-change: transform;
  backface-visibility: hidden;
  cursor: pointer;
  user-select: none;
}
.card:hover {
  transform: translateY(-3px);
  background: rgba(..., 0.22);   /* slightly stronger tint */
  border-color: #5654A2;         /* or brand color */
}
```

**Never add click/active behavior.** No `addEventListener('click', ...)`, no `.active` CSS class, no JS beyond `lucide.createIcons()`.

#### Images inside HTML files
Use **relative paths** (e.g., `src="logo-foo.png"`) — simple and maintainable. This works because `_quarto.yml` declares `figs/` as a resource directory, so Quarto copies the entire `figs/` folder to `_site/figs/`:

```yaml
# _quarto.yml
project:
  resources:
    - figs/
```

If you add a new asset subdirectory and images aren't appearing in the rendered site, add it to `resources` in `_quarto.yml` the same way. Do **not** use base64 embedding — it bloats files and makes them hard to edit.

#### Embedding in index.qmd
```html
<iframe src="figs/something.html" style="width:100%; height:300px; border:none;"></iframe>
```
Height needs manual tuning — open the HTML directly in a browser first, then adjust the iframe `height` in `index.qmd`.

### `scripts.R` Helper Functions

All slide code examples are generated by R functions in `scripts.R` using `#| results: 'asis'` chunks. All accept an optional `highlights` parameter (e.g., `"1-5"`, `"3,7"`) for line highlighting.

| Function | Generates |
|----------|-----------|
| `surveycode(highlights)` | Sample `survey.qmd` with pages and `sd_question()` |
| `appcode_short(highlights)` | Minimal `app.R` (no DB) |
| `appcode_long(highlights)` | Full `app.R` with `sd_db_connect()` |
| `question_text()` | `sd_question(type = "text", ...)` example |
| `question_mc()` | `sd_question(type = "mc", ...)` example |
| `question_mc_buttons()` | `sd_question(type = "mc_buttons", ...)` example |
| `question_slider_numeric()` | `sd_question(type = "slider_numeric", ...)` example |
| `show_if_survey()` | `survey.qmd` side of conditional showing |
| `show_if_app()` | `app.R` side with `sd_show_if()` |
| `quarto_r_html()` | Generic Quarto R→HTML example |
| `quarto_python_pdf()` | Generic Quarto Python→PDF example |

The `fence_start()` internal helper converts range strings (`"1-5"` → `"1,2,3,4,5"`) for Reveal.js code highlighting.
