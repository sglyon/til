---
title: "OAuth Proxy Unlocks MCP Authentication with Authentik"
date: 2025-09-02
draft: false
tags: ["mcp", "oauth", "authentik", "fastmcp", "authentication"]
categories: ["development", "security"]
---

I've been building an MCP server for a client that connects various tools for querying our DuckDB-based warehouse (managed with dbt). The authentication piece had me stuck for way too long - but I finally cracked it!

## The Problem

We're running Authentik as our OAuth 2.0 provider. It's solid and OAuth 2.0 compliant, but here's the catch: it doesn't support Dynamic Client Registration (DCR). Meanwhile, MCP clients expect DCR-based OAuth flows.

FastMCP has supported DCR-compliant OAuth providers like WorkOS AuthKit for a while, but that didn't help with our Authentik setup.

## The Solution

Two days ago, FastMCP 2.12 dropped with a game-changer: the `OAuthProxy` component. This brilliant piece acts as a bridge between:
- MCP clients expecting DCR-based OAuth
- Traditional client ID/secret OAuth providers like Authentik

The proxy handles the translation, allowing FastMCP servers to relay MCP client details through to non-DCR OAuth providers.

## The Relief

I'd been banging my head against this OAuth-for-MCP wall for a couple weeks. When I got it working with the new OAuthProxy, it felt like magic. Sometimes the solution you need is just a well-timed library update away.

If you're trying to integrate MCP with traditional OAuth providers, FastMCP 2.12's OAuthProxy is your friend. Don't waste time trying to force DCR where it doesn't exist - let the proxy handle the heavy lifting.
