defmodule BanditChunkDemoWeb.ChunkController do
  use BanditChunkDemoWeb, :controller

  alias NimbleCSV.RFC4180, as: CSV

  def show(conn, _params) do
    conn
    |> put_resp_content_type("text/csv")
    |> put_resp_header("content-disposition", "attachment; filename=\"results.csv\"")
    |> send_chunked(:ok)
    |> chunked_response()
  end

  defp chunked_response(conn) do
    Enum.reduce_while(1..10, conn, fn i, conn ->
      case chunk(conn, CSV.dump_to_iodata([["ROW #{i}"]])) do
        {:error, :closed} ->
          {:halt, conn}

        {:ok, conn} ->
          :timer.sleep(1_000)

          {:cont, conn}
      end
    end)
  end
end
