defmodule Benefits.CollaboratorFactory do
  @moduledoc false

  alias Benefits.Request.Collaborator

  defmacro __using__(_opts) do
    quote do
      def collaborator_factory do
        %Collaborator{
          name: Faker.Person.PtBr.first_name(),
          surname: Faker.Person.PtBr.last_name(),
          cpf: Brcpfcnpj.cpf_generate,
          image: Faker.Internet.image_url()
        }
      end
    end
  end
end
