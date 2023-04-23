# Books API

Este projeto foi realizado como desafio para integrar a equipe da Noz.

# Como iniciar o projeto!

Após clonar este projeto, abre-o no terminal e execute:

```bash

docker-compose up --build

```

*Executando este comando todos os services do `docker-compose.yml` irão subir.*

Para subir apenas o serviço web:

```bash

docker-compose up noz-books-api-web --build

```

# Documentação utilizando SWAGGER

Pode ser encontrada na seguinte rota: `/api-docs`

# Criando o JWT Token

Será necessario fazer um POST para a seguinte rota: `http://localhost:3000/api/v1/auth`

Passa o um email com o final `@noz.com.br`.

Exemplo de body para a requisição:

```json

{
	"email": "pedro.bandeira@noz.com.br"
}

```

E o retorno será assim:

```json

{
	"token": "eyJhbGciOiJIUzI1NiJ9.eyJlbWFpbCI6InBlZHJvLmJhbmRlaXJhQG5vei5jb20uYnIiLCJleHAiOjE2ODI4ODIxMzB9.BkHJTxAMMEmDhItIGKOwpyfceoEDbr1ntcVqxNtTR_M",
	"exp": "04-24-2023 19:15",
	"email": "pedro.bandeira@noz.com.br"
}

```

E para realizar suas requisições na aplicação basta adicionar: `Bearer TokenRetornadoNa.RequisicaoAcima` na header de Authorization

# Rotas

O projeto possui uma validação utilizando [JWT](https://jwt.io/).

Lista de rotas sem validação de **Token**:

- [GET] http://localhost:3000/api/v1/authors
- [GET] http://localhost:3000/api/v1/books/
- [GET] http://localhost:3000/api/v1/authors/#{author_id}
- [GET] http://localhost:3000/api/v1/books/#{book_id}

Lista de rotas com validação de **Token**:

- [DELETE] http://localhost:3000/api/v1/authors/#{author_id}
- [DELETE] http://localhost:3000/api/v1/authors/#{author_id}/books/#{book_id}
- [PUT][PATCH] http://localhost:3000/api/v1/authors/#{author_id}
- [PUT][PATCH] http://localhost:3000/api/v1/authors/#{author_id}/books/#{book_id}
- [POST] http://localhost:3000/api/v1/authors
- [POST] http://localhost:3000/api/v1/authors/#{author_id}/books


