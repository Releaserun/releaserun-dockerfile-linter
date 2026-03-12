# ReleaseRun Dockerfile Linter

Free client-side Dockerfile security linter. Paste your Dockerfile, get an A-F grade and a breakdown of every violation.

**Try it:** [releaserun.com/tools/dockerfile-linter/](https://releaserun.com/tools/dockerfile-linter/)

No signup, no upload, runs entirely in the browser.

---

## What it checks

18 rules across 4 categories.

### Security (8 rules)

| ID | Severity | What it flags |
|----|----------|---------------|
| SEC-001 | Critical | No `USER` directive — container runs as root |
| SEC-002 | High | Missing `HEALTHCHECK` |
| SEC-003 | Critical | Hardcoded credentials in `ENV` (passwords, API keys, tokens) |
| SEC-004 | Medium | `ADD` instead of `COPY` — allows tar extraction and remote URL fetch |
| SEC-005 | Critical | `curl \| bash` or `wget \| sh` — remote code execution risk |
| SEC-006 | High | Credential-related files copied into image |
| SEC-007 | High | `latest` tag on base image — non-deterministic builds |
| SEC-008 | Low | Privileged container hints |

### Best Practices (5 rules)

| ID | Severity | What it flags |
|----|----------|---------------|
| BP-001 | Medium | Multiple separate `RUN` commands (unnecessary layers) |
| BP-002 | Low | `COPY . .` before dep install — cache gets busted on every file change |
| BP-003 | Low | No `.dockerignore` hints |
| BP-004 | Medium | `ADD` where `COPY` would do |
| BP-005 | Low | Full base image when a `-slim` variant exists |

### Performance (3 rules)

| ID | Severity | What it flags |
|----|----------|---------------|
| PF-001 | Medium | `apt-get upgrade` in Dockerfile (non-deterministic) |
| PF-002 | Medium | `apk add` without `--no-cache` |
| PF-003 | Low | Package manager cache not cleaned after install |

### Maintainability (2 rules)

| ID | Severity | What it flags |
|----|----------|---------------|
| MAINT-001 | Low | No `LABEL` metadata |
| MAINT-002 | Low | No `EXPOSE` directive |

---

## Grading

Violations are weighted. Critical hits hardest, Low barely moves the needle.

| Grade | Points | What it means |
|-------|--------|----------------|
| A | 0 | Clean |
| B | 1-20 | Minor issues |
| C | 21-40 | Moderate issues |
| D | 41-70 | Real problems |
| F | 71+ | Needs fixing before shipping |

Point weights: Critical = 40, High = 20, Medium = 10, Low = 5.

---

## Example

A typical "quick-and-dirty" Dockerfile:

```dockerfile
FROM node:latest
ADD . /app
RUN npm install
CMD ["node", "server.js"]
```

Violations: SEC-007 (latest tag), SEC-004 (ADD), BP-002 (copy before install), BP-001 (separate RUN layers not chained), SEC-001 (no USER), SEC-002 (no HEALTHCHECK).

That's D or F territory. The linter tells you exactly what to fix and why.

---

## Use it

Online: [releaserun.com/tools/dockerfile-linter/](https://releaserun.com/tools/dockerfile-linter/)

The tool runs in the browser, so nothing leaves your machine. Paste, grade, fix.

---

## Rules reference

See [RULES.md](./RULES.md) for full rule definitions, severity weights, and grading logic.

Want to suggest a rule? Open an issue.

---

## Part of ReleaseRun

ReleaseRun tracks software EOL dates, CVEs, and version health for 300+ technologies. Free tools for developers at [releaserun.com/tools/](https://releaserun.com/tools/).
