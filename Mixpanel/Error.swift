//
//  Error.swift
//  Mixpanel
//
//  Created by Yarden Eitan on 6/10/16.
//  Copyright © 2016 Mixpanel. All rights reserved.
//

import Foundation

//TODO: improve error handling and logging

enum PropertyError: ErrorProtocol {
    case invalidType(type: AnyObject)
}

class Assertions {
    static var assertClosure      = swiftAssertClosure
    static let swiftAssertClosure = { Swift.assert($0, $1, file: $2, line: $3) }
}

func MPAssert(_ condition: @autoclosure() -> Bool,
              _ message: @autoclosure() -> String = "",
              file: StaticString = #file,
              line: UInt = #line) {
    Assertions.assertClosure(condition(), message(), file, line)
}

class ErrorHandler {
    class func wrap<ReturnType>(_ f: @noescape() throws -> ReturnType?) -> ReturnType? {
        do {
            return try f()
        } catch let error {
            logError(error)
            return nil
        }
    }

    class func logError(_ error: ErrorProtocol) {
        let stackSymbols = Thread.callStackSymbols()
        print("Error: \(error) \n Stack Symbols: \(stackSymbols)")
    }

}
