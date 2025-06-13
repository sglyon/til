---
title: "Back up remote supabase project to local supabase"
date: 2025-06-13
draft: false
tags: ["supabase"]
categories: ["backend"]
---

To get a full copy of your remote/prod supabase setup in local do the following after first signing in, linking a project, starting supabase locally via the cli;

```sh
# reset migrations
supabase db reset

# pull latest schema
supabase db pull

# apply migrations
supabase migration up

# Dump data from remote
supabase db dump --db-url 'REMOTE CONNECTION_STRING' -f data.sql --use-copy --data-only

# apply data to local
 psql --single-transaction --variable ON_ERROR_STOP=1 --command 'SET session_replication_role = replica' --file data.sql -h 127.0.0.1 -p 54322 -U postgres
```
