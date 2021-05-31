defmodule BenefitsWeb.CollaboratorController do
  use BenefitsWeb, :controller

  alias Benefits.Request
  alias Benefits.Request.Collaborator

  action_fallback BenefitsWeb.FallbackController

  def index(conn, _params) do
    collaborators = Request.list_collaborators()
    render(conn, "index.json", collaborators: collaborators)
  end

  def create(conn, %{"collaborator" => collaborator_params}) do
    with {:ok, %Collaborator{} = collaborator} <- Request.create_collaborator(collaborator_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.collaborator_path(conn, :show, collaborator))
      |> render("show.json", collaborator: collaborator)
    end
  end

  def show(conn, %{"id" => id}) do
    with {:ok, %Collaborator{} = collaborator} <- Request.get_collaborator(id) do
      conn
      |> put_status(:ok)
      |> render("show.json", collaborator: collaborator)
    end
  end

  def update(conn, %{"id" => id, "collaborator" => collaborator_params}) do
    with {:ok, %Collaborator{} = collaborator} <- Request.get_collaborator(id),
      {:ok, %Collaborator{} = updated} <- Request.update_collaborator(collaborator, collaborator_params) do
        render(conn, "show.json", collaborator: updated)
    end
  end
end
