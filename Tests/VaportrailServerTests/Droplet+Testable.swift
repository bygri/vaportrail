import FluentProvider
import Foundation
import Testing
@testable import Vapor
import VaportrailServer
import XCTest

extension Droplet {

  static func testable() throws -> Droplet {
    Node.fuzzy = [Row.self, JSON.self, Node.self]
    let config = try Config(arguments: ["vapor", "--env=test"])
    try config.addProvider(FluentProvider.Provider.self)
    try config.addProvider(VaportrailServer.Provider.self)
    return try Droplet(config)
  }

}
