---
date: '2025-05-28 14:59:37'
draft: false
title: "Ecto's `preload` with joins uses a single query!"
---

TIL that when you explicitly join associations in Ecto and use `preload`, it executes just ONE query:

```elixir
# ✅ Single query - uses the joined data!
from(rt in RaceTeam,
  left_join: r in assoc(rt, :race),
  left_join: cl in assoc(rt, :clues),
  where: rt.id == ^team_id,
  preload: [race: r, clues: cl]
)
|> Repo.one()
```

I always thought `preload` meant multiple queries, but that's only true without explicit joins:

```elixir
# ❌ Multiple queries
RaceTeam
|> preload([:race, :clues])
|> Repo.one()
```

The joined version handles the SQL row duplication problem automatically, grouping everything into the proper nested structure. No more N+1 queries AND no manual grouping needed! 🚀
