local PLUGIN_NAME = "jwt-claims-header"

local schema = {
  name = PLUGIN_NAME,
  fields = {
    {
      config = {
        type = "record",
        fields = {
          {
            header_name = {
              type = "string",
              default = "X-User-Id",
              description = "The name of the header to inject the user ID into",
            },
          },
        },
      },
    },
  },
}

return schema
