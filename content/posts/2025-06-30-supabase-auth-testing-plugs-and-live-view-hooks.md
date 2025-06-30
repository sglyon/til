---
title: "Supabase Auth Testing: Don't Forget Your Plugs and LiveView Hooks"
date: 2025-06-30
draft: false
tags: ["elixir", "phoenix", "supabase", "testing", "auth"]
categories: ["testing", "authentication"]
---

The elixir supabase library is community developed (Thank you!), but not quite as easy to work with as the javascript or Python variants.

I hit a tricky issue today.

I wanted to test some of my live views.

In my routerI have

```elixir
  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {DreamersdashWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :fetch_current_user
    plug :fetch_current_profile
  end

  pipeline :admin_browser do
    plug :browser
    plug :require_admin_profile
  end

  pipeline :photo_manager_browser do
    plug :browser
    plug :require_photo_manager_profile
  end

  # ... more

    scope "/", DreamersdashWeb do
    pipe_through :photo_manager_browser

    live_session :authenticated_photo_manager,
      on_mount: [
        {DreamersdashWeb.Auth, :mount_current_user},
        {DreamersdashWeb.Auth, :ensure_authenticated},
        {DreamersdashWeb.Auth, :load_current_profile},
        {DreamersdashWeb.Auth, :require_photo_manager_profile}
      ] do
      live "/admin/photos", PhotoReviewLive.Index, :index
    end
  end
```

Then In my Dreamersdash.Auth module I have:

```elixir
  def require_photo_manager_profile(conn, _opts) do
    if Dreamersdash.Accounts.has_role?(conn.assigns[:current_profile], "photo_manager") ||
         Dreamersdash.Accounts.admin?(conn.assigns[:current_profile]) do
      conn
    else
      conn
      |> put_flash(:error, "You are not authorized to access this page")
      |> redirect(to: "/users/profile")
      |> halt()
    end

  def on_mount(:load_current_profile, _params, _session, socket) do
    with user when not is_nil(user) <- socket.assigns[:current_user],
         {:ok, profile} <- Dreamersdash.Accounts.get_profile(user.id) do
      {:cont, assign_new(socket, :current_profile, fn -> profile end)}
    else
      {:error, :not_found} ->
        {:cont, assign_new(socket, :current_profile, fn -> nil end)}

      _ ->
        Logger.error("Error loading profile for user")
        {:cont, assign_new(socket, :current_profile, fn -> nil end)}
    end
  end

  def on_mount(:require_photo_manager_profile, _params, _session, socket) do
    if Dreamersdash.Accounts.has_role?(socket.assigns[:current_profile], "photo_manager") ||
         Dreamersdash.Accounts.admin?(socket.assigns[:current_profile]) do
      {:cont, socket}
    else
      {:halt,
       socket
       |> Phoenix.LiveView.put_flash(:error, "You are not authorized to access this page")
       |> Phoenix.LiveView.redirect(to: "/users/profile")}
    end
  end
```

I had some test code that tried to visit `/admin/photos`

I kept seeing the `"You are not authorized to access this page"` error mesage in my test reports, but when I tried adding `dbg` calls to the `on_mount` callbacks (defined in the `live_session`), I never saw the `dbg`

The issue was that I was not even making it through the pipline `:photo_manager_browser`. The `require_photo_manager_profile` custom plug was issuing the error message.

I had to make sure that I can pass BOTH the custom plugs AND the live view `on_mount` callbacks
