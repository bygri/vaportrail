import Vapor

public final class Provider: Vapor.Provider {

  public static let repositoryName = "vaportrail-server"  

  public convenience init(config: Config) throws {
    self.init()
  }

  init() {}

  public func boot(_ config: Config) throws {
    config.preparations.append(LogItem.self)
  }

  public func boot(_ drop: Droplet) throws {
    let api = API(log: drop.log)
    try drop.collection(api)
  }

  public func beforeRun(_ drop: Droplet) throws {}

}
