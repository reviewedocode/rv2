defmodule Rv2.Accounts.User do

  @moduledoc """
  Provides user schema and changeset functionality
  """
  use Ecto.Schema
  import Ecto.Changeset
  alias Rv2.Accounts.{User, Role}
  alias Rv2.Main.{Review}
  alias Comeonin.Bcrypt

  schema "users" do
    field :active, :boolean, nil: false, default: true
    field :email, :string
    field :first_name, :string
    field :last_name, :string
    field :profile_image_url, :string
    field :job_title, :string
    field :industry, :string
    field :num_connections, :integer
    field :password, :string, virtual: true
    field :password_hash, :string
    field :terms_accepted, :boolean
    field :verified, :boolean, nil: false, default: false
    belongs_to :role, Role
    has_many :reviews, Review
    timestamps()
  end

  @doc false
  def changeset(struct, attrs \\ %{}) do
    struct
    |> cast(attrs, [
      :email,
      :first_name,
      :last_name,
      :password,
      :verified,
      :terms_accepted,
      :active
    ])
    |> validate_required([
      :email,
      :first_name,
      :last_name,
      :password,
      :verified,
      :terms_accepted,
      :active
    ])
    |> email_changeset(attrs)
  end

  def email_changeset(struct, attrs \\ %{}) do
    email_format = ~r/^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,4}$/
    struct
    |> cast(attrs, [:email])
    |> validate_required([:email])
    |> validate_format(:email, email_format)
    |> unique_constraint(:email)
  end

  def email_verification_changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:verified])
    |> validate_required([:verified])
  end

  def registration_changeset(%User{} = user, attrs \\ %{}) do
    user
    |> changeset(attrs)
    |> terms_accepted(attrs)
    |> validate_password()
    |> put_password_hash()
  end

  def new_password_changeset(struct, params \\ %{}) do
    message = "Passwords do not match"
    struct
    |> cast(params, [:password])
    |> validate_required([:password])
    |> validate_confirmation(:password, required: true, message: message)
    |> validate_password()
    |> put_password_hash()
  end

  defp terms_accepted(changeset, attrs) do
    message = "You must agree to the terms and conditions"
    changeset
    |> cast(attrs, [:terms_accepted])
    |> validate_required([:terms_accepted])
    |> validate_inclusion(:terms_accepted, [true], message: message)
  end

  defp validate_password(changeset) do
    changeset
    |> validate_required([:password])
    |> validate_length(:password, min: 6, max: 100)
    |> validate_format(:password, ~r/^(?=.*[A-Z])(?=.*\d)(?=.*(_|[^\w])).+$/)
  end

  defp put_password_hash(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: given_pass}} ->
        put_change(changeset, :password_hash, Bcrypt.hashpwsalt(given_pass))
      _ ->
        changeset
    end
  end
end
