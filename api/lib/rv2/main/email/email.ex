defmodule Reviewedo.Main.Email do
  @moduledoc """
  Email list
  """
  use Ecto.Schema
  import Ecto.Changeset
  alias Reviewedo.Main.Email

  schema "emails" do
    field :email, :string
    field :type, :string

    timestamps()
  end

  @doc false
  def changeset(%Email{} = email, attrs \\ %{}) do
    email_format = ~r/^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,4}$/
    email
    |> cast(attrs, [:email, :type])
    |> validate_required([:email, :type])
    |> validate_format(:email, email_format)
    |> validate_inclusion(:type, ["candidate", "recruiter"])
  end
end
