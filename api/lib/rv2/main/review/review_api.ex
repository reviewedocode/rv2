defmodule Rv2.Main.ReviewAPI do
  @moduledoc """
  Provides an API for all functions relating to review signups
  """
  defmacro __using__(_) do
    quote do

      alias Rv2.{Repo}
      alias Rv2.Main.{Review}
      alias Ecto.{Changeset}

      @doc """
      Returns the list of reviews.

      ## Examples

          iex> list_reviews()
          [%Review{}, ...]

      """
      def list_reviews do
        Repo.all(Review)
      end

      @doc """
      Gets a single review.

      Raises `Ecto.NoResultsError` if the Review does not exist.

      ## Examples

          iex> get_review!(123)
          %Review{}

          iex> get_review!(456)
          ** (Ecto.NoResultsError)

      """

      def get_review!(id), do: Repo.get!(Review, id)

      @doc """
      Gets a single review.

      Returns nil if not exists

      ## Examples

          iex> get_review(123)
          %Review{}

          iex> get_review(456)
          nil

      """

      def get_review(id), do: Repo.get(Review, id)

      @doc """
      Creates a review.

      ## Examples

          iex> create_review(%{field: value})
          {:ok, %Review{}}

          iex> create_review(%{field: bad_value})
          {:error, %Ecto.Changeset{}}

      """
      def create_review(company, user, attrs \\ %{}) do
        %Review{}
        |> Review.changeset(attrs)
        |> Changeset.put_assoc(:company, company)
        |> Changeset.put_assoc(:user, user)
        |> Repo.insert()
      end

      @doc """
      Returns an `%Ecto.Changeset{}` for tracking review changes.

      ## Examples

          iex> change_review(review)
          %Ecto.Changeset{source: %Review{}}

      """
      def change_review(%Review{} = review) do
        Review.changeset(review, %{})
      end

    end
  end
end
