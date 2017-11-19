# isso-formula
Formula for the isso commenting server (https://posativ.org/isso/).

See the full [Salt Formulas installation and usage instructions](http://docs.saltstack.com/en/latest/topics/development/conventions/formulas.html).

## Available states
### `isso.install`
Installs the isso commenting server.

Example pillar:

```
isso:
  user: deploy
  path: /apps/isso
  config:
    general:
      dbpath: /apps/isso/comments.db
      host: http://blog.example.com
      max_age: 15m
    moderation:
      enabled: "false"
      purge_after: 30d
    server:
      listen: "http://localhost:9876"
      reload: "off"
      profile: "off"
    smtp:
      username: ""
      password: ""
      host: "localhost"
      post: 25
      security: "none"
      to: ""
      from: ""
      timeout: 10
    guard:
      enabled: "true"
      ratelimit: 2
      direct_reply: 3
      reply_to_self: "false"
      require_author: "false"
      require_email: "false"
    markup:
      options: "strikethrough, superscript, autolink"
      allowed_elements: ""
      allowed_attributes: ""
```

Supervisord is used as process control system.