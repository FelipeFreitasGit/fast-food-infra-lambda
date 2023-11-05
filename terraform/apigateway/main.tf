resource "aws_api_gateway_rest_api" "api_fast_food" {
  name        = "MyAPI"
  description = "Minha API Gateway"
}

# /cliente

resource "aws_api_gateway_resource" "cliente" {
  rest_api_id = aws_api_gateway_rest_api.api_fast_food.id
  parent_id   = aws_api_gateway_rest_api.api_fast_food.root_resource_id
  path_part   = "cliente"
}

resource "aws_api_gateway_method" "cadastrar_cliente" {
  rest_api_id = aws_api_gateway_rest_api.api_fast_food.id
  resource_id = aws_api_gateway_resource.cliente.id
  http_method = "POST"
  authorization = "CUSTOM"
  authorizer_id = aws_api_gateway_authorizer.custom.id
}

resource "aws_api_gateway_integration" "cadastrar_cliente" {
  rest_api_id             = aws_api_gateway_rest_api.api_fast_food.id
  resource_id             = aws_api_gateway_resource.cliente.id
  http_method             = aws_api_gateway_method.cadastrar_cliente.http_method
  integration_http_method = "POST"
  type                    = "HTTP_PROXY"
  uri                     = "https://api.github.com/users/FelipeFreitasGit/repos"
}

# /cliente?cpf=55568254970

resource "aws_api_gateway_method" "busca_cliente" {
  rest_api_id = aws_api_gateway_rest_api.api_fast_food.id
  resource_id = aws_api_gateway_resource.cliente.id
  http_method = "GET"
  authorization = "CUSTOM"
  authorizer_id = aws_api_gateway_authorizer.custom.id
  request_parameters = {
    "method.request.querystring.cpf" = true
  }
}

resource "aws_api_gateway_integration" "busca_cliente" {
  rest_api_id             = aws_api_gateway_rest_api.api_fast_food.id
  resource_id             = aws_api_gateway_resource.cliente.id
  http_method             = aws_api_gateway_method.busca_cliente.http_method
  integration_http_method = "GET"
  type                    = "HTTP_PROXY"
  uri                     = "https://api.github.com/users/FelipeFreitasGit/repos"
}

# /autenticar?cpf=55568254970

resource "aws_api_gateway_resource" "autenticar" {
  rest_api_id = aws_api_gateway_rest_api.api_fast_food.id
  parent_id   = aws_api_gateway_rest_api.api_fast_food.root_resource_id
  path_part   = "autenticar"
}

resource "aws_api_gateway_method" "autenticar_cliente" {
  rest_api_id = aws_api_gateway_rest_api.api_fast_food.id
  resource_id = aws_api_gateway_resource.autenticar.id
  http_method = "GET"
  authorization = "NONE"
  request_parameters = {
    "method.request.querystring.cpf" = true
  }
}

resource "aws_api_gateway_integration" "autenticar_cliente" {
  rest_api_id             = aws_api_gateway_rest_api.api_fast_food.id
  resource_id             = aws_api_gateway_resource.autenticar.id
  http_method             = aws_api_gateway_method.autenticar_cliente.http_method
  integration_http_method = "GET"
  type                    = "HTTP_PROXY"
  uri                     = "https://api.github.com/users/FelipeFreitasGit/repos"
}

# /checkouts/webhook/pagar/{qrCodeId}

resource "aws_api_gateway_resource" "checkouts" {
  rest_api_id = aws_api_gateway_rest_api.api_fast_food.id
  parent_id   = aws_api_gateway_rest_api.api_fast_food.root_resource_id
  path_part   = "checkouts"
}

resource "aws_api_gateway_resource" "webhook" {
  rest_api_id = aws_api_gateway_rest_api.api_fast_food.id
  parent_id   = aws_api_gateway_resource.checkouts.id
  path_part   = "webhook"
}

resource "aws_api_gateway_resource" "pagar" {
  rest_api_id = aws_api_gateway_rest_api.api_fast_food.id
  parent_id   = aws_api_gateway_resource.webhook.id
  path_part   = "pagar"
}

resource "aws_api_gateway_resource" "checkouts_id" {
  rest_api_id = aws_api_gateway_rest_api.api_fast_food.id
  parent_id   = aws_api_gateway_resource.pagar.id
  path_part   = "{id+}"
}

resource "aws_api_gateway_method" "checkouts_id" {
  rest_api_id = aws_api_gateway_rest_api.api_fast_food.id
  resource_id = aws_api_gateway_resource.checkouts_id.id
  http_method = "PUT"
  authorization = "CUSTOM"
  authorizer_id = aws_api_gateway_authorizer.custom.id
}

resource "aws_api_gateway_integration" "checkouts_id" {
  rest_api_id             = aws_api_gateway_rest_api.api_fast_food.id
  resource_id             = aws_api_gateway_resource.checkouts_id.id
  http_method             = aws_api_gateway_method.checkouts_id.http_method
  integration_http_method = "PUT"
  type                    = "HTTP_PROXY"
  uri                     = "https://api.github.com/users/FelipeFreitasGit/repos"
}

# /pedidos/checkout

resource "aws_api_gateway_resource" "pedidos" {
  rest_api_id = aws_api_gateway_rest_api.api_fast_food.id
  parent_id   = aws_api_gateway_rest_api.api_fast_food.root_resource_id
  path_part   = "pedidos"
}

resource "aws_api_gateway_resource" "checkout" {
  rest_api_id = aws_api_gateway_rest_api.api_fast_food.id
  parent_id   = aws_api_gateway_resource.pedidos.id
  path_part   = "checkout"
}

resource "aws_api_gateway_method" "checkout" {
  rest_api_id = aws_api_gateway_rest_api.api_fast_food.id
  resource_id = aws_api_gateway_resource.checkout.id
  http_method = "POST"
  authorization = "CUSTOM"
  authorizer_id = aws_api_gateway_authorizer.custom.id
}

resource "aws_api_gateway_integration" "checkout" {
  rest_api_id             = aws_api_gateway_rest_api.api_fast_food.id
  resource_id             = aws_api_gateway_resource.checkout.id
  http_method             = aws_api_gateway_method.checkout.http_method
  integration_http_method = "POST"
  type                    = "HTTP_PROXY"
  uri                     = "https://api.github.com/users/FelipeFreitasGit/repos"
}

#/pedidos

resource "aws_api_gateway_method" "pedidos" {
  rest_api_id = aws_api_gateway_rest_api.api_fast_food.id
  resource_id = aws_api_gateway_resource.pedidos.id
  http_method = "GET"
  authorization = "CUSTOM"
  authorizer_id = aws_api_gateway_authorizer.custom.id
}

resource "aws_api_gateway_integration" "pedidos" {
  rest_api_id             = aws_api_gateway_rest_api.api_fast_food.id
  resource_id             = aws_api_gateway_resource.pedidos.id
  http_method             = aws_api_gateway_method.pedidos.http_method
  integration_http_method = "GET"
  type                    = "HTTP_PROXY"
  uri                     = "https://api.github.com/users/FelipeFreitasGit/repos"
}

#/pedidos/{id}

resource "aws_api_gateway_resource" "pedidos_id" {
  rest_api_id = aws_api_gateway_rest_api.api_fast_food.id
  parent_id   = aws_api_gateway_resource.pedidos.id
  path_part   = "{id+}"
}

resource "aws_api_gateway_method" "pedidos_id" {
  rest_api_id = aws_api_gateway_rest_api.api_fast_food.id
  resource_id = aws_api_gateway_resource.pedidos_id.id
  http_method = "GET"
  authorization = "CUSTOM"
  authorizer_id = aws_api_gateway_authorizer.custom.id
}

resource "aws_api_gateway_integration" "pedidos_id" {
  rest_api_id             = aws_api_gateway_rest_api.api_fast_food.id
  resource_id             = aws_api_gateway_resource.pedidos_id.id
  http_method             = aws_api_gateway_method.pedidos_id.http_method
  integration_http_method = "GET"
  type                    = "HTTP_PROXY"
  uri                     = "https://api.github.com/users/FelipeFreitasGit/repos"
}

# /pedidos/status/{id}

resource "aws_api_gateway_resource" "status" {
  rest_api_id = aws_api_gateway_rest_api.api_fast_food.id
  parent_id   = aws_api_gateway_resource.pedidos.id
  path_part   = "status"
}

resource "aws_api_gateway_resource" "status_id" {
  rest_api_id = aws_api_gateway_rest_api.api_fast_food.id
  parent_id   = aws_api_gateway_resource.status.id
  path_part   = "{id+}"
}

resource "aws_api_gateway_method" "status_id" {
  rest_api_id = aws_api_gateway_rest_api.api_fast_food.id
  resource_id = aws_api_gateway_resource.status_id.id
  http_method = "GET"
  authorization = "CUSTOM"
  authorizer_id = aws_api_gateway_authorizer.custom.id
}

resource "aws_api_gateway_integration" "status_id" {
  rest_api_id             = aws_api_gateway_rest_api.api_fast_food.id
  resource_id             = aws_api_gateway_resource.status_id.id
  http_method             = aws_api_gateway_method.status_id.http_method
  integration_http_method = "GET"
  type                    = "HTTP_PROXY"
  uri                     = "https://api.github.com/users/FelipeFreitasGit/repos"
}

# pedidos/mudar-status/preparacao/{id}

resource "aws_api_gateway_resource" "mudar_status" {
  rest_api_id = aws_api_gateway_rest_api.api_fast_food.id
  parent_id   = aws_api_gateway_resource.pedidos.id
  path_part   = "mudar-status"
}

resource "aws_api_gateway_resource" "preparacao" {
  rest_api_id = aws_api_gateway_rest_api.api_fast_food.id
  parent_id   = aws_api_gateway_resource.mudar_status.id
  path_part   = "preparacao"
}

resource "aws_api_gateway_resource" "preparacao_id" {
  rest_api_id = aws_api_gateway_rest_api.api_fast_food.id
  parent_id   = aws_api_gateway_resource.preparacao.id
  path_part   = "{id+}"
}

resource "aws_api_gateway_method" "preparacao_id" {
  rest_api_id = aws_api_gateway_rest_api.api_fast_food.id
  resource_id = aws_api_gateway_resource.preparacao_id.id
  http_method = "PUT"
  authorization = "CUSTOM"
  authorizer_id = aws_api_gateway_authorizer.custom.id
}

resource "aws_api_gateway_integration" "preparacao_id" {
  rest_api_id             = aws_api_gateway_rest_api.api_fast_food.id
  resource_id             = aws_api_gateway_resource.preparacao_id.id
  http_method             = aws_api_gateway_method.preparacao_id.http_method
  integration_http_method = "PUT"
  type                    = "HTTP_PROXY"
  uri                     = "https://api.github.com/users/FelipeFreitasGit/repos"
}

# pedidos/mudar-status/pronto/{id}

resource "aws_api_gateway_resource" "pronto" {
  rest_api_id = aws_api_gateway_rest_api.api_fast_food.id
  parent_id   = aws_api_gateway_resource.mudar_status.id
  path_part   = "pronto"
}

resource "aws_api_gateway_resource" "pronto_id" {
  rest_api_id = aws_api_gateway_rest_api.api_fast_food.id
  parent_id   = aws_api_gateway_resource.pronto.id
  path_part   = "{id+}"
}

resource "aws_api_gateway_method" "pronto_id" {
  rest_api_id = aws_api_gateway_rest_api.api_fast_food.id
  resource_id = aws_api_gateway_resource.pronto_id.id
  http_method = "PUT"
  authorization = "CUSTOM"
  authorizer_id = aws_api_gateway_authorizer.custom.id
}

resource "aws_api_gateway_integration" "pronto_id" {
  rest_api_id             = aws_api_gateway_rest_api.api_fast_food.id
  resource_id             = aws_api_gateway_resource.pronto_id.id
  http_method             = aws_api_gateway_method.pronto_id.http_method
  integration_http_method = "PUT"
  type                    = "HTTP_PROXY"
  uri                     = "https://api.github.com/users/FelipeFreitasGit/repos"
}

# pedidos/mudar-status/confirmar-entrega/{id}

resource "aws_api_gateway_resource" "confirmar_entrega" {
  rest_api_id = aws_api_gateway_rest_api.api_fast_food.id
  parent_id   = aws_api_gateway_resource.mudar_status.id
  path_part   = "confirmar-entrega"
}

resource "aws_api_gateway_resource" "confirmar_entrega_id" {
  rest_api_id = aws_api_gateway_rest_api.api_fast_food.id
  parent_id   = aws_api_gateway_resource.confirmar_entrega.id
  path_part   = "{id+}"
}

resource "aws_api_gateway_method" "confirmar_entrega_id" {
  rest_api_id = aws_api_gateway_rest_api.api_fast_food.id
  resource_id = aws_api_gateway_resource.confirmar_entrega_id.id
  http_method = "PUT"
  authorization = "CUSTOM"
  authorizer_id = aws_api_gateway_authorizer.custom.id
}

resource "aws_api_gateway_integration" "confirmar_entrega_id" {
  rest_api_id             = aws_api_gateway_rest_api.api_fast_food.id
  resource_id             = aws_api_gateway_resource.confirmar_entrega_id.id
  http_method             = aws_api_gateway_method.confirmar_entrega_id.http_method
  integration_http_method = "PUT"
  type                    = "HTTP_PROXY"
  uri                     = "https://api.github.com/users/FelipeFreitasGit/repos"
}

# /produto

resource "aws_api_gateway_resource" "produto" {
  rest_api_id = aws_api_gateway_rest_api.api_fast_food.id
  parent_id   = aws_api_gateway_rest_api.api_fast_food.root_resource_id
  path_part   = "produto"
}

resource "aws_api_gateway_method" "produto" {
  rest_api_id = aws_api_gateway_rest_api.api_fast_food.id
  resource_id = aws_api_gateway_resource.produto.id
  http_method = "POST"
  authorization = "CUSTOM"
  authorizer_id = aws_api_gateway_authorizer.custom.id
}

resource "aws_api_gateway_integration" "produto" {
  rest_api_id             = aws_api_gateway_rest_api.api_fast_food.id
  resource_id             = aws_api_gateway_resource.produto.id
  http_method             = aws_api_gateway_method.produto.http_method
  integration_http_method = "POST"
  type                    = "HTTP_PROXY"
  uri                     = "https://api.github.com/users/FelipeFreitasGit/repos"
}

# /produto/{id}

resource "aws_api_gateway_resource" "produto_id" {
  rest_api_id = aws_api_gateway_rest_api.api_fast_food.id
  parent_id   = aws_api_gateway_resource.produto.id
  path_part   = "{id+}"
}

resource "aws_api_gateway_method" "produto_id" {
  rest_api_id = aws_api_gateway_rest_api.api_fast_food.id
  resource_id = aws_api_gateway_resource.produto_id.id
  http_method = "PUT"
  authorization = "CUSTOM"
  authorizer_id = aws_api_gateway_authorizer.custom.id
}

resource "aws_api_gateway_integration" "produto_id" {
  rest_api_id             = aws_api_gateway_rest_api.api_fast_food.id
  resource_id             = aws_api_gateway_resource.produto_id.id
  http_method             = aws_api_gateway_method.produto_id.http_method
  integration_http_method = "PUT"
  type                    = "HTTP_PROXY"
  uri                     = "https://api.github.com/users/FelipeFreitasGit/repos"
}

resource "aws_api_gateway_resource" "deleta_produto_id" {
  rest_api_id = aws_api_gateway_rest_api.api_fast_food.id
  parent_id   = aws_api_gateway_resource.produto.id
  path_part   = "{id+}"
}

resource "aws_api_gateway_method" "deleta_produto_id" {
  rest_api_id = aws_api_gateway_rest_api.api_fast_food.id
  resource_id = aws_api_gateway_resource.deleta_produto_id.id
  http_method = "DELETE"
  authorization = "CUSTOM"
  authorizer_id = aws_api_gateway_authorizer.custom.id
}

resource "aws_api_gateway_integration" "deleta_produto_id" {
  rest_api_id             = aws_api_gateway_rest_api.api_fast_food.id
  resource_id             = aws_api_gateway_resource.deleta_produto_id.id
  http_method             = aws_api_gateway_method.deleta_produto_id.http_method
  integration_http_method = "DELETE"
  type                    = "HTTP_PROXY"
  uri                     = "https://api.github.com/users/FelipeFreitasGit/repos"
}

# /produto/categoria

resource "aws_api_gateway_resource" "categoria" {
  rest_api_id = aws_api_gateway_rest_api.api_fast_food.id
  parent_id   = aws_api_gateway_resource.produto.id
  path_part   = "categoria"
}

resource "aws_api_gateway_method" "categoria" {
  rest_api_id = aws_api_gateway_rest_api.api_fast_food.id
  resource_id = aws_api_gateway_resource.categoria.id
  http_method = "GET"
  authorization = "CUSTOM"
  authorizer_id = aws_api_gateway_authorizer.custom.id
}

resource "aws_api_gateway_integration" "categoria" {
  rest_api_id             = aws_api_gateway_rest_api.api_fast_food.id
  resource_id             = aws_api_gateway_resource.categoria.id
  http_method             = aws_api_gateway_method.categoria.http_method
  integration_http_method = "GET"
  type                    = "HTTP_PROXY"
  uri                     = "https://api.github.com/users/FelipeFreitasGit/repos"
}

resource "aws_api_gateway_deployment" "api_fast_food_deployment" {
  depends_on = [
    aws_api_gateway_method.cadastrar_cliente,
    aws_api_gateway_integration.cadastrar_cliente,

    aws_api_gateway_method.busca_cliente,
    aws_api_gateway_integration.busca_cliente,

    aws_api_gateway_method.autenticar_cliente,
    aws_api_gateway_integration.autenticar_cliente,

    aws_api_gateway_method.checkouts_id,
    aws_api_gateway_integration.checkouts_id,

    aws_api_gateway_method.checkout,
    aws_api_gateway_integration.checkout,

    aws_api_gateway_method.pedidos,
    aws_api_gateway_integration.pedidos,

    aws_api_gateway_method.pedidos_id,
    aws_api_gateway_integration.pedidos_id,

    aws_api_gateway_method.status_id,
    aws_api_gateway_integration.status_id,

    aws_api_gateway_method.preparacao_id,
    aws_api_gateway_integration.preparacao_id,

    aws_api_gateway_method.pronto_id,
    aws_api_gateway_integration.pronto_id,

    aws_api_gateway_method.confirmar_entrega_id,
    aws_api_gateway_integration.confirmar_entrega_id,

    aws_api_gateway_method.produto,
    aws_api_gateway_integration.produto,

    aws_api_gateway_method.produto_id,
    aws_api_gateway_integration.produto_id,

    aws_api_gateway_method.deleta_produto_id,
    aws_api_gateway_integration.deleta_produto_id,

    aws_api_gateway_method.categoria,
    aws_api_gateway_integration.categoria,
    ]
  rest_api_id = aws_api_gateway_rest_api.api_fast_food.id
  stage_name = "dev"
}

resource "aws_api_gateway_authorizer" "custom" {
  name                   = "custom-authorizer"
  rest_api_id            = aws_api_gateway_rest_api.api_fast_food.id
  authorizer_uri         = var.lambda_authorizadora_invokearn
  type                             = "REQUEST"
  identity_source                  = "method.request.header.Authorization"
  authorizer_result_ttl_in_seconds = 0
}