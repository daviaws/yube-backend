defmodule BenefitsWeb.CollaboratorControllerTest do
  use BenefitsWeb.ConnCase

  import Benefits.Factory

  @collaborator_view_fields [:id, :cpf, :image, :name, :surname, :benefit]
  defp struct_to_map(struct, select) do
    struct
    |> Map.from_struct()
    |> Map.take(select)
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists none collaborators", %{conn: conn} do
      conn = conn |> get(Routes.collaborator_path(conn, :index))

      assert json_response(conn, 200)["data"] == []
    end

    test "lists all collaborators", %{conn: conn} do
      [collaborator1, collaborator2] = insert_list(2, :collaborator, benefit: "a")

      conn = conn |> get(Routes.collaborator_path(conn, :index))

      assert response = json_response(conn, 200)["data"] |> Enum.map(&Benefits.Helper.Map.atomize_keys/1)

      assert response == [
               collaborator1 |> struct_to_map(@collaborator_view_fields) |> Map.put(:benefit, Atom.to_string(collaborator1.benefit)),
               collaborator2 |> struct_to_map(@collaborator_view_fields) |> Map.put(:benefit, Atom.to_string(collaborator1.benefit))
             ]
    end
  end

  describe "show collaborator" do
    test "renders collaborator when data is valid", %{conn: conn} do
      collaborator = insert(:collaborator)

      conn = conn |> get(Routes.collaborator_path(conn, :show, collaborator.id))

      assert response = json_response(conn, 200)["data"] |> Benefits.Helper.Map.atomize_keys()

      assert response == collaborator |> struct_to_map(@collaborator_view_fields) |> Map.put(:benefit, Atom.to_string(collaborator.benefit))
    end

    test "renders 404 when collaborator not exist", %{conn: conn} do
      surely_invalid_id = 1

      conn = conn |> get(Routes.collaborator_path(conn, :show, surely_invalid_id))

      assert "Not Found" == json_response(conn, 404)
    end
  end

  describe "create collaborator" do
    test "renders collaborator when data is valid", %{conn: conn} do
      attrs = params_for(:collaborator)

      conn = post(conn, Routes.collaborator_path(conn, :create), collaborator: attrs)

      assert %{id: id} = response = json_response(conn, 201)["data"] |> Benefits.Helper.Map.atomize_keys()

      assert response == Map.put(attrs, :id, id)
    end

    test "renders errors when is not a cpf", %{conn: conn} do
      attrs = params_for(:collaborator, cpf: "123")

      conn = post(conn, Routes.collaborator_path(conn, :create), collaborator: attrs)

      assert %{"cpf" => ["Invalid Cpf"]} == json_response(conn, 400)["errors"]
    end

    test "renders errors when is cpf duplicate", %{conn: conn} do
      attrs = params_for(:collaborator)

      post(conn, Routes.collaborator_path(conn, :create), collaborator: attrs)
      conn = post(conn, Routes.collaborator_path(conn, :create), collaborator: attrs)

      assert %{"cpf" => ["has already been taken"]} == json_response(conn, 409)["errors"]
    end

    test "renders errors when name is lesser than 3 characteres", %{conn: conn} do
      attrs = params_for(:collaborator, name: "Al")

      conn = post(conn, Routes.collaborator_path(conn, :create), collaborator: attrs)

      assert %{"name" => ["should be at least 3 character(s)"]} == json_response(conn, 400)["errors"]
    end

    test "renders errors when surname is lesser than 3 characteres", %{conn: conn} do
      attrs = params_for(:collaborator, surname: "Al")

      conn = post(conn, Routes.collaborator_path(conn, :create), collaborator: attrs)

      assert %{"surname" => ["should be at least 3 character(s)"]} == json_response(conn, 400)["errors"]
    end

    test "renders errors when attrs is blank", %{conn: conn} do
      conn = post(conn, Routes.collaborator_path(conn, :create), collaborator: %{})

      assert %{
        "cpf" => ["can't be blank"],
        "name" => ["can't be blank"],
        "surname" => ["can't be blank"],
        "benefit" => ["can't be blank"]
      } == json_response(conn, 400)["errors"]
    end
  end

  # describe "update collaborator" do
  #   setup [:create_collaborator]

  #   test "renders collaborator when data is valid", %{conn: conn, collaborator: %Collaborator{id: id} = collaborator} do
  #     conn = put(conn, Routes.collaborator_path(conn, :update, collaborator), collaborator: @update_attrs)
  #     assert %{"id" => ^id} = json_response(conn, 200)["data"]

  #     conn = get(conn, Routes.collaborator_path(conn, :show, id))

  #     assert %{
  #              "id" => id,
  #              "cpf" => "some updated cpf",
  #              "image" => "some updated image",
  #              "name" => "some updated name",
  #              "surname" => "some updated surname"
  #            } = json_response(conn, 200)["data"]
  #   end

  #   test "renders errors when data is invalid", %{conn: conn, collaborator: collaborator} do
  #     conn = put(conn, Routes.collaborator_path(conn, :update, collaborator), collaborator: @invalid_attrs)
  #     assert json_response(conn, 422)["errors"] != %{}
  #   end
  # end
end
