defmodule Rv2.Accounts do
  @moduledoc """
  The Accounts context.
  """
  import Ecto.Query, warn: false
  alias Rv2.{Accounts}

  # Import modules below
  use Accounts.CacheAPI
  use Accounts.UserAPI

end
