defmodule BenefitsWeb.FallbackController do
  @moduledoc """
  Translates controller action results into valid `Plug.Conn` responses.

  See `Phoenix.Controller.action_fallback/1` for more details.
  """
  use BenefitsWeb, :controller

    # ToDo:
  # There is another possible way to do this.
  # http://joshwlewis.com/essays/elixir-error-handling-with-plug/
  # The tutorial says: It seems to work well with Ecto.Errors for instance
  def map_status(changeset) do
    case BenefitsWeb.ChangesetView.translate_errors(changeset) do
      %{cpf: ["has already been taken"]} -> :conflict
      _ -> :bad_request
    end
  end

  # This clause handles errors returned by Ecto's insert/update/delete.
  def call(conn, {:error, %Ecto.Changeset{} = changeset}) do
    conn
    |> put_status(map_status(changeset))
    |> put_view(BenefitsWeb.ChangesetView)
    |> render("error.json", changeset: changeset)
  end

  # This clause is an example of how to handle resources that cannot be found.
  def call(conn, {:error, :not_found}) do
    conn
    |> put_status(:not_found)
    |> put_view(BenefitsWeb.ErrorView)
    |> render(:"404")
  end
end
