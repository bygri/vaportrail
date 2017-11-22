import Foundation
import FluentProvider
import Testing
@testable import Vapor
import Vaportrail
import VaportrailServer
import XCTest

extension Droplet {

  static func testable() throws -> Droplet {
    var config = try Config(arguments: ["vapor", "--env=test"])
    try config.set("droplet.log", "vaportrail")
    try config.set("vaportrail.host", "127.0.0.1")
    try config.set("vaportrail.sender", "VaportrailTests")
    config.addConfigurable(log: VaportrailLogger.init, name: "vaportrail")
    try config.addProvider(FluentProvider.Provider.self)
    try config.addProvider(VaportrailServer.Provider.self)
    let drop = try Droplet(config)
    // Disable info-level logs otherwise it will keep logging its own logging
    drop.log.enabled = [
      .fatal,
      .error,
      .warning
    ]
    return drop
  }

}
