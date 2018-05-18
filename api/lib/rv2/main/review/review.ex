defmodule Reviewedo.Main.Review do
  use Ecto.Schema
  import Ecto.Changeset
  alias Reviewedo.Main.{Review, Company}
  alias Reviewedo.Accounts.{User}

  schema "reviews" do
    field :comment, :string
    field :professionalism, :integer
    field :communication, :integer
    field :relevance, :integer
    field :knowledge, :integer
    field :efficiency, :integer
    field :title, :string
    belongs_to :user, User
    belongs_to :company, Company

    timestamps()
  end

  @doc false
  def changeset(%Review{} = review, attrs) do
    review
    |> cast(attrs, [
      :professionalism,
      :communication,
      :relevance,
      :knowledge,
      :comment,
      :title
    ])
    |> validate_required([
      :professionalism,
      :communication,
      :relevance,
      :knowledge,
      :comment,
      :title
    ])
  end
end
