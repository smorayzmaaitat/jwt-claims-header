local jwt_parser = require("kong.plugins.jwt.jwt_parser")

local plugin = {
  PRIORITY = 10,
  VERSION  = "1.0.0",
}

function plugin:access(conf)
  local auth = kong.request.get_header("authorization")
  if not auth then
    kong.log.debug("No Authorization header found")
    return
  end

  -- Match "Bearer <token>"
  local token = auth:match("Bearer%s+(.+)")
  if not token then
    kong.log.debug("No Bearer token format matched")
    return
  end

  -- Try to decode the JWT
  local jwt = jwt_parser:new(token)
  if not jwt or not jwt.claims then
    kong.log.debug("Failed to parse JWT or missing claims")
    return
  end

  -- Get the 'sub' claim
  local user_id = jwt.claims.sub
  if not user_id then
    kong.log.debug("No 'sub' claim found in token")
    return
  end

  -- Determine header name
  local header_name = conf.header_name or "X-User-Id"

  -- Set the header
  kong.service.request.set_header(header_name, user_id)
  kong.log.debug("Set header ", header_name, " = ", user_id)
end

return plugin
