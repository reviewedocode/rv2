defmodule Rv2.Repo.Migrations.AddStarChoicesToReview do
  use Ecto.Migration

  def up do
    alter table(:reviews) do
      remove :stars
      add :professionalism, :integer
      add :communication, :integer
      add :relevance, :integer
      add :knowledge, :integer
      add :efficiency, :integer
    end
  end

  def down do
    alter table(:reviews) do
      add :stars, :integer
      remove :professionalism
      remove :communication
      remove :relevance
      remove :knowledge
      remove :efficiency
    end
  end
end
