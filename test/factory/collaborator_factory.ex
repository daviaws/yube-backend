defmodule Benefits.CollaboratorFactory do
  @moduledoc false

  alias Benefits.Request.Collaborator
  alias Benefits.Helper.EctoEnum

  defmacro __using__(_opts) do
    quote do
      def collaborator_factory do
        %Collaborator{
          name: Faker.Person.PtBr.first_name(),
          surname: " " <> Faker.Person.PtBr.last_name(), #the first space is to ensure at least 3 characteres on output
          cpf: Brcpfcnpj.cpf_generate,
          image: Faker.Internet.image_url(),
          benefit: Benefits.Helper.EctoEnum.random_string_value(BenefitsEnum)
        }
      end
    end
  end
end
