defmodule Brouteolli.AthleteTest do
  use Brouteolli.ModelCase

  alias Brouteolli.Athlete

  @valid_attrs %{first_name: "some content", last_name: "some content", measurement_preference: "some content", profile_image: "some content", sid: 42}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Athlete.changeset(%Athlete{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Athlete.changeset(%Athlete{}, @invalid_attrs)
    refute changeset.valid?
  end

  test "changeset with athlete" do
    athlete = %Strava.Athlete{
      id: @valid_attrs.sid,
      firstname: @valid_attrs.first_name,
      lastname: @valid_attrs.last_name,
      measurement_preference: @valid_attrs.measurement_preference,
      profile_medium: @valid_attrs.profile_image,
    }
    first_changeset = Athlete.changeset_from_strava(%Athlete{}, athlete)
    second_changeset = Athlete.changeset(%Athlete{}, @valid_attrs)
    assert first_changeset == second_changeset
  end
end
