import HTTP
import Foundation
import Vapor

final public class VaportrailLogger: LogProtocol {

  public var enabled: [LogLevel] = LogLevel.all

  let host: String
  let sender: String
  let client: ClientFactoryProtocol

  public init(host: String, sender: String, client: ClientFactoryProtocol) {
    self.host = host
    self.sender = sender
    self.client = client
  }

  public func log(_ level: LogLevel, message: String, file: String = #file, function: String = #function, line: Int = #line) {
    guard enabled.contains(level) else {
      return
    }
    try? sendLog(level, message: message, file: file, function: function, line: line)
  }

  func sendLog(_ level: LogLevel, message: String, file: String = #file, function: String = #function, line: Int = #line) throws {
    let req = Request(method: .put, uri: "http://\(host)")
    var logJSON = JSON()
    try logJSON.set("sender", sender)
    try logJSON.set("level", level.description)
    try logJSON.set("message", message)
    try logJSON.set("file", file)
    try logJSON.set("function", function)
    try logJSON.set("line", line)
    req.json = JSON([logJSON])
    try client.respond(to: req)
  }

}

extension VaportrailLogger: ConfigInitializable {

  public convenience init(config: Config) throws {
    guard let vaportrail = config["vaportrail"]?.object else {
      throw ConfigError.missingFile("vaportrail")
    }
    guard let host = vaportrail["host"]?.string else {
      throw ConfigError.missing(key: ["host"], file: "vaportrail", desiredType: String.self)
    }
    guard let sender = vaportrail["sender"]?.string else {
      throw ConfigError.missing(key: ["sender"], file: "vaportrail", desiredType: String.self)
    }
    try self.init(host: host, sender: sender, client: config.resolveClient())
  }

}
