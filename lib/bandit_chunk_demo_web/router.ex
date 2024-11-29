defmodule BanditChunkDemoWeb.Router do
  use BanditChunkDemoWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", BanditChunkDemoWeb do
    pipe_through :api

    get "/", ChunkController, :show
  end
end
