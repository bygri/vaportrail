import HTTP
import Vapor

final class API: RouteCollection {

  let log: LogProtocol

  init(log: LogProtocol) {
    self.log = log
  }

  func build(_ builder: RouteBuilder) {

    /**
    Store new log items.
    Returns HTTP 400 if a JSON array (required) is not passed.
    Returns HTTP 202 if the request has been accepted.
    Log items are saved asynchronously, so this method doesn't report on further success or failure.
    */
    builder.put() { req in
      guard let jsonItems = req.json?.array else {
        throw Abort.badRequest
      }
      background { [weak self] in
        do {
          try jsonItems
            .map { try LogItem(json: $0) }
            .forEach { try $0.save() }
        } catch {
          self?.log.error("Unable to parse and save log items: \(error)")
        }
      }
      return Response(status: .accepted)
    }

  }

}
