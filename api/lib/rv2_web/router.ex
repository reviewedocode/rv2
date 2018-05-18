defmodule Rv2Web.Router do
  use Rv2Web, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", Rv2Web do
    pipe_through :api
  end
end
