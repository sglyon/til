---
title: "AI Coding Assistants Are Stateless and Resumable"
date: 2025-06-23
draft: false
tags: ["ai", "claude-code", "cursor", "aider", "productivity"]
categories: ["tools", "workflow"]
---

I wanted to jot down one of my
favorite pro tips for using AI coding assistants like Claude Code, Cursor, and Aider - 

The trick? they're completely stateless. When we think we're having a "conversation," we're actually just sending the entire chat history with each new request.

At first, this might seem inconvenient at best and really expensive at worst. However, putting the burden of memory in the application layer allows for inference engines to be streamlined, simple, and single focused. Also with smart use of prompt caching, sending over the chat history on every message doesn't actually end up costing as much as it seems.

What's more, this architecture unlocks a killer feature: **sessions are fully resumable**.

Here's what happened today: I was working on some code while waiting at my son's diving lesson, tethering through my iPhone. When it was time to leave, I just hit `Escape` in Claude Code to exit. Got home, opened my laptop, typed `continue`, and boom - Claude picked up exactly where we left off.

Even better, if your computer crashes or shuts down unexpectedly, you can resume your most recent session with:

```bash
claude --resume
# or
claude --continue
```

The stateless design means the entire context travels with each request, so there's nothing to "lose" when you disconnect. It's like having a persistent development session that survives across devices, network changes, and even system crashes.

This has completely changed how I work. No more worrying about losing context when switching locations or dealing with flaky connections. Just pause, move, and resume. Simple as that.
