---
date: "2024-11-05T13:14:47-05:00"
draft: false
title: Ecto changeset retrieval methods
tags: ["elixir", "ecto"]
---

When working with [Ecto.changesets](https://hexdocs.pm/ecto/Ecto.Changeset.html)
I have a hard time remembering when I should
use `get_field/3`, `get_change/3`, `fetch_field/2` and `fetch_change/2`

Here's my summary:

- the `get_*` methods are used when want to be able to provide a default value
- the `fetch_` methods return a tuple with the source of the data (or `:ok`) OR `:error`
- the `_field` methods will search either the existing data or the changes
- the `*_change` methods will search only the changes for the key

Short doc snippets for each of the methods

- `get_change/3`: Gets a change or returns a default value.
- `get_field/3`: Gets a field from changes or from the data.
- `fetch_change/2`: Fetches a change from the given changeset. Returns `{:ok, value}` if they key is found, and `:error` if not
- `fetch_field/2`: Fetches the given field from changes or from the data. Returns `{:data, value}` if the value is only present in the data, `{:changes, value}` if the value is in the changes or `:error` if the value is not found in either
