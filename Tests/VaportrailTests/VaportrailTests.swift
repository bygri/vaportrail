import XCTest
import Foundation
import Testing
@testable import Vapor
import Vaportrail

class VaportrailTests: XCTestCase {

  static let allTests = [
    ("testDroplet", testDroplet),
  ]

  func testDroplet() throws {
    let drop = try Droplet.testable()
    background {
      try! drop.run()
    }
    drop.console.wait(seconds: 0.5)
    drop.log.error("Hi there")
    drop.console.wait(seconds: 0.5)
  }

}
