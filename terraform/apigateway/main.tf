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

# /pedidos

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