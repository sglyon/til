---
date: '2025-05-12 21:16:48'
draft: false
title: 'Adding `dbt-utils` requires `dbt deps'
---

I added `dbt-utils` to an existing `dbt` project. Things worked great on dev, but not prod ("worked on my machine!")

The error message was telling me that the `dbt_project.yml` file was missing from the python dependency for dbt-utils

Not the most helpful error message. But I found the fix. I needed to run `dbt deps` (really `uv run dbt deps`) to get things fixed

After that, no more errors
