defmodule Brouteolli.StravaAuthInMemory do
  @test_client %OAuth2.Client{token: %{access_token: "test_token"}}
  @test_athlete %Strava.Athlete{
    id: 123,
    firstname: "test_firstname",
    lastname: "test_lastname",
    measurement_preference: "test_measurement_preference",
    profile_medium: "test_profile_medium",
  }

  def get_token!([code: "test_code"]) do
    @test_client
  end

  def get_athlete!(@test_client) do
    @test_athlete
  end

  def authorize_url!(_params) do
    "test_url"
  end
end