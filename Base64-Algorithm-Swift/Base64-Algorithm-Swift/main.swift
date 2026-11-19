//
//  main.swift
//  Base64-Algorithm-Swift
//
//  Created by Bhoomika m jain on 17/11/26.
//

import Foundation

let encoder = Base64Encoder()

let encodedText = encoder.encode("Hello")
print("Encoded text:", encodedText)

let decoder = Base64Decoder()

let decodedText = decoder.decode(encodedText)
print("Decoded text:", decodedText)

do {

    let imageURL = URL(fileURLWithPath: "/Users/bhoomikamjain/myprojects/Base64-Algorithm-Swift/Base64-Algorithm-Swift/Base64-Algorithm-Swift/images/Sample.jpg")

    let imageData = try Data(contentsOf: imageURL)

    print("Original image loaded!")
    print("Original size:", imageData.count, "bytes")

    let encodedImage = encoder.encodeImage(imageData)

    print("Image encoded successfully!")

    let base64URL = URL(fileURLWithPath: "/Users/bhoomikamjain/myprojects/Base64-Algorithm-Swift/Base64-Algorithm-Swift/Base64-Algorithm-Swift/images/imageBase64.txt")

    try encodedImage.write(
        to: base64URL,
        atomically: true,
        encoding: .utf8
    )

    print("Base64 text saved at:", base64URL.path)

    let decodedImageData = decoder.decodeImage(encodedImage)

    print("Image decoded successfully!")

    let outputURL = URL(fileURLWithPath: "/Users/bhoomikamjain/myprojects/Base64-Algorithm-Swift/Base64-Algorithm-Swift/Base64-Algorithm-Swift/images/decodedImage.jpg"
    )

    try decodedImageData.write(to: outputURL)

    print("Decoded image saved at:", outputURL.path)

} catch {

    print("Error:", error)

}
