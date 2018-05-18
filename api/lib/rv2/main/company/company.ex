defmodule Rv2.Main.Company do
  use Ecto.Schema
  import Ecto.Changeset
  alias Rv2.Main.{Company, Review}

  schema "companies" do
    field :name, :string
    field :industry, :string
    field :location, :string
    field :overview, :string
    field :profile_image_url, :string
    field :size_code, :string
    field :verification_code, :string
    field :user_id, :id
    field :slug, :string
    field :rand_string, :string
    has_many :reviews, Review

    timestamps()
  end

  @doc false
  def changeset(%Company{} = company, attrs) do
    company
    |> cast(attrs, [
      :name,
      :profile_image_url,
      :overview,
      :industry,
      :size_code,
      :location,
      :verification_code
    ])
    |> validate_required([
      :name,
      :overview,
      :industry,
      :size_code,
      :location
    ])
    |> slugify_name()
    |> rand_string()
  end

  defp slugify_name(changeset) do
    if name = get_change(changeset, :name) do
      put_change(changeset, :slug, slugify(name))
    else
      changeset
    end
  end

  def slugify(string) do
    string
    |> String.downcase()
    |> String.replace(~r/[^\w-]+/u, "-")
  end

  defp rand_string(changeset) do
    changeset
    |> put_change(:rand_string, gen_rand_string(6))
  end

  @alphabet Enum.concat([?0..?9, ?A..?Z, ?a..?z])

  def gen_rand_string(count) do
    :rand.seed(:exsplus, :os.timestamp())
    Stream.repeatedly(&random_char_from_alphabet/0)
    |> Enum.take(count)
    |> List.to_string()
  end

  defp random_char_from_alphabet do
    Enum.random(@alphabet)
  end

  defimpl Phoenix.Param, for: Company do
    def to_param(%{slug: slug, rand_string: rand_string}) do
      "#{rand_string}-#{slug}"
    end
  end
end
