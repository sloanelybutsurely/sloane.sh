defmodule SloaneSH.Serve.Plug do
  @moduledoc """
  Basic HTTP server for testing and local development.

  Inspired by https://github.com/mbuhot/plug_static_index_html
  """
  use Plug.Builder

  plug Plug.Logger
  plug :rewrite_for_index_html
  plug Plug.Static, at: "/", from: {:sloane_sh, "priv/output"}
  plug :not_found

  def rewrite_for_index_html(conn, _) do
    if String.match?(conn.request_path, ~r[.+\..+$]) do
      conn
    else
      %{
        conn
        | request_path: Path.join(conn.request_path, "index.html"),
          path_info: conn.path_info ++ ["index.html"]
      }
    end
  end

  def not_found(conn, _) do
    send_resp(conn, 404, "Not found")
  end
end
