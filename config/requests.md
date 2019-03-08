# Requests

## Defaults request

By default this gem contains many request :

```linux
├── admin
│   ├── add_token.json
│   ├── allow_token.json
│   ├── disallow_token.json
│   ├── handle_info.json
│   ├── handles.json
│   ├── remove_token.json
│   ├── sessions.json
│   ├── set_locking_debug.json
│   ├── set_log_level.json
│   ├── start_pcap.json
│   ├── start_text2pcap.json
│   ├── stop_pcap.json
│   ├── stop_text2pcap.json
│   └── tokens.json
├── base
│   ├── attach.json
│   ├── create.json
│   ├── destroy.json
│   ├── detach.json
│   ├── info.json
│   └── keepalive.json
├── peer
│   ├── answer.json
│   ├── offer.json
│   └── trickle.json
```

* Folder `admin` contains admin requests for interact with Janus Admin/Monitor
 API. [See official docs.](https://janus.conf.meetecho.com/docs/admin.html)
* Folder `base` contains base requests for interact with Janus.

## Request files

All request is writing in JSON format and contains many informations.

Example base request with type `'base::info'` :

```json
{
  "janus": "info",
  "transaction": "<string>"
}
```

For more explain to construct request sending to Janus [see official documentation](https://janus.conf.meetecho.com/docs/rest.html).

Some fields are customizable. For this fields is a gem to apply a transformation :

* session_id
* handle_id
* transaction
* candidate
* *Admin transaction*
  * admin_secret
  * level
  * folder
  * filename
  * truncate

Each fields use an type :

* "\<number\>" - Is a integer
* "\<number\>" - Is a integer
* "\<string\>" - Is a string
* "\<plugin[X]\>" - Is a plugin with X is a key to array in config file
* "\<array\>" - Is a array. If array contains a single value is transform to string format.

## Complex request

Example peer request with type `'peer:offer'` :

```json
{
  "janus": "message",
  "session_id": "<number>",
  "handle_id": "<number>",
  "transaction": "<string>",
  "body": {
    "audio": "true",
    "video": "true"
  },
  "jsep": {
    "type": "offer",
    "sdp": "<string>"
  }
}
```
