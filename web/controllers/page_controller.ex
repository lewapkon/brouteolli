defmodule Brouteolli.PageController do
  use Brouteolli.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
