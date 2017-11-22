# Vaportrail

<p align="center">
  <a href="https://swift.org">
    <img src="http://img.shields.io/badge/Swift-4-brightgreen.svg" alt="Language">
  </a>
  <a href="https://vapor.codes">
    <img src="https://img.shields.io/badge/vapor-2.2-92a8d1.svg" alt="MIT License">
  </a>
</p>

Simple log aggregation for Vapor.

## Logging from Vapor

Add `VaportrailLogger` to your list of configured loggers:

```swift
config.addConfigurable(log: VaportrailLogger.init, name: "vaportrail")
```

Set Vaportrail as active in your Config file `droplet.json`:

```json
{
  "log": "vaportrail"
}
```

Create a new Config file `vaportrail.json` with the following content. `host`
is the IP or host name of your running Vaportrail instance, and `sender` is any
string that will help you identify your app in your Vaportrail logs.

```json
{
  "host": "127.0.0.1",
  "sender": "MyAppName"
}
```

Now, all your Vapor logs will be directed to Vaportrail.

```swift
drop.log.error("Uh oh")
```

## Running a Vaportrail instance

Vaportrail can 'bolt-on' to any existing Vapor application, but it's best to
run a dedicated Vapor app just for Vaportrail.

In short, you need to add and configure your choice of Fluent-backed database
provider, and then add the `VaportrailServer.Provider`.

```swift
import MySQLProvider
import Vapor
import VaportrailServer

let config = try Config()
try config.addProvider(MySQLProvider.Provider.self)
try config.addProvider(VaportrailServer.Provider.self)

let drop = try Droplet(config)
try drop.run()
```
