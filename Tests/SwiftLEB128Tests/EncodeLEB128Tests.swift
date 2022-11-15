//
//  EncodeLEB128Tests.swift
//
//
//  Created by Tatsuyuki Kobayashi on 2022/11/16.
//

import XCTest
@testable import SwiftLEB128

final class EncodeLEB128Tests: XCTestCase {
    func testEncodeUInt8ToUnsignedLEB128() {
        XCTAssertEqual(UInt8(0).unsignedLEB128, Data([0x00]))
        XCTAssertEqual(UInt8(1).unsignedLEB128, Data([0x01]))
        XCTAssertEqual(UInt8(127).unsignedLEB128, Data([0x7F]))
        XCTAssertEqual(UInt8(128).unsignedLEB128, Data([0x80, 0x01]))
        XCTAssertEqual(UInt8.max.unsignedLEB128, Data([0xFF, 0x01]))
    }

    func testEncodeUInt16ToUnsignedLEB128() {
        XCTAssertEqual(UInt16(0).unsignedLEB128, Data([0x00]))
        XCTAssertEqual(UInt16(1).unsignedLEB128, Data([0x01]))
        XCTAssertEqual(UInt16(127).unsignedLEB128, Data([0x7F]))
        XCTAssertEqual(UInt16(128).unsignedLEB128, Data([0x80, 0x01]))
        XCTAssertEqual(UInt16(16383).unsignedLEB128, Data([0xFF, 0x7F]))
        XCTAssertEqual(UInt16(16384).unsignedLEB128, Data([0x80, 0x80, 0x01]))
        XCTAssertEqual(UInt16.max.unsignedLEB128, Data([0xFF, 0xFF, 0x03]))
    }

    func testEncodeUInt32ToUnsignedLEB128() {
        XCTAssertEqual(UInt32(0).unsignedLEB128, Data([0x00]))
        XCTAssertEqual(UInt32(1).unsignedLEB128, Data([0x01]))
        XCTAssertEqual(UInt32(127).unsignedLEB128, Data([0x7F]))
        XCTAssertEqual(UInt32(128).unsignedLEB128, Data([0x80, 0x01]))
        XCTAssertEqual(UInt32(16383).unsignedLEB128, Data([0xFF, 0x7F]))
        XCTAssertEqual(UInt32(16384).unsignedLEB128, Data([0x80, 0x80, 0x01]))
        XCTAssertEqual(UInt32(65536).unsignedLEB128, Data([0x80, 0x80, 0x04]))
        XCTAssertEqual(UInt32(2097151).unsignedLEB128, Data([0xFF, 0xFF, 0x7F]))
        XCTAssertEqual(UInt32(2097152).unsignedLEB128, Data([0x80, 0x80, 0x80, 0x01]))
        XCTAssertEqual(UInt32(268435455).unsignedLEB128, Data([0xFF, 0xFF, 0xFF, 0x7F]))
        XCTAssertEqual(UInt32(268435456).unsignedLEB128, Data([0x80, 0x80, 0x80, 0x80, 0x01]))
        XCTAssertEqual(UInt32.max.unsignedLEB128, Data([0xFF, 0xFF, 0xFF, 0xFF, 0x0F]))
    }

    func testEncodeUInt64ToUnsignedLEB128() {
        XCTAssertEqual(UInt64(0).unsignedLEB128, Data([0x00]))
        XCTAssertEqual(UInt64(1).unsignedLEB128, Data([0x01]))
        XCTAssertEqual(UInt64(127).unsignedLEB128, Data([0x7F]))
        XCTAssertEqual(UInt64(128).unsignedLEB128, Data([0x80, 0x01]))
        XCTAssertEqual(UInt64(16383).unsignedLEB128, Data([0xFF, 0x7F]))
        XCTAssertEqual(UInt64(16384).unsignedLEB128, Data([0x80, 0x80, 0x01]))
        XCTAssertEqual(UInt64(65536).unsignedLEB128, Data([0x80, 0x80, 0x04]))
        XCTAssertEqual(UInt64(2097151).unsignedLEB128, Data([0xFF, 0xFF, 0x7F]))
        XCTAssertEqual(UInt64(2097152).unsignedLEB128, Data([0x80, 0x80, 0x80, 0x01]))
        XCTAssertEqual(UInt64(268435455).unsignedLEB128, Data([0xFF, 0xFF, 0xFF, 0x7F]))
        XCTAssertEqual(UInt64(268435456).unsignedLEB128, Data([0x80, 0x80, 0x80, 0x80, 0x01]))
        XCTAssertEqual(UInt64(34359738367).unsignedLEB128, Data([0xFF, 0xFF, 0xFF, 0xFF, 0x7F]))
        XCTAssertEqual(UInt64(34359738368).unsignedLEB128, Data([0x80, 0x80, 0x80, 0x80, 0x80, 0x01]))
        XCTAssertEqual(UInt64(4398046511103).unsignedLEB128, Data([0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0x7F]))
        XCTAssertEqual(UInt64(4398046511104).unsignedLEB128, Data([0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x01]))
        XCTAssertEqual(UInt64(562949953421311).unsignedLEB128, Data([0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0x7F]))
        XCTAssertEqual(UInt64(562949953421312).unsignedLEB128, Data([0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x01]))
        XCTAssertEqual(UInt64(72057594037927935).unsignedLEB128, Data([0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0x7F]))
        XCTAssertEqual(UInt64.max.unsignedLEB128, Data([0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0x01]))
    }

    func testEncodeUInt8ToSignedLEB128() {
        XCTAssertEqual(Int8.min.signedLEB128, Data([0x80, 0x7F])) // -127
        XCTAssertEqual(Int8(-1).signedLEB128, Data([0x7F]))
        XCTAssertEqual(Int8(0).signedLEB128, Data([0x00]))
        XCTAssertEqual(Int8(1).signedLEB128, Data([0x01]))
        XCTAssertEqual(Int8.max.signedLEB128, Data([0xFF, 0x00])) // 127
    }

    func testEncodeUInt16ToSignedLEB128() {
        XCTAssertEqual(Int16.min.signedLEB128, Data([0x80, 0x80, 0x7E])) // -32768
        XCTAssertEqual(Int16(-1).signedLEB128, Data([0x7F]))
        XCTAssertEqual(Int16(0).signedLEB128, Data([0x00]))
        XCTAssertEqual(Int16(1).signedLEB128, Data([0x01]))
        XCTAssertEqual(Int16.max.signedLEB128, Data([0xFF, 0xFF, 0x01])) // 32767
    }

    func testEncodeUInt32ToSignedLEB128() {
        XCTAssertEqual(Int32.min.signedLEB128, Data([0x80, 0x80, 0x80, 0x80, 0x78])) // -2147483648
        XCTAssertEqual(Int32(-1).signedLEB128, Data([0x7F]))
        XCTAssertEqual(Int32(0).signedLEB128, Data([0x00]))
        XCTAssertEqual(Int32(1).signedLEB128, Data([0x01]))
        XCTAssertEqual(Int32.max.signedLEB128, Data([0xFF, 0xFF, 0xFF, 0xFF, 0x07])) // 2147483647
    }

    func testEncodeUInt64ToSignedLEB128() {
        XCTAssertEqual(Int64.min.signedLEB128, Data([0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x7F])) // -9223372036854775808
        XCTAssertEqual(Int64(-1).signedLEB128, Data([0x7F]))
        XCTAssertEqual(Int64(0).signedLEB128, Data([0x00]))
        XCTAssertEqual(Int64(1).signedLEB128, Data([0x01]))
        XCTAssertEqual(Int64.max.signedLEB128, Data([0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0x00])) // 9223372036854775807
    }
}
