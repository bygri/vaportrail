#if os(Linux)

import XCTest
@testable import VaportrailServerTests
@testable import VaportrailTests

XCTMain([

  // VaportrailServer
  testCase(VaportrailServerTests.allTests),

  // Vaportrail
  testCase(VaportrailTests.allTests),
  
])

#endif
