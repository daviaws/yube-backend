defmodule Benefits.Factory do
  @moduledoc """
  Configure test factories.
  """

  use ExMachina.Ecto, repo: Benefits.Repo

  use Benefits.CollaboratorFactory
end
