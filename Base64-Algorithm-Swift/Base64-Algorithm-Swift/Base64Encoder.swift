//
//  Base64Encoder.swift
//  Base64-Algorithm-Swift
//
//  Created by Bhoomika m jain on 17/11/26.
//

import Foundation

class Base64Encoder {

    func encode(_ input: String) -> String {

        let bytes = Array(input.utf8)

        return encodeBytes(bytes)
    }

    func encodeImage(_ imageData: Data) -> String {

        let bytes = Array(imageData)

        return encodeBytes(bytes)
    }

    func encodeBytes(_ bytes: [UInt8]) -> String {

        var result = ""

        for index in stride(from: 0, to: bytes.count, by: 3) {

            let byte1 = getByte(bytes, index)

            let byte2 = getByte(bytes, index + 1)

            let byte3 = getByte(bytes, index + 2)

            let combined = combineBytes(byte1, byte2, byte3)

            let indexes = extractIndexes(combined)

            let encodedCharacters = convertIndexesToCharacters(indexes, bytes.count - index)

            result += encodedCharacters
        }

        return result
    }

    func getByte(_ bytes: [UInt8], _ index: Int) -> Int {

        if index < bytes.count {
            return Int(bytes[index])
        }

        return 0
    }
    
    func combineBytes(_ byte1: Int, _ byte2: Int, _ byte3: Int) -> Int {

        return (byte1 << 16) | (byte2 << 8) | byte3
    }

    func extractIndexes(_ combined: Int) -> [Int] {

        let index1 = (combined >> 18) & 63
        let index2 = (combined >> 12) & 63
        let index3 = (combined >> 6) & 63
        let index4 = combined & 63

        return [index1, index2, index3, index4]
    }

    func convertIndexesToCharacters(_ indexes: [Int], _ remainingBytes: Int) -> String {

        let table = Base64Utility.base64Table

        var result = ""

        result.append(table[indexes[0]])
        result.append(table[indexes[1]])

        if remainingBytes > 1 {
            result.append(table[indexes[2]])
        } else {
            result.append("=")
        }

        if remainingBytes > 2 {
            result.append(table[indexes[3]])
        } else {
            result.append("=")
        }

        return result
    }

}
