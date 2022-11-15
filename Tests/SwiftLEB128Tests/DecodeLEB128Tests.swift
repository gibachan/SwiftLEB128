//
//  DecodeLEB128Tests.swift
//  
//
//  Created by Tatsuyuki Kobayashi on 2022/11/16.
//

import XCTest
@testable import SwiftLEB128

final class DecodeLEB128Tests: XCTestCase {
    func testDecodeUnsignedLEB128ToUInt8() {
        XCTAssertEqual(try UInt8(unsignedLEB128: Data([0x00])), 0)
        XCTAssertEqual(try UInt8(unsignedLEB128: Data([0x01])), 1)
        XCTAssertEqual(try UInt8(unsignedLEB128: Data([0x7F])), 127)
        XCTAssertEqual(try UInt8(unsignedLEB128: Data([0x80, 0x00])), 0)
        XCTAssertEqual(try UInt8(unsignedLEB128: Data([0x80, 0x01])), 128)
        XCTAssertEqual(try UInt8(unsignedLEB128: Data([0xFF, 0x01])), UInt8.max) // 255
        
        XCTAssertThrows(try UInt8(unsignedLEB128: Data([])),
                        throws: LEB128DecodeError.malformed)
        XCTAssertThrows(try UInt8(unsignedLEB128: Data([0x80])),
                        throws: LEB128DecodeError.malformed)
        XCTAssertThrows(try UInt8(unsignedLEB128: Data([0xFF, 0xFF, 0x02])),
                        throws: LEB128DecodeError.overflow)
    }
    
    func testDecodeUnsignedLEB128ToUInt16() {
        XCTAssertEqual(try UInt16(unsignedLEB128: Data([0x00])), 0)
        XCTAssertEqual(try UInt16(unsignedLEB128: Data([0x01])), 1)
        XCTAssertEqual(try UInt16(unsignedLEB128: Data([0x7F])), 127)
        XCTAssertEqual(try UInt16(unsignedLEB128: Data([0x80, 0x00])), 0)
        XCTAssertEqual(try UInt16(unsignedLEB128: Data([0x80, 0x01])), 128)
        XCTAssertEqual(try UInt16(unsignedLEB128: Data([0xFF, 0x7F])), 16383)
        XCTAssertEqual(try UInt16(unsignedLEB128: Data([0x80, 0x80, 0x01])), 16384)
        XCTAssertEqual(try UInt16(unsignedLEB128: Data([0xFF, 0xFF, 0x03])), UInt16.max) // 65535

        XCTAssertThrows(try UInt16(unsignedLEB128: Data([])),
                        throws: LEB128DecodeError.malformed)
        XCTAssertThrows(try UInt8(unsignedLEB128: Data([0x80])),
                        throws: LEB128DecodeError.malformed)
        XCTAssertThrows(try UInt8(unsignedLEB128: Data([0x80, 0x80])),
                        throws: LEB128DecodeError.malformed)
        XCTAssertThrows(try UInt16(unsignedLEB128: Data([0x80, 0x80, 0x04])),
                        throws: LEB128DecodeError.overflow)
    }
    
    func testDecodeUnsignedLEB128ToUInt32() {
        XCTAssertEqual(try UInt32(unsignedLEB128: Data([0x00])), 0)
        XCTAssertEqual(try UInt32(unsignedLEB128: Data([0x01])), 1)
        XCTAssertEqual(try UInt32(unsignedLEB128: Data([0x7F])), 127)
        XCTAssertEqual(try UInt32(unsignedLEB128: Data([0x80, 0x00])), 0)
        XCTAssertEqual(try UInt32(unsignedLEB128: Data([0x80, 0x01])), 128)
        XCTAssertEqual(try UInt32(unsignedLEB128: Data([0xFF, 0x7F])), 16383)
        XCTAssertEqual(try UInt32(unsignedLEB128: Data([0x80, 0x80, 0x01])), 16384)
        XCTAssertEqual(try UInt32(unsignedLEB128: Data([0x80, 0x80, 0x04])), 65536)
        XCTAssertEqual(try UInt32(unsignedLEB128: Data([0xFF, 0xFF, 0x7F])), 2097151)
        XCTAssertEqual(try UInt32(unsignedLEB128: Data([0x80, 0x80, 0x80, 0x01])), 2097152)
        XCTAssertEqual(try UInt32(unsignedLEB128: Data([0xFF, 0xFF, 0xFF, 0x7F])), 268435455)
        XCTAssertEqual(try UInt32(unsignedLEB128: Data([0x80, 0x80, 0x80, 0x80, 0x01])), 268435456)
        XCTAssertEqual(try UInt32(unsignedLEB128: Data([0xFF, 0xFF, 0xFF, 0xFF, 0x0F])), UInt32.max) // 4294967295
        
        XCTAssertThrows(try UInt32(unsignedLEB128: Data([])),
                        throws: LEB128DecodeError.malformed)
        XCTAssertThrows(try UInt32(unsignedLEB128: Data([0x80])),
                        throws: LEB128DecodeError.malformed)
        XCTAssertThrows(try UInt32(unsignedLEB128: Data([0x80, 0x80, 0x80, 0x80])),
                        throws: LEB128DecodeError.malformed)
        XCTAssertThrows(try UInt32(unsignedLEB128: Data([0xFF, 0xFF, 0xFF, 0xFF, 0x10])),
                        throws: LEB128DecodeError.overflow)
    }
    
    func testDecodeUnsignedLEB128ToUInt64() {
        XCTAssertEqual(try UInt64(unsignedLEB128: Data([0x00])), 0)
        XCTAssertEqual(try UInt64(unsignedLEB128: Data([0x01])), 1)
        XCTAssertEqual(try UInt64(unsignedLEB128: Data([0x7F])), 127)
        XCTAssertEqual(try UInt64(unsignedLEB128: Data([0x80, 0x00])), 0)
        XCTAssertEqual(try UInt64(unsignedLEB128: Data([0x80, 0x01])), 128)
        XCTAssertEqual(try UInt64(unsignedLEB128: Data([0xFF, 0x7F])), 16383)
        XCTAssertEqual(try UInt64(unsignedLEB128: Data([0x80, 0x80, 0x01])), 16384)
        XCTAssertEqual(try UInt64(unsignedLEB128: Data([0x80, 0x80, 0x04])), 65536)
        XCTAssertEqual(try UInt64(unsignedLEB128: Data([0xFF, 0xFF, 0x7F])), 2097151)
        XCTAssertEqual(try UInt64(unsignedLEB128: Data([0x80, 0x80, 0x80, 0x01])), 2097152)
        XCTAssertEqual(try UInt64(unsignedLEB128: Data([0xFF, 0xFF, 0xFF, 0x7F])), 268435455)
        XCTAssertEqual(try UInt64(unsignedLEB128: Data([0x80, 0x80, 0x80, 0x80, 0x01])), 268435456)
        XCTAssertEqual(try UInt64(unsignedLEB128: Data([0xFF, 0xFF, 0xFF, 0xFF, 0x7F])), 34359738367)
        XCTAssertEqual(try UInt64(unsignedLEB128: Data([0x80, 0x80, 0x80, 0x80, 0x80, 0x01])), 34359738368)
        XCTAssertEqual(try UInt64(unsignedLEB128: Data([0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0x7F])), 4398046511103)
        XCTAssertEqual(try UInt64(unsignedLEB128: Data([0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x01])), 4398046511104)
        XCTAssertEqual(try UInt64(unsignedLEB128: Data([0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0x7F])), 562949953421311)
        XCTAssertEqual(try UInt64(unsignedLEB128: Data([0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x01])), 562949953421312)
        XCTAssertEqual(try UInt64(unsignedLEB128: Data([0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0x7F])), 72057594037927935)
        XCTAssertEqual(try UInt64(unsignedLEB128: Data([0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0x01])), UInt64.max) // 18446744073709551615

        XCTAssertThrows(try UInt64(unsignedLEB128: Data([])),
                        throws: LEB128DecodeError.malformed)
        XCTAssertThrows(try UInt64(unsignedLEB128: Data([0x80])),
                        throws: LEB128DecodeError.malformed)
        XCTAssertThrows(try UInt64(unsignedLEB128: Data([0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80])),
                        throws: LEB128DecodeError.malformed)
        XCTAssertThrows(try UInt64(unsignedLEB128: Data([0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0x02])),
                        throws: LEB128DecodeError.overflow)
    }
    
    func testDecodeSignedLEB128ToUInt8() {
        XCTAssertEqual(try Int8(signedLEB128: Data([0x80, 0x7F])), Int8.min) // -127
        XCTAssertEqual(try Int8(signedLEB128: Data([0x7F])), -1)
        XCTAssertEqual(try Int8(signedLEB128: Data([0x000])), 0)
        XCTAssertEqual(try Int8(signedLEB128: Data([0x01])), 1)
        XCTAssertEqual(try Int8(signedLEB128: Data([0xFF, 0x00])), Int8.max) // 127
        
        XCTAssertThrows(try Int8(signedLEB128: Data([])),
                        throws: LEB128DecodeError.malformed)
        XCTAssertThrows(try Int8(signedLEB128: Data([0x80])),
                        throws: LEB128DecodeError.malformed)
    }
    
    func testDecodeSignedLEB128ToUInt16() {
        XCTAssertEqual(try Int16(signedLEB128: Data([0x80, 0x80, 0x7E])), Int16.min) // -32768
        XCTAssertEqual(try Int16(signedLEB128: Data([0x7F])), -1)
        XCTAssertEqual(try Int16(signedLEB128: Data([0x000])), 0)
        XCTAssertEqual(try Int16(signedLEB128: Data([0x01])), 1)
        XCTAssertEqual(try Int16(signedLEB128: Data([0xFF, 0xFF, 0x01])), Int16.max) // 32767
        
        XCTAssertThrows(try Int16(signedLEB128: Data([])),
                        throws: LEB128DecodeError.malformed)
        XCTAssertThrows(try Int16(signedLEB128: Data([0x80])),
                        throws: LEB128DecodeError.malformed)
    }
    
    func testDecodeSignedLEB128ToUInt32() {
        XCTAssertEqual(try Int32(signedLEB128: Data([0x80, 0x80, 0x80, 0x80, 0x78])), Int32.min) // -2147483648
        XCTAssertEqual(try Int32(signedLEB128: Data([0x7F])), -1)
        XCTAssertEqual(try Int32(signedLEB128: Data([0x000])), 0)
        XCTAssertEqual(try Int32(signedLEB128: Data([0x01])), 1)
        XCTAssertEqual(try Int32(signedLEB128: Data([0xFF, 0xFF, 0xFF, 0xFF, 0x07])), Int32.max) // 2147483647

        XCTAssertThrows(try Int32(signedLEB128: Data([])),
                        throws: LEB128DecodeError.malformed)
        XCTAssertThrows(try Int32(signedLEB128: Data([0x80])),
                        throws: LEB128DecodeError.malformed)
    }
    
    func testDecodeSignedLEB128ToUInt64() {
        XCTAssertEqual(try Int64(signedLEB128: Data([0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x7F])), Int64.min) // -9223372036854775808
        XCTAssertEqual(try Int64(signedLEB128: Data([0x7F])), -1)
        XCTAssertEqual(try Int64(signedLEB128: Data([0x000])), 0)
        XCTAssertEqual(try Int64(signedLEB128: Data([0x01])), 1)
        XCTAssertEqual(try Int64(signedLEB128: Data([0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0x00])), Int64.max) // 9223372036854775807
        
        XCTAssertThrows(try Int64(signedLEB128: Data([])),
                        throws: LEB128DecodeError.malformed)
        XCTAssertThrows(try Int64(signedLEB128: Data([0x80])),
                        throws: LEB128DecodeError.malformed)
    }
}
