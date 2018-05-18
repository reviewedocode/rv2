defmodule Rv2.Repo.Migrations.CreateReviews do
  use Ecto.Migration

  def change do
    create table(:reviews) do
      add :stars, :integer
      add :comment, :text
      add :title, :string
      add :user_id, references(:users, on_delete: :nothing)
      add :company_id, references(:companies, on_delete: :nothing)

      timestamps()
    end

    create index(:reviews, [:user_id])
    create index(:reviews, [:company_id])
  end
end
