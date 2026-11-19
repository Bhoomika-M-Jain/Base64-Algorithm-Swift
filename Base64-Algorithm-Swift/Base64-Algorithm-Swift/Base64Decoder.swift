//
//  Base64Decoder.swift
//  Base64-Algorithm-Swift
//
//  Created by Bhoomika m jain on 17/11/26.
//

import Foundation

class Base64Decoder {

    func decode(_ input: String) -> String {

        let bytes = decodeBytes(input)

        return convertToString(bytes)
    }

    func decodeImage(_ input: String) -> Data {

        let bytes = decodeBytes(input)

        return Data(bytes)
    }

    func decodeBytes(_ input: String) -> [UInt8] {

        let characters = convertToCharacters(input)

        var output = [UInt8]()

        for index in stride(from: 0, to: characters.count, by: 4) {

            let indexes = convertCharactersToIndexes(characters, index)

            let bytes = extractBytes(indexes)

            let decodedBytes = removePadding(bytes, characters, index)

            output.append(contentsOf: decodedBytes)
        }

        return output
    }

    func convertToCharacters(_ input: String) -> [Character] {
        return Array(input)
    }

    func convertCharactersToIndexes(_ characters: [Character], _ index: Int) -> [Int] {

        let table = Base64Utility.base64Table

        let char1 = characters[index]
        let char2 = characters[index + 1]
        let char3 = characters[index + 2]
        let char4 = characters[index + 3]

        let value1 = table.firstIndex(of: char1)!
        let value2 = table.firstIndex(of: char2)!

        let value3 = char3 == "=" ? 0 : table.firstIndex(of: char3)!
        let value4 = char4 == "=" ? 0 : table.firstIndex(of: char4)!

        return [value1, value2, value3, value4]
    }

    func extractBytes(_ indexes: [Int]) -> [UInt8] {

        let combined = (indexes[0] << 18) | (indexes[1] << 12) | (indexes[2] << 6) | indexes[3]

        let byte1 = (combined >> 16) & 255
        let byte2 = (combined >> 8) & 255
        let byte3 = combined & 255

        return [UInt8(byte1), UInt8(byte2), UInt8(byte3)]
    }

    func removePadding(_ bytes: [UInt8], _ characters: [Character], _ index: Int) -> [UInt8] {

        let char3 = characters[index + 2]
        let char4 = characters[index + 3]

        if char3 == "=" {
            return [bytes[0]]
        }

        if char4 == "=" {
            return [bytes[0], bytes[1]]
        }

        return bytes
    }

    func convertToString(_ bytes: [UInt8]) -> String {
        return String(decoding: bytes, as: UTF8.self)
    }
}
