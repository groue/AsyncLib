//
//  AsyncLibTests.swift
//  AsyncLibTests
//
//  Created by Gwendal Roué on 01/11/2021.
//

import XCTest
@testable import AsyncLib

class AsyncLibTests: XCTestCase {
    func testAsyncFunction() async throws {
        await f()
    }
}
