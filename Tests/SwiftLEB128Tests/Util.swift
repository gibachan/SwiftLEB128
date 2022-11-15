//
//  Util.swift
//  
//
//  Created by Tatsuyuki Kobayashi on 2022/11/16.
//

import XCTest

func XCTAssertThrows<T, E: Error & Equatable>(
    _ expression: @autoclosure () throws -> T,
    throws error: E,
    in file: StaticString = #file,
    line: UInt = #line
) {
    var thrownError: Error?
    
    XCTAssertThrowsError(try expression(),
                         file: file, line: line) {
        thrownError = $0
    }
    
    XCTAssertTrue(
        thrownError is E,
        "Unexpected error type: \(type(of: thrownError))",
        file: file, line: line
    )
    
    XCTAssertEqual(
        thrownError as? E, error,
        file: file, line: line
    )
}
