# Project Summary: sdstudio Talk — GW OSCON 2026

## Overview

This is a **Quarto Reveal.js** presentation for Pingfan Hu's talk at GW OSCON 2026 (March 23, 2026).

**Talk title:** *sdstudio: A Companion Package for Designing and Managing surveydown Surveys*

**Speaker:** Pingfan Hu, PhD Candidate at George Washington University (supervised by Dr. John Helveston)

---

## File Structure

| File | Purpose |
|------|---------|
| `index.qmd` | Main slide deck — all slide content lives here |
| `_quarto.yml` | Quarto project config: title, author, Reveal.js theme/CSS settings |
| `scripts.R` | R helper functions that generate inline code blocks for slides |
| `styles/theme.scss` | SCSS theme variables (fonts, colors, heading sizes) |
| `styles/slides.css` | Additional CSS for custom slide classes |
| `README.md` | Brief description of the talk and date |
| `.github/workflows/quarto-publish.yml` | CI/CD for publishing the site |
| `figs/` | All images and GIFs used in slides |
| `_site/` | Rendered output (auto-generated, do not edit) |
| `.quarto/` | Quarto cache/freeze files (auto-generated) |

---

## Talk Content Outline

The slides walk through the `surveydown` R package and its companion `sdstudio`:

1. **About the speaker** — Pingfan Hu's research: sustainable transportation, choice modeling, research software
2. **Problem** — WYSIWYG survey tools (e.g., Google Forms) lack reproducibility, version control, features, and open-source
3. **Solution** — Make surveys from code using `surveydown`
4. **What is surveydown?** — An R package that renders Quarto `.qmd` files into interactive surveys
   - Built on Quarto + R Shiny for interactivity
   - Uses PostgreSQL (via Supabase) for data storage
5. **How surveydown works**
   - `survey.qmd` — Quarto doc defining pages and questions
   - `app.R` — Shiny app wiring (`sd_ui()` + `sd_server()`)
   - `sd_db_connect()` for database connection
6. **Features**
   - 12 built-in question types (`text`, `mc`, `mc_buttons`, `slider`, `date`, etc.)
   - Conditional logic: `sd_show_if()`, skip logic, stop logic
   - Shiny-compatible (leaflet maps, LLM integration, etc.)
7. **What's next: `sdstudio`**
   - Companion package launched via `sdstudio::launch()`
   - GUI for building surveys, previewing, and managing data
8. **Call to action** — GitHub repo, docs at surveydown.org, workshop by Dr. John Helveston

---

## Key Technical Details

### Quarto Config (`_quarto.yml`)
- Output: `revealjs` format, rendered to `_site/`
- Theme: `styles/theme.scss` + `styles/slides.css`
- Footer links to speaker site and conference page
- Title slide background: `figs/logo-sdstudio.png`

### Custom Theme (`styles/theme.scss`)
- Font: Palatino Linotype (serif)
- Colors: warm background `#F8F7F0`, brown text `#564232`, purple headings/links `#5654A2`, teal inline code `#2C8475`
- Code blocks: light gray background `#EDEDED`, small font (0.6em)

### scripts.R Helper Functions
These R functions generate fenced code blocks for slides (used with `#| results: 'asis'`):
- `surveycode(highlights)` — Shows a sample `survey.qmd`
- `appcode_short(highlights)` / `appcode_long(highlights)` — Shows sample `app.R`
- `question_text()`, `question_mc()`, `question_mc_buttons()`, `question_slider_numeric()` — Question type examples
- `show_if_survey()` / `show_if_app()` — Conditional logic examples
- `quarto_r_html()` / `quarto_python_pdf()` — Generic Quarto usage examples
- All support optional `highlights` parameter (line ranges like `"1-5"` or `"3,7"`) for code highlighting

### Build Command
```bash
quarto render
# or
quarto preview
```
