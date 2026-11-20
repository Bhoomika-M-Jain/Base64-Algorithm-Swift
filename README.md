**Base64 Algorithm in Swift**

This project implements Base64 Encoding and Decoding in Swift from scratch to convert text and images, into Base64 format and reconstruct the original data.

It demonstrates the internal working of the Base64 algorithm using byte manipulation, bitwise operations, and a character lookup table without relying on Swift's built-in Base64 encoding and decoding methods.

# <u>Features</u>

### Supports:

- Encoding and decoding of text.
- Encoding and decoding of image data.
- Conversion of strings into UTF-8 byte arrays.
- Conversion of image data into Base64 strings.
- Manual implementation of Base64 encoding and decoding.
- Handling of incomplete byte groups using `=` padding.
- Saving encoded Base64 data into a `.txt` file.
- Reconstructing and saving the original image after decoding.

---

## Project Structure

| File                | Description                                                             |
| ------------------- | ----------------------------------------------------------------------- |
| `main.swift`        | Example usage that encodes and decodes text and image files.            |
| `Base64Code.swift`  | Core logic: Base64 encoding, decoding, byte manipulation, and padding.  |
| `BaseUtility.swift` | Contains the Base64 character lookup table.                             |
| Images              | Contains the sample image, encoded Base64 text file, and decoded image. |

---

## Base64 Encoding Format

Base64 uses a set of **64 characters** to represent binary data.

| Character Set | Description             |
| ------------- | ----------------------- |
| `A-Z`         | 26 uppercase letters    |
| `a-z`         | 26 lowercase letters    |
| `0-9`         | 10 digits               |
| `+` and `/`   | 2 additional characters |
| `=`           | Padding character       |

**Total: 64 encoding characters + padding character.**

### How Base64 Processes Data

| Input   | Output                     |
| ------- | -------------------------- |
| 3 bytes | 4 Base64 characters        |
| 2 bytes | 3 Base64 characters + `=`  |
| 1 byte  | 2 Base64 characters + `==` |

Each 3-byte group (24 bits) is divided into four 6-bit groups. Each 6-bit value is used as an index in the Base64 lookup table.

---

## How It Works

### Step-by-Step Encoding & Decoding Flow

#### 1. Convert Input into Bytes

- Convert the input string into UTF-8 bytes using `input.utf8`.
- For images, convert `Data` into a byte array using `Array(imageData)`.

#### 2. Read Bytes in Groups of Three

- Process the input bytes in groups of three using `stride(from:to:by:)`.
- Retrieve each byte using the `getByte()` method.
- If a byte is unavailable, use `0` to complete the group.

#### 3. Combine Bytes

- Combine three bytes into a single 24-bit integer.
- Use bitwise left shifting (`<<`) and OR (`|`) operations.

```swift
(byte1 << 16) | (byte2 << 8) | byte3
```

#### 4. Extract 6-Bit Indexes

- Divide the combined 24-bit integer into four 6-bit groups.
- Use right shifting (`>>`) and AND (`&`) operations.
- Generate four indexes between 0 and 63.

#### 5. Convert Indexes into Base64 Characters

- Use the Base64 lookup table from `BaseUtility.swift`.
- Convert each index into its corresponding Base64 character.
- Add `=` padding when the input contains fewer than three remaining bytes.

#### 6. Decode Base64 Input

- Convert the Base64 string into characters.
- Find the corresponding indexes using the lookup table.
- Treat padding characters (`=`) as zero values during reconstruction.

#### 7. Extract Original Bytes

- Combine four 6-bit indexes into a 24-bit integer.
- Extract the original three bytes using bitwise operations.
- Remove extra bytes based on the padding characters.

#### 8. Reconstruct Original Data

- For text, convert the decoded bytes into a UTF-8 string.
- For images, convert the decoded bytes into `Data`.
- Save the reconstructed image to a file.

---

## Example Walkthrough

**Input Text:**

```text
Hello
```

**Encoding:**

```text
Original Text: Hello
UTF-8 Bytes:   72 101 108 108 111
Binary:        01001000 01100101 01101100 01101100 01101111
```

The bytes are processed in groups of three.

- First group: `72, 101, 108`
- Second group: `108, 111` (one missing byte, so padding is applied).

**Encoded Output:**

```text
SGVsbG8=
```

**Decoding:**

```text
Base64 Input:  SGVsbG8=
Decoded Text:  Hello
```

---

## Image Encoding & Decoding

This project also demonstrates Base64 encoding and decoding using image data.

**Image Processing Flow:**

```text
Sample.jpg
    |
    v
Read Image Data
    |
    v
Convert Image Data into Bytes
    |
    v
Base64 Encoding
    |
    v
Save as imageBase64.txt
    |
    v
Base64 Decoding
    |
    v
Convert Bytes into Data
    |
    v
Save as decodedImage.jpg
```

The decoded image can be compared with the original image to verify that the binary data is preserved.

---

## Technologies & Concepts Used

- **Language:** Swift
- **Framework:** Foundation
- **Data Handling:** Data, UInt8, UTF-8
- **Bitwise Operators:** Left Shift (`<<`), Right Shift (`>>`), AND (`&`), OR (`|`)
- **Collections:** Arrays
- **String Manipulation:** String and Character
- **File Handling:** Data(contentsOf:), write(to:), URL

---

## Learning Outcomes

Through this project, I explored:

- How Base64 encoding and decoding work internally.
- How bytes are grouped and converted into 6-bit indexes.
- How bitwise operators manipulate binary data.
- How padding works in Base64 encoding.
- How Swift handles text and binary data.
- How to encode and reconstruct image files using Base64.

## Author

**Bhoomika M Jain**

Built as a Swift learning project to understand and implement the Base64 encoding and decoding algorithm from scratch.
