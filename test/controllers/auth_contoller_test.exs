defmodule Brouteolli.AuthControllerTest do
  use Brouteolli.ConnCase

  test "login redirects", %{conn: conn} do
    conn = get conn, "/auth/login"
    assert redirected_to(conn) =~ "test_url"
  end

  test "logout drops session and redirects", %{conn: conn} do
    conn = get conn, "/auth/callback?code=test_code"
    conn = get conn, "/auth/logout"
    assert redirected_to(conn) =~ "/"
    assert get_session(conn, :access_token) == nil
  end

  test "callback saves athlete", %{conn: conn} do
    conn = get conn, "/auth/callback?code=test_code"
    assert Repo.get_by(Brouteolli.Athlete, sid: 123) != nil
    assert redirected_to(conn) =~ "/"
    assert get_session(conn, :access_token) == "test_token"
    assert get_flash(conn, :info) =~ "Welcome"
  end
end
