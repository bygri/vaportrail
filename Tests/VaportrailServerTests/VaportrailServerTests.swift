import XCTest
import Foundation
import Testing
@testable import Vapor

class VaportrailServerTests: XCTestCase {

  static let allTests = [
    ("testPutLogItem", testPutLogItem),
    ("testPutInvalidLogItem", testPutInvalidLogItem),
    ("testPutInvalid", testPutInvalid),
  ]

  let drop = try! Droplet.testable()

  func testPutLogItem() throws {
    let req = Request.makeTest(method: .put, path: "/")
    var logJSON = JSON()
    try logJSON.set("sender", "self")
    try logJSON.set("level", "WARNING")
    try logJSON.set("message", "Log message")
    try logJSON.set("file", "filename.swift")
    try logJSON.set("function", "doSomethingWrong()")
    try logJSON.set("line", 42)
    req.json = JSON([logJSON])
    let resp = try drop.respond(to: req)
    XCTAssertTrue(resp.status == .accepted)
  }

  func testPutInvalidLogItem() throws {
    let req = Request.makeTest(method: .put, path: "/")
    var json = JSON()
    try json.set("level", "WARNING")
    req.json = json
    let resp = try drop.respond(to: req)
    XCTAssertTrue(resp.status == .badRequest)
  }

  func testPutInvalid() throws {
    let req = Request.makeTest(method: .put, path: "/")
    let resp = try drop.respond(to: req)
    XCTAssertTrue(resp.status == .badRequest)
  }

}
