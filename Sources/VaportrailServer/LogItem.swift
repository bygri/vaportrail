import FluentProvider
import Foundation
import Vapor

final class LogItem: Model {

  let date: Date
  let sender: String
  let level: LogLevel
  let message: String
  let file: String
  let function: String
  let line: Int

  let storage = Storage()

  init(
    sender: String,
    level: LogLevel,
    message: String,
    file: String,
    function: String,
    line: Int
  ) {
    self.date = Date()
    self.sender = sender
    self.level = level
    self.message = message
    self.file = file
    self.function = function
    self.line = line
  }

  init(row: Row) throws {
    date = try row.get("date")
    sender = try row.get("sender")
    level = try row.get("level")
    message = try row.get("message")
    file = try row.get("file")
    function = try row.get("function")
    line = try row.get("line")
  }

  func makeRow() throws -> Row {
    var row = Row()
    try row.set("date", date)
    try row.set("sender", sender)
    try row.set("level", level)
    try row.set("message", message)
    try row.set("file", file)
    try row.set("function", function)
    try row.set("line", line)
    return row
  }

}

extension LogItem: Preparation {

  static func prepare(_ database: Database) throws {
    try database.create(self) { builder in
      builder.id()
      builder.date("date")
      builder.string("sender", length: 20)
      builder.string("level", length: 10)
      builder.string("message", length: 255)
      builder.string("file", length: 60)
      builder.string("function", length: 40)
      builder.int("line")
    }
    try database.index("sender", for: LogItem.self)
    try database.index("level", for: LogItem.self)
  }

  static func revert(_ database: Database) throws {
    try database.delete(self)
  }

}

extension LogItem: JSONConvertible {

  convenience init(json: JSON) throws {
    self.init(
      sender: try json.get("sender"),
      level: try json.get("level"),
      message: try json.get("message"),
      file: try json.get("file"),
      function: try json.get("function"),
      line: try json.get("line")
    )
  }

  func makeJSON() throws -> JSON {
    var json = JSON()
    try json.set("date", date)
    try json.set("sender", sender)
    try json.set("level", level)
    try json.set("message", message)
    try json.set("file", file)
    try json.set("function", function)
    try json.set("line", line)
    return json
  }

}
