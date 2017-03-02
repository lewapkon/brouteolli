defmodule Brouteolli.Athlete do
  use Brouteolli.Web, :model

  schema "athletes" do
    field :sid, :integer
    field :first_name, :string
    field :last_name, :string
    field :measurement_preference, :string
    field :profile_image, :string

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:sid, :first_name, :last_name, :measurement_preference, :profile_image])
    |> validate_required([:sid, :first_name, :last_name, :measurement_preference, :profile_image])
  end

  @doc """
  Builds a changeset based on the `struct` and Strava.Athlete
  """
  def changeset_from_strava(struct, athlete) do
    params = %{
      sid: athlete.id,
      first_name: athlete.firstname,
      last_name: athlete.lastname,
      measurement_preference: athlete.measurement_preference,
      profile_image: athlete.profile_medium,
    }
    changeset(struct, params)
  end

  def full_name(struct) do
    "#{struct.first_name} #{struct.last_name}"
  end
end
