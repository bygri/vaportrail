import Vapor

extension LogLevel: NodeConvertible {

  public init(node: Node) throws {
    let str: String = try node.get()
    switch str {
      case "VERBOSE": self = .verbose
      case "DEBUG": self = .debug
      case "INFO": self = .info
      case "WARNING": self = .warning
      case "ERROR": self = .error
      case "FATAL": self = .fatal
      default: self = .custom(str)
    }
  }

  public func makeNode(in context: Context?) throws -> Node {
    return description.makeNode(in: context)
  }

}
