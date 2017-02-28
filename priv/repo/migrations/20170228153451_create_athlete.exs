defmodule Brouteolli.Repo.Migrations.CreateAthlete do
  use Ecto.Migration

  def change do
    create table(:athletes) do
      add :sid, :integer
      add :first_name, :string
      add :last_name, :string
      add :measurement_preference, :string
      add :profile_image, :string

      timestamps()
    end

  end
end
