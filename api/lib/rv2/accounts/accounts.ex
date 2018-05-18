defmodule Reviewedo.Accounts do
  @moduledoc """
  The Accounts context.
  """
  import Ecto.Query, warn: false
  alias Reviewedo.{Accounts}

  # Import modules below
  use Accounts.CacheAPI
  use Accounts.UserAPI

end
