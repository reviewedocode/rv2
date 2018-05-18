defmodule Rv2.Repo.Migrations.CreateCompanies do
  use Ecto.Migration

  def change do
    create table(:companies) do
      add :name, :string
      add :profile_image_url, :string
      add :overview, :text
      add :industry, :string
      add :size_code, :string
      add :location, :string
      add :verification_code, :string
      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:companies, [:user_id])
  end
end
