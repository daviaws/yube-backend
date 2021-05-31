defmodule Benefits.RequestTest do
  use Benefits.DataCase

  alias Benefits.Request

  import Benefits.Factory

  @invalid_params %{name: "", surname: "", cpf: "", image: ""}

  describe "collaborators" do
    alias Benefits.Request.Collaborator

    test "list_collaborators/0 returns all collaborators" do
      collaborators = insert_list(2, :collaborator)

      assert Request.list_collaborators() == collaborators
    end

    test "get_collaborator!/1 returns the collaborator with given id" do
      collaborator = insert(:collaborator)

      assert Request.get_collaborator!(collaborator.id) == collaborator
    end

    test "create_collaborator/1 with valid data creates a collaborator" do
      params = params_for(:collaborator)

      assert {:ok, %Collaborator{} = collaborator} = Request.create_collaborator(params)

      assert collaborator.cpf == params.cpf
      assert collaborator.image == params.image
      assert collaborator.name == params.name
      assert collaborator.surname == params.surname
    end

    test "create_collaborator/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Request.create_collaborator(@invalid_params)
    end

    test "update_collaborator/2 with valid data updates the collaborator" do
      collaborator = insert(:collaborator)

      update_params = params_for(:collaborator)

      assert {:ok, %Collaborator{} = updated} = Request.update_collaborator(collaborator, update_params)

      assert updated.cpf == update_params.cpf
      assert updated.image == update_params.image
      assert updated.name == update_params.name
      assert updated.surname == update_params.surname
    end

    test "update_collaborator/2 with invalid data returns error changeset" do
      collaborator = insert(:collaborator)

      assert {:error, %Ecto.Changeset{}} = Request.update_collaborator(collaborator, @invalid_params)

      assert collaborator == Request.get_collaborator!(collaborator.id)
    end
  end
end
