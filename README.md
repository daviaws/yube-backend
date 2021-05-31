# Benefits

## Especificações Benefits: Collaborator (Application 1):

Feature 1:
**GET Colaborador Index**
Lista de colaboradores 200.
* Se nenhum: lista vazia.

---

Feature 2:
**GET Colaborador:id**
Se existir 200:
  * Mapa com todos os atributos do colaborador incluindo id.
  * Não inclui timestamps.
Se não existir 404:
  * Not Found

---

Feature 3:
**POST Colaborador (create)**
{
  name: name,
  surname: surname,
  cpf: cpf,
  image: image
}

**Validações:**
1. Nome:
  1. Deve ter no mínimo 3 caracteres
  2. Requerido e não pode vir em branco.

2. Sobrenome:
  1. Deve ter no mínimo 3 caracteres
  2. Requerido e não pode vir em branco.

3. CPF
  1. Validar formato (Brcpfcnpj)
  2. Requerido e não pode vir em branco.
  3. Validar unicidade.

4. Imagem (url)
  Sem validações.

5. Benefício
  1. Validar formato (enum).
  2. Requerido e não pode vir em branco.  

Estados:
* Requisição com sucesso: 201
* Conflito na criação (ex: 3.3): 409
* Qualquer erro de validação 400
 

Especificações Adicionais:
* Dependentes (cast_assoc/3)

---

## Dependencies
* docker == 19.03.6
* docker-compose == 1.29.2
* IEx == 1.11.2 (asdf manager recommended)
* Erlang/OTP == 23

---

## Build
To build the project:
  * Give permission to build script `chmod +x script/build`
  * Run the build script to setup docker `script/build`

---

## Run on Docker
To run everything on Docker:
  * Run `docker-compose up -d`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

---

## Run local Phoenix
To start your Phoenix server locally:
  * Add to `/etc/hosts` the alias to local host `127.0.0.1    db`
  * Run the database docker `docker-compose up -d postgres`
  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

---

### Know Issues:
 * When setup is made on docker I had conflict trying to run locally afterward.
 * Same occurred when I tryied to start locally then running dockerized.
 - Quickfix: **rm \_build** directory
