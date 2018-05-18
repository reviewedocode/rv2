defmodule Reviewedo.Main.CompanyAPI do
  @moduledoc """
  Provides an API for all functions relating to companies
  """
  defmacro __using__(_) do
    quote do

      alias Reviewedo.{Repo}
      alias Reviewedo.Main.{Company}
      alias Ecto.{Changeset}

      @doc """
      Returns the list of companies.

      ## Examples

          iex> list_companies()
          [%Company{}, ...]

      """
      def list_companies do
        Repo.all(Company)
      end

      def list_companies(search_term) do
        name_query = from c in Company, where: ilike(c.name, ^"%#{search_term}%")
        overview_query = from c in Company, where: ilike(c.overview, ^"%#{search_term}%")
        location_query = from c in Company, where: ilike(c.location, ^"%#{search_term}%")
        industry_query = from c in Company, where: ilike(c.industry, ^"%#{search_term}%")
        companies_by_name = search_by(name_query)
        companies_by_overview = search_by(overview_query)
        companies_by_location = search_by(location_query)
        companies_by_industry = search_by(industry_query)
        companies_by_name
        ++ companies_by_overview
        ++ companies_by_location
        ++ companies_by_industry
        |> Enum.uniq()
      end

      defp search_by(query) do
        query
        |> Repo.all()
        |> Repo.preload(:reviews)
      end

      @doc """
      Gets a single company.

      Raises `Ecto.NoResultsError` if the Company does not exist.

      ## Examples

          iex> get_company!(123)
          %Company{}

          iex> get_company!(456)
          ** (Ecto.NoResultsError)

      """

      def get_company!(id), do: Repo.get!(Company, id)

      @doc """
      Gets a single company.

      Returns nil if not exists

      ## Examples

          iex> get_company(123)
          %Company{}

          iex> get_company(456)
          nil

      """

      def get_company(id) do
        [rand_string | _tail] = String.split(id, "-")
        Company
        |> Repo.get_by(rand_string: rand_string)
        |> Repo.preload([reviews: :user])
      end

      @doc """
      Creates a company.

      ## Examples

          iex> create_company(%{field: value})
          {:ok, %Company{}}

          iex> create_company(%{field: bad_value})
          {:error, %Ecto.Changeset{}}

      """
      def create_company(attrs \\ %{}) do
        %Company{}
        |> Company.changeset(attrs)
        |> Repo.insert()
      end

      @doc """
      Returns an `%Ecto.Changeset{}` for tracking company changes.

      ## Examples

          iex> change_company(company)
          %Ecto.Changeset{source: %Company{}}

      """
      def change_company(%Company{} = company) do
        Company.changeset(company, %{})
      end

    end
  end
end
