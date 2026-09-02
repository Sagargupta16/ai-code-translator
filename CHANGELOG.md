# Changelog

## [1.2.1] - 2026-09-02

- Fix Dependabot security alerts via npm overrides: nanoid 3.3.16 -> 3.3.18 (infinite loop, GHSA-2v37-7h3g-55p8), js-yaml 4.3.0 -> 4.3.2 (quadratic CPU in !!omap, GHSA-5p4m-2wfm-xmqj), sharp 0.34.5 -> 0.35.x (libvips CVEs, GHSA-f88m-g3jw-g9cj)
- Fix npm audit high: brace-expansion 1.1.16/5.0.8 -> 1.1.18/5.0.9 (DoS, GHSA-mh99-v99m-4gvg, GHSA-rgw5-rvv9-x895)
- Update Next.js 15 to 16, React 19, Tailwind CSS 4 (Renovate monthly majors)
- Add CI workflow (lint, typecheck, build) and CLAUDE.md
- Harden Dockerfile: non-root user, explicit COPY paths, port 3000, exclude .env and .next from build context
- Sync package.json version with changelog

## [1.2.0] - 2026-03-14

- Add LICENSE and improve README documentation

## [1.1.0] - 2026-03-07

- Fix security vulnerabilities via npm audit fix
- Update Next.js to v16.1.5 (security patch)

## [1.0.0] - 2023-11-14

- AI-powered code translator with OpenAI GPT-3.5/GPT-4
- Next.js with Edge runtime API route
- 50+ programming languages, Server-Sent Events streaming
- CodeMirror 6 editor with Tokyo Night theme
- Deployed on Vercel
