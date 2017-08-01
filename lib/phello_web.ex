defmodule PhelloWeb do
  @moduledoc """
  The entrypoint for defining your web interface, such            
  as controllers, views, channels and so on.            
  
  This can be used in your application as:            
  
      use PhelloWeb, :controller            
      use PhelloWeb, :view

  The definitions below will be executed for every view,
  controller, etc, so keep them short and clean, focused
  on imports, uses and aliases.

  Do NOT define functions inside the quoted expressions
  below.
  """

  def controller do
    quote do
      use Phoenix.Controller, namespace: PhelloWeb

      import Plug.Conn
      import PhelloWeb.Router.Helpers
      import PhelloWeb.Gettext
    end
  end

  def view do
    quote do
      use Phoenix.View, root: "lib/phello_web/templates", namespace: PhelloWeb

      # Import convenience functions from controllers
      import Phoenix.Controller, only: [get_flash: 2, view_module: 1]

      # Use all HTML functionality (forms, tags, etc)
      use Phoenix.HTML

      import PhelloWeb.Router.Helpers
      import PhelloWeb.ErrorHelpers
      import PhelloWeb.Gettext
    end
  end

  def router do
    quote do
      use Phoenix.Router
      import Plug.Conn
      import Phoenix.Controller
    end
  end

  def channel do
    quote do
      use Phoenix.Channel
      import PhelloWeb.Gettext
    end
  end

  @doc """
  When used, dispatch to the appropriate controller/view/etc.
  """
  defmacro __using__(which) when is_atom(which) do
    apply(__MODULE__, which, [])
  end
end
