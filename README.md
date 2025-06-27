# jwt-claims-header
This custom Kong plugin extracts the sub claim from a JWT in the Authorization header and adds it to the upstream request as a configurable header (default: X-User-Id). Useful for passing authenticated user IDs to backend services.
