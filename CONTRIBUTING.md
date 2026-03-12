# Contributing to releaserun-dockerfile-linter

Thanks for your interest in contributing. The linter is a single-file client-side JavaScript tool — no build step, no dependencies.

## How it works

All 18 rules live inside `index.html` as a JavaScript `RULES` array. Each rule has:
- `id` — unique identifier (e.g. `SEC-001`)
- `category` — `security`, `best-practice`, `performance`, or `maintainability`
- `severity` — `critical`, `high`, `medium`, or `low`
- `title` — short human-readable name
- `description` — what the rule checks and why it matters
- `check(lines)` — function that takes the Dockerfile lines array and returns `true` if the violation is found
- `fix` — optional: suggested fix

## Adding a new rule

1. Fork this repo
2. Open `index.html` and find the `RULES` array
3. Add your rule object following the schema above
4. Test it against `examples/bad.Dockerfile` and `examples/good.Dockerfile`
5. Update `README.md` to add your rule to the rules table
6. Open a PR with a clear description of what the rule checks and why it matters

## Rule severity guidelines

| Severity | When to use |
|----------|-------------|
| `critical` | Active security risk in all production environments |
| `high` | Security risk in most production environments |
| `medium` | Best practice violation that could cause problems |
| `low` | Maintainability or minor improvement |

## Examples

The `examples/` directory contains:
- `bad.Dockerfile` — intentionally violates many rules (for testing and demos)
- `good.Dockerfile` — follows all rules (for reference)

## Running locally

No build needed. Just open `index.html` in any browser:
```bash
open index.html
# or
python3 -m http.server 8080
```

## Bug reports

Open an issue with:
1. The Dockerfile snippet that triggered the issue (or didn't when it should have)
2. Which rule is affected
3. What you expected vs what happened
