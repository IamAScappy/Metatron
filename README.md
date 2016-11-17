# Metatron
## Description:
Metatron is a Swift framework that edits meta-information of audio files. Currently it supports:

**Tags:**
- ID3v1 Tag (v1.0, v1.1, vExt1.0, vExt1.1)
- ID3v2 Tag (v2.2, v2.3, v2.4)
- Lyrics3 Tag (v1.0, v2.0)
- APE Tag (v1.0, v2.0)

**Formats:**
- MPEG (MP3, v1.0 layers I-II, v2.0 layers I-III, v2.5 layers I-III)

## Installation

### Compatibility

- Platforms:
    - macOS 10.10+
    - iOS 8.0+
    - watchOS 2.0+
    - tvOS 9.0+
- Xcode 8.0
- Swift 3.0

### Install Using CocoaPods
[CocoaPods](https://cocoapods.org/) is a centralized dependency manager for
Objective-C and Swift. Go [here](https://guides.cocoapods.org/using/index.html)
to learn more.

1. Add the project to your [Podfile](https://guides.cocoapods.org/using/the-podfile.html).

    ```ruby
    use_frameworks!

    pod 'Metatron', '~> 1.0.0'
    ```

    If you want to be on the bleeding edge, replace the last line with:

    ```ruby
    pod 'Metatron', :git => 'https://github.com/almazrafi/Metatron.git'
    ```

2. Run `pod install` and open the `.xcworkspace` file to launch Xcode.

3. Import the Metatron framework.

    ```swift
    import Metatron
    ```

## License
Metatron and its assets are released under the [Apache Version 2.0 License](LICENSE.md)
