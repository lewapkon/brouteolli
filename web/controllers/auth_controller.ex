defmodule Brouteolli.AuthController do
  use Brouteolli.Web, :controller

  @scope "view_private"

  def index(conn, _params) do
    redirect conn, external: Strava.Auth.authorize_url!(scope: @scope)
  end

  def delete(conn, _params) do
    conn
    |> configure_session(drop: true)
    |> redirect(to: "/")
  end

  @doc """
  This action is reached via `/auth/callback` and is the the callback URL that Strava will redirect the user back to with a `code` that will be used to request an access token.
  The access token will then be used to access protected resources on behalf of the user.
  """
  def callback(conn, %{"code" => code}) do
    client = Strava.Auth.get_token!(code: code)
    # athlete = Strava.Auth.get_athlete!(client)

    conn
    |> put_session(:access_token, client.token.access_token)
    |> redirect(to: "/")
  end
end