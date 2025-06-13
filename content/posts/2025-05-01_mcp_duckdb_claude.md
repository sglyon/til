---
date: '2025-05-01 13:51:48'
draft: false
title: 'Claude + Duckdb + MCP == data engineering productivity boost'
tags: ["duckdb", "data-engineering", "mcp"]
---

I was working on a job for a client and had extracted a subset of production data into a duckdb database.

I then set up the [DuckDB MCP client](https://github.com/motherduckdb/mcp-server-motherduck) (with [my `read-only` mode flag](https://github.com/motherduckdb/mcp-server-motherduck/pull/20) turned on)

I then fired up Claude Desktop and entered the following (note some data has been blanked out for privacy):

```markdown
I want to use the PRODUCTION_SCHEDULE table to find gaps in the coming months
where the nothing will be running on production lines with `line_number`
LINEABC1 and LINEABC2. The table has one row per scheduled run and has
START and END columns to show when each run will begin and end.

Can you write a query that will show us the gaps in between these
runs between today and the end of september, 2025?
```

Claude sonnet 3.7 churned away for about 40 seconds and produced an excellent result:

![Claude output](/claude_duckdb_mcp.png)

Not mind-blowing, but a big productivity boost. I couldn't have generated those queries and key takeaways in the ~2 minutes it took to have Claude do it (1 minute for me to write the prompt and 1 minute for Claude to process it).
