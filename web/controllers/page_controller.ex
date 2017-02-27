defmodule Brouteolli.PageController do
  use Brouteolli.Web, :controller

  def index(conn, _params) do
    if get_session(conn, :access_token) do
      render conn, "logged_index.html"
    else
      render conn, "index.html"
    end
  end
end
