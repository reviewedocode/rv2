defmodule Rv2Web.UserController do
  use Rv2Web, :controller

  alias Rv2.{Accounts, Email}

  def create(conn, %{"user" => user_params}) do
    case Accounts.create_user(user_params) do
      {:ok, user} ->
        Email.send_verification_email(user)
        new_conn = Guardian.Plug.api_sign_in(conn, user, :access)
        jwt = Guardian.Plug.current_token(new_conn)

        new_conn
        |> put_status(:created)
        |> render(Rv2.SessionView, "show.json", user: user, jwt: jwt)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Rv2.ChangesetView, "error.json", changeset: changeset)
    end
  end
end
