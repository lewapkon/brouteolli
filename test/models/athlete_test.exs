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
end
