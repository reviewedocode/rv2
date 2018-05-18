defmodule Reviewedo.Main do
  @moduledoc """
  The Main context.
  """

  import Ecto.Query, warn: false
  alias Reviewedo.{Main}

  # Import modules below
  use Main.EmailAPI
  use Main.CompanyAPI
  use Main.ReviewAPI
end
