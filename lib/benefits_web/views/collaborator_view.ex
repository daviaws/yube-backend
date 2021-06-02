defmodule BenefitsWeb.CollaboratorView do
  use BenefitsWeb, :view
  alias BenefitsWeb.CollaboratorView

  def render("index.json", %{collaborators: collaborators}) do
    %{data: render_many(collaborators, CollaboratorView, "collaborator.json")}
  end

  def render("show.json", %{collaborator: collaborator}) do
    %{data: render_one(collaborator, CollaboratorView, "collaborator.json")}
  end

  def render("collaborator.json", %{collaborator: collaborator}) do
    %{
      id: collaborator.id,
      name: collaborator.name,
      surname: collaborator.surname,
      cpf: collaborator.cpf,
      image: collaborator.image,
      benefit: collaborator.benefit
    }
  end
end
