# CLAUDE.md

> This file stacks on top of the workspace root at `C:\Code\GitHub\`:
> - Root [`CLAUDE.md`](../../CLAUDE.md) -- voice, rules, routing map, references, skills, slash commands, conventions.
> - Root [`MEMORY.md`](../../MEMORY.md) -- live facts across repos.
> - Root [`STATUS.md`](../../STATUS.md) -- live PR/CI/security dashboard.
> - [`.claude/resources/`](../../.claude/resources/README.md) -- deep reference for collaboration, workflow, git, OSS, debugging, voice.
>
> Read those first. The guidance below only adds **repo-specific context** -- it does not override anything in the root.

## Project

AI-powered code translator: converts code between 45+ languages (plus natural language) via the OpenAI chat API, with streaming output and CodeMirror editors. Originally forked from mckaywrigley/ai-code-translator, now maintained standalone.

Deployed on Vercel: https://ai-code-translator-delta-six.vercel.app

## Stack

- **Language**: TypeScript 5.9
- **Framework**: Next.js 15 (Pages Router) + React 19, Tailwind CSS 3
- **Database**: none
- **Package manager**: npm (package-lock.json; Dockerfile uses `npm ci`)
- **Deploy target**: Vercel (auto-deploy on push to main); Dockerfile + docker-compose for local containers
- **Node**: 22 (`.nvmrc`)

## Run

```
npm install
npm run dev        # http://localhost:3000
npm run build
npm run lint
```

## Test

No test suite.

## Entry points

- `pages/index.tsx` -- main (only) UI page: input/output editors, language + model selects, translate action
- `pages/api/translate.ts` -- edge-runtime API route; parses TranslateBody, returns streamed translation

## Key files

- `utils/index.ts` -- the brain: prompt construction per direction (code->code, NL->code, code->NL) and `OpenAIStream` (fetch to api.openai.com, SSE parse, ReadableStream out)
- `types/types.ts` -- `TranslateBody` and OpenAI model types
- `components/` -- CodeBlock (CodeMirror), LanguageSelect, ModelSelect, APIKeyInput, TextBlock

## Gotchas

- API key resolution: client-supplied `apiKey` wins, falls back to `OPENAI_API_KEY` from `.env.local` (see `utils/index.ts:88`). Copy `.env.local.example` -> `.env.local` before dev.
- Dockerfile `CMD` runs `npm run dev`, not a production `next start` -- the container is a dev environment, not a prod image.
- `@types/react` is pinned to 18.x while `react` is 19.2 -- type mismatches near React 19 APIs may trace back to this.
- Renovate is enabled (monthly grouped, 25th of month, via the shared-workflows preset).

## Repo-specific rules

- Package manager is **npm** here, not pnpm -- lockfile and Dockerfile both assume npm. Don't switch without migrating both.

## Routes / Pages

- `/` -- the whole app (single page)

## API routes

- `POST /api/translate` -- body `{ inputLanguage, outputLanguage, inputCode, model, apiKey }`; streams plain-text translation. Edge runtime (`config.runtime = 'edge'`).
