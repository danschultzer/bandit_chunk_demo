defmodule BanditChunkDemoWeb.Router do
  use BanditChunkDemoWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", BanditChunkDemoWeb do
    pipe_through :api
  end
end
