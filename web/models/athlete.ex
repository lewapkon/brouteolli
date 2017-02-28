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
end
