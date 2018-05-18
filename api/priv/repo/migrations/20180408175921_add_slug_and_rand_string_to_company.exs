defmodule Rv2.Repo.Migrations.AddSlugAndRandStringToCompany do
  use Ecto.Migration

  def change do
    alter table(:companies) do
      add :slug, :string
      add :rand_string, :string
    end
  end
end
