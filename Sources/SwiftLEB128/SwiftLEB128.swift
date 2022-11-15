import Foundation

// https://en.wikipedia.org/wiki/LEB128

public enum LEB128DecodeError: Error {
    case malformed
    case overflow
}

public extension FixedWidthInteger where Self: UnsignedInteger {
    var unsignedLEB128: Data {
        var bytes: [UInt8] = []
        var value = self

        repeat {
            var byte = UInt8(value & 0x7F)
            value = value >> 7
            if value != 0 {
                byte |= 0x80
            }
            bytes.append(byte)
        } while value != 0

        return Data(bytes)
    }
    
    init(unsignedLEB128 data: Data) throws {
        var result: Self = 0
        var shift: UInt8 = 0
        var isEnd = false
        
        var index = data.startIndex
        while index < data.endIndex {
            let byte = data[index]
            let slice = Self(byte & 0x7F)
            guard (slice << shift) >> shift == slice else {
                throw LEB128DecodeError.overflow
            }
            result |= slice << shift
            
            if byte & 0x80 == 0 {
                isEnd = true
                break
            }
            
            index += 1
            shift += 7
        }
        
        guard isEnd else {
            throw LEB128DecodeError.malformed
        }
        
        self = result
    }
}

public extension FixedWidthInteger where Self: SignedInteger {
    var signedLEB128: Data {
        var bytes: [UInt8] = []
        var value = self

        repeat {
            var byte = UInt8(value & 0x7F)
            let sign = value & 0x40
            value = value >> 7
            
            if (value != -1 || sign == 0) && (value != 0 || sign != 0) {
                byte |= 0x80
            }
            
            bytes.append(byte)
            
            if (byte & 0x80) == 0 {
                break
            }
        } while true
        
        return Data(bytes)
    }
    
    init(signedLEB128 data: Data) throws {
        var result: Self = 0
        var shift: UInt8 = 0
        var isEnd = false
        
        var index = data.startIndex
        var byte: UInt8 = .init()
        while index < data.endIndex {
            byte = data[index]
            
            let slice = Self(byte & 0x7F)
            result |= slice << shift
            
            index += 1
            shift += 7
            
            if byte & 0x80 == 0 {
                isEnd = true
                break
            }

            guard shift < Self.bitWidth else {
                throw LEB128DecodeError.overflow
            }
        }
        
        guard isEnd else {
            throw LEB128DecodeError.malformed
        }
        
        if byte & 0b0100_0000 != 0 {
            result |= Self(~0) << shift
        }

        self = result
    }
}
