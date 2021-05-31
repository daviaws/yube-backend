defmodule Benefits.Request do
  @moduledoc """
  The Request context.
  """

  import Ecto.Query, warn: false
  alias Benefits.Repo

  alias Benefits.Request.Collaborator

  @doc """
  Returns the list of collaborators.

  ## Examples

      iex> list_collaborators()
      [%Collaborator{}, ...]

  """
  def list_collaborators do
    Repo.all(Collaborator)
  end

  @doc """
  Gets a single collaborator.

  ## Examples

      iex> get_collaborator(existent_id)
      {:ok, %Collaborator{}}

      iex> get_collaborator(inexistent_id)
      {:error, :not_found}

  """
  def get_collaborator(id) do
    case Repo.get(Collaborator, id) do
      %Collaborator{} = collaborator -> {:ok, collaborator}

      nil -> {:error, :not_found}
    end
  end

  @doc """
  Creates a collaborator.

  ## Examples

      iex> create_collaborator(%{field: value})
      {:ok, %Collaborator{}}

      iex> create_collaborator(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_collaborator(attrs \\ %{}) do
    %Collaborator{}
    |> Collaborator.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a collaborator.

  ## Examples

      iex> update_collaborator(collaborator, %{field: new_value})
      {:ok, %Collaborator{}}

      iex> update_collaborator(collaborator, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_collaborator(%Collaborator{} = collaborator, attrs) do
    collaborator
    |> Collaborator.changeset(attrs)
    |> Repo.update()
  end
end
