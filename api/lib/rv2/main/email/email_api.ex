defmodule Rv2.Main.EmailAPI do
  @moduledoc """
  Provides an API for all functions relating to email signups
  """
  defmacro __using__(_) do
    quote do

      alias Rv2.{Repo}
      alias Rv2.Main.{Email}
      alias Ecto.{Changeset}

      @doc """
      Returns the list of emails.

      ## Examples

          iex> list_emails()
          [%Email{}, ...]

      """
      def list_emails do
        Repo.all(Email)
      end

      @doc """
      Gets a single email.

      Raises `Ecto.NoResultsError` if the Email does not exist.

      ## Examples

          iex> get_email!(123)
          %Email{}

          iex> get_email!(456)
          ** (Ecto.NoResultsError)

      """

      def get_email!(id), do: Repo.get!(Email, id)

      @doc """
      Gets a single email.

      Returns nil if not exists

      ## Examples

          iex> get_email(123)
          %Email{}

          iex> get_email(456)
          nil

      """

      def get_email(id), do: Repo.get(Email, id)

      @doc """
      Creates a email.

      ## Examples

          iex> create_email(%{field: value})
          {:ok, %Email{}}

          iex> create_email(%{field: bad_value})
          {:error, %Ecto.Changeset{}}

      """
      def create_email(attrs \\ %{}) do
        %Email{}
        |> Email.changeset(attrs)
        |> Repo.insert()
      end

      @doc """
      Returns an `%Ecto.Changeset{}` for tracking email changes.

      ## Examples

          iex> change_email(email)
          %Ecto.Changeset{source: %Email{}}

      """
      def change_email(%Email{} = email) do
        Email.changeset(email, %{})
      end

    end
  end
end
