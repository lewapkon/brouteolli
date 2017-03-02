defmodule Brouteolli.AuthController do
  use Brouteolli.Web, :controller

  @strava_auth Application.get_env(:brouteolli, :strava_auth)
  @scope "view_private"

  def index(conn, _params) do
    redirect conn, external: @strava_auth.authorize_url!(scope: @scope)
  end

  def delete(conn, _params) do
    conn
    |> clear_session
    |> configure_session(drop: true)
    |> redirect(to: "/")
  end

  @doc """
  This action is reached via `/auth/callback` and is the the callback URL that Strava will redirect the user back to with a `code` that will be used to request an access token.
  The access token will then be used to access protected resources on behalf of the user.
  """
  def callback(conn, %{"code" => code}) do
    client = @strava_auth.get_token!(code: code)
    athlete = client
      |> @strava_auth.get_athlete!
      |> process_athlete

    conn
    |> put_session(:access_token, client.token.access_token)
    |> put_flash(:info, "Welcome #{Brouteolli.Athlete.full_name(athlete)}")
    |> redirect(to: "/")
  end

  defp process_athlete(strava_athlete) do
    case Repo.get_by(Brouteolli.Athlete, sid: strava_athlete.id) do
      nil -> Brouteolli.Athlete.changeset_from_strava(%Brouteolli.Athlete{}, strava_athlete)
      athlete -> Brouteolli.Athlete.changeset_from_strava(athlete, strava_athlete)
    end
    |> Repo.insert_or_update!
  end
end
