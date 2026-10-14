---
name: resume
description: Draft or revise a role-tailored resume variant in this repo (resume/resume-<XX>.md, built to /resume-<XX>.pdf on emilyhk.com). Use when Emily says '/resume', 'new resume draft', 'tailor my resume for <job link>', or asks to rework a resume summary or projects section.
---

# Skill: Resume Drafting

**Trigger:** `/resume`, "new resume draft", "tailor my resume for <role/link>", "rework my summary"

## Files

| Path | What |
|---|---|
| `resume/resume.md` | Base resume. Source of `/resume.pdf`, and the source of truth for every locked section. |
| `resume/resume-<XX>.md` | Role-tailored variants (`ls resume/*.md` for the current set). |
| `resume/build.sh` | pandoc + xelatex. Builds `resume/<name>.md` to `<repo root>/<name>.pdf`, which GitHub Pages serves at `emilyhk.com/<name>.pdf`. |
| `resume.html` + the nav link in `_layouts/default.html` | Both point at `/resume-ds.pdf` (switched from the base resume on 2026-10-14). |

## Hard rules

1. **Locked sections: Skills & Tools, Experience, Education.** Copy them verbatim from `resume/resume.md`. Never change them unless Emily and Claude have discussed the change first. If she approves one, ask whether it applies to the base and every variant, or only this one.
2. **The Summary is the main lever.** Most of a draft's work happens here.
3. **Projects changes only for real, current work.** Ask Emily whether she has relevant current project work, and never invent a project. When Projects changes, ask "this variant only, or the base and every variant?"
4. **Build after every draft:** `resume/build.sh resume-<XX>.md`. Build the single file. The no-argument form rebuilds every PDF, so use it only when a change touched every variant. Then report the page count and show Emily the PDF.
5. **Never trim to fit the page without Emily's review.** Don't shorten a project description, drop a project, cut summary text or tighten a bullet just to make a page fit. Report the overflow, say what would have to go, and wait for her decision. Two pages can be fine for some variants; that is her call, not a default to optimize away. The base resume is two pages by her choice (2026-10-14), so don't try to compress it.
6. **Truthfulness.** Every summary claim has to be backed by something in Experience or Projects. Never add a skill or framework from a job posting that Emily doesn't have; name the gap to her instead.
7. **Finish by shipping.** Commit and push (follow the `/commit` flow: show the files and message, then wait for her OK). The draft is done when `emilyhk.com/resume-<XX>.pdf` serves the new version.

## Workflow

### 1. Pick the variant

Run `ls resume/*.md`. If an existing variant already covers the role family, adapt it in place rather than creating a near-duplicate. Confirm the `<XX>` suffix with Emily before writing.

### 2. Read the posting

Try WebFetch first. Ashby, Greenhouse and Lever pages render with JavaScript and usually come back empty, so open them in the browser pane and use `get_page_text`. Pull out:

- must-haves and nice-to-haves
- the keywords a screener will match on (methods, model families, frameworks)
- whether the company says it screens applicants with AI tools, which makes keyword coverage matter more

Tell Emily which must-haves her locked sections can't support. That's information for her; don't paper over it.

### 3. Draft the summary

If Emily gives a draft, critique it briefly first: what each sentence is doing, what's vague, and what conflicts with her stated framing. Then write 2–3 options, or blend the pieces she points to.

Style guide:

- About 3 sentences, 60–80 words, at most 4 rendered lines.
- Implied subject ("Senior data scientist with…", "Has built…"). Never "I".
- Order: identity + years + companies → direction → concrete evidence.
- Name methods, not categories ("random forest ensembles, forecasting, NMF", not "classical ML techniques").
- Use posting keywords only where they're true.

### 4. Ask about projects

Ask whether there's current project work worth adding. If she names a public repo, read its README so the one-line description is accurate.

### 5. Write, build, iterate

Write the file: front matter, header and locked sections exactly as in `resume.md`, plus the new Summary/Projects. Every resume uses the same layout:

- Header: the name, then phone | city | email, then linkedin | website | github. Each line is centered as a whole; there are no fixed-width boxes. Emily tried exact box-centering on 2026-10-14 and chose the plain version.
- Section order: Summary → Projects → Experience → Education → Skills & Tools.

Then:

```bash
resume/build.sh resume-<XX>.md
pdfinfo resume-<XX>.pdf | grep Pages        # report it; 1 is the usual target
pdftotext -layout resume-<XX>.pdf - | head  # quick skim of the render
```

Show the PDF. Repeat for every revision.

If the page overflows, stop and review with Emily (hard rule 5). Show what spills, propose specific cuts, and let her choose, including the choice to keep two pages.

### 6. Check the locked sections

```bash
cd resume
lock() { awk '/^## /{p = ($0 ~ /^## (Skills|Experience|Education)/)} p' "$1"; }  # locked sections only, in any order
diff <(lock resume.md) <(lock resume-<XX>.md)
```

The only differences it should show are the approved ones below. If it flags anything else, ask Emily before "fixing" it.

**Approved divergences from the base:**

- **All variants** drop Capitol Records, Universal Music Group. The base resume keeps it, and new variants drop it.
- **`resume-ds.md`** has its own Skills section and its own wording for some Spotify bullets.

### 7. Commit, push, verify

1. Run the `/commit` flow. Stage the changed `resume/*.md`, their root `*.pdf`, and this skill if it changed. Commit to `master`, which is what Pages deploys.
2. Watch the deploy: `gh run list -L1`.
3. Confirm the live file. The `?v=` query busts the cache:

```bash
curl -sI "https://emilyhk.com/resume-<XX>.pdf?v=$(date +%s)" | head -3   # 200, application/pdf
curl -s "https://emilyhk.com/resume-<XX>.pdf?v=$(date +%s)" -o /tmp/live.pdf && pdftotext /tmp/live.pdf - | head -12
```

## pandoc / LaTeX cheatsheet

| Write | For |
|---|---|
| `\&` | ampersand |
| `---` | em dash |
| `\hfill` | right-aligned dates on a role line |
| `\hfill Aug 2022 -- March 2024 \` then `\mbox{}\hfill May 2016 -- May 2021` | a second tenure (Spotify) on its own right-aligned line. `\mbox{}` stops LaTeX from discarding the `\hfill` at the start of a line. |
| trailing ` \` | line break between Projects entries (not after the last one) |
| `vs.\ ` | stops LaTeX from treating "vs." as a sentence end |
| `**[Title](https://…)**` | project titles are links. Never write out a bare URL. |

Links render blue so readers can tell they're clickable: the front matter sets `urlcolor: linkblue`, defined in `header-includes` as `\definecolor{linkblue}{HTML}{1A56B8}`. Keep both lines when creating a new variant.
