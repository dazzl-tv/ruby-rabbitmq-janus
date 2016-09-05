# Channel

How to use gem for channels

For each example initialize a gem with command : `t = RRJ::RRJ.new`

## List channels

```ruby
# Create a session
create = t.ask('create')
session = t.response(create)

# Attach a session to plugin
attach = t.ask('attach', session)
session = t.response(attach)

# List a channels
list = t.ask('channel::list', session)
session = t.response(list)

# Detach a session
detach = t.ask('detach', session)
session = t.response(detach)

# Destroy a session
destroy = t.ask('destroy', session)
session = t.response(destroy)
```
