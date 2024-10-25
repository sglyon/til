---
# weight: 1
title: "Elixir Update in"
date:  '2024-10-25T00:00:58-04:00'
tags: ["elixir"]
ShowToc: true
---

The `update_in` function and `Access` module of Elixir are extremely powerful.

Here's a snippet I just wrote in Jupyteach:

```elixir
  def strip_jupyteach_metadata_from_ipynb_map(ipynb) do
    ipynb
    |> update_in(["metadata"], &Map.drop(&1, ["jupyteach"]))
    |> update_in(["cells", Access.all(), "metadata"], &Map.drop(&1, ["jupyteach"]))
  end
```

`ipynb` is a map that follows the Jupyter notebook [spec](https://nbformat.readthedocs.io/en/latest/)

To support some features I jupyteach, I add custom cell metadata to the cells so when we import back in to Jupyteach we know where we are.

Some of these metadata entries are sensitive and should be stripped out when exporting for public use or even for student use (we store solutions in the metadata!)

The root of the notebook structure as well as cells are allowed to have `metadata` objects. Within those I added a `jupyteach` object to store this sensitive data.

The function above will delete the `jupyteach` key from the root of the ipynb map AND from any cell. The key to get it out of all cells is to use `["cells", Access.all()  "metadata"]`
