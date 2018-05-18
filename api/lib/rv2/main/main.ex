defmodule Rv2.Main do
  @moduledoc """
  The Main context.
  """

  import Ecto.Query, warn: false
  alias Rv2.{Main}

  # Import modules below
  use Main.EmailAPI
  use Main.CompanyAPI
  use Main.ReviewAPI
end
