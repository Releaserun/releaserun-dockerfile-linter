# Dockerfile Linting Rules

The ReleaseRun Dockerfile Linter checks 18 rules across 4 categories. All rules are weighted for a letter grade (A–F).

Try the online linter: **[releaserun.com/tools/dockerfile-linter/](https://releaserun.com/tools/dockerfile-linter/)**

## Security (8 rules)

| ID | Severity | Rule |
|----|----------|------|
| SEC-001 | Critical | Running as root — no `USER` directive |
| SEC-002 | High | Missing `HEALTHCHECK` |
| SEC-003 | Critical | Hardcoded credentials in `ENV` |
| SEC-004 | Medium | Using `ADD` instead of `COPY` (allows tar extraction and remote URL fetch) |
| SEC-005 | Critical | Curl-pipe-to-shell (`curl ... | bash` or `wget ... | sh`) |
| SEC-006 | High | Credential-related files copied into image |
| SEC-007 | High | Using `latest` tag (non-deterministic builds) |
| SEC-008 | Low | Privileged container hints (`--privileged`) |

## Best Practices (5 rules)

| ID | Severity | Rule |
|----|----------|------|
| BP-001 | Medium | Multiple separate `RUN` commands (increases layer count) |
| BP-002 | Low | Poor `COPY` order (copy all before installing deps — breaks cache) |
| BP-003 | Low | Missing `.dockerignore` hints |
| BP-004 | Medium | `ADD` used where `COPY` would suffice |
| BP-005 | Low | Large base image when a `-slim` variant exists |

## Performance (3 rules)

| ID | Severity | Rule |
|----|----------|------|
| PF-001 | Medium | `apt-get upgrade` in Dockerfile (introduces non-determinism) |
| PF-002 | Medium | `apk add` without `--no-cache` |
| PF-003 | Low | Package manager cache not cleaned after install |

## Maintainability (2 rules)

| ID | Severity | Rule |
|----|----------|------|
| MAINT-001 | Low | No `LABEL` metadata |
| MAINT-002 | Low | No `EXPOSE` directive |

## Grading

Grades are calculated by summing violation weights:
- Critical = 40 points
- High = 20 points  
- Medium = 10 points
- Low = 5 points

| Grade | Score |
|-------|-------|
| A | 0 |
| B | 1–20 |
| C | 21–40 |
| D | 41–70 |
| F | 71+ |
