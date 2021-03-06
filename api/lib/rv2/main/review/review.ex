defmodule Rv2.Main.Review do
  use Ecto.Schema
  import Ecto.Changeset
  alias Rv2.Main.{Review, Company}
  alias Rv2.Accounts.{User}

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
