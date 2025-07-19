---
title: "Using Gemini Flash for Bulk Lint Fixes"
date: 2025-07-19
draft: false
tags: ["gemini", "biome", "linting", "ai-coding", "zed"]
categories: ["ai-tools", "development"]
---

I started a new project with Claude Code, Bun, and the TanStack packages (Query, Store, Router, Table). Used Biome for linting and had about 85 lint errors right off the bat.

Decided to try Zed editor's AI integration with Gemini 2.5 Flash and gave it this simple prompt:

```
We have a lot of lint errors. Use `bun run lint` and fix them one by one as possible
```

It worked through all the fixes quickly and efficiently. What made this work well was the combination of:

- Zed's tight AI integration that keeps the model in sync with file changes
- Biome's fast linting and clear error messages
- Gemini Flash being quick enough to not interrupt the flow

The interesting takeaway is that for well-defined tasks like fixing lint errors, you don't need the most powerful model. A faster, cheaper model like Gemini Flash handles it just fine when it has good tooling integration.

The feedback loop was tight: run lint → see error → fix it → repeat. No complex reasoning needed, just pattern matching and applying fixes. Biome's error messages are clear enough that the model rarely got confused about what to do.

This is the kind of task I'd normally batch up and do manually during a "cleanup" session. Having a fast model handle it in real-time changes that dynamic - you can maintain clean code as you go rather than letting lint errors accumulate.