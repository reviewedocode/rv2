defmodule Rv2.Repo.Migrations.AddDataToUsers do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :profile_image_url, :string
      add :job_title, :string
      add :industry, :string
      add :num_connections, :integer
    end
  end
end
