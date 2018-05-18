defmodule Rv2.Repo.Migrations.CreateEmails do
  use Ecto.Migration

  def change do
    create table(:emails) do
      add :email, :string
      add :type, :string

      timestamps()
    end

  end
end
