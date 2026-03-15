# Lessons Learned

## CSS: Lucide icons use `svg`, not `i`

**Rule:** When styling Lucide icons, target `svg` elements not `i` elements.

**Why:** Lucide replaces `<i data-lucide="...">` with inline `<svg>` at runtime. CSS targeting `i` has no effect.

**How to apply:** Any time Lucide (or similar icon libraries that swap elements) is used, write `.step svg { color: ... }` not `.step i { color: ... }`.

---

## Mobile layout: avoid fixed max-width on title slides

**Rule:** Do not use `max-width` percentage constraints on title slide content when mobile responsiveness matters.

**Why:** When Quarto triggers its mobile layout, a `max-width: 70%` block gets positioned relative to the mobile container width — creating large empty margins on left/right.

**How to apply:** Use natural content width instead. Short title/author text won't stretch to overlap logos even without the constraint.

---

## Absolutely position badge elements to avoid disrupting flex alignment

**Rule:** When a card has some items with badges and some without, absolutely position the badges at the card bottom.

**Why:** Adding badges inside the flex flow shifts the vertical alignment of icon+title for cards that have badges, making them misaligned with badge-free cards.

**How to apply:** Set `position: relative` on the card, `position: absolute; bottom: Xpx` on the badge, and add `padding-bottom` to the card to prevent overlap.
