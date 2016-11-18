<p align="center">
    <img src="https://img.shields.io/cocoapods/p/Metatron.svg?style=flat"
         alt="Platform">

    <img src="https://img.shields.io/badge/language-swift-orange.svg"
         alt="Language: Swift">

    <a href="https://cocoapods.org/pods/Metatron">
        <img src="https://img.shields.io/cocoapods/v/Metatron.svg"
             alt="CocoaPods Compatible">
    </a>

    <a href="https://github.com/Carthage/Carthage">
        <img src="https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat"
             alt="Carthage Compatible">
    </a>

    <img src="https://img.shields.io/github/license/almazrafi/metatron.svg"
         alt="License">
</p>

<p align="center">
    <a href="#installation">Installation</a>
    <a href="#usage">Usage</a>
    <a href="#license">License</a>
</p>

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

### CocoaPods
[CocoaPods](https://cocoapods.org/) is a centralized dependency manager for Objective-C and Swift projects. Go [here](https://guides.cocoapods.org/using/index.html) to learn more.

1. Add the project to your [Podfile](https://guides.cocoapods.org/using/the-podfile.html).

    ```ruby
    use_frameworks!

    target '<Your Target Name>' do
        pod 'Metatron'
    end
    ```

2. Run `pod install` and open the `.xcworkspace` file to launch Xcode.

3. Import the Metatron framework.

    ```swift
    import Metatron
    ```

### Swift Package Manager
The [Swift Package Manager](https://swift.org/package-manager/) is a decentralized dependency manager for Swift projects.

1. Add the project to your `Package.swift`.

    ```swift
    import PackageDescription

    let package = Package(
        name: "YourProjectName",
        dependencies: [
            .Package(url: "https://github.com/almazrafi/Metatron.git", majorVersion: 1)
        ]
    )
    ```

2. Import the Metatron framework.

    ```swift
    import Metatron
    ```

### Carthage
[Carthage](https://github.com/Carthage/Carthage) is a decentralized dependency manager for Objective-C and Swift projects.

1. Add the project to your [Cartfile](https://github.com/Carthage/Carthage/blob/master/Documentation/Artifacts.md#cartfile).

    ```
    github "almazrafi/Metatron"
    ```

2. Run `carthage update` and follow [the additional steps](https://github.com/Carthage/Carthage#getting-started) in order to add framework to your project.

3. Import the Metatron framework.

    ```swift
    import Metatron
    ```

## Usage
To open a MPEG media file for reading and writing:

```swift
do {
    // Open the MPEG media from file path

    let media = try MPEGMedia(fromFilePath: "sample.mp3", readOnly: false)

    // Use MPEGMedia(fromData: [UInt8], readOnly: Bool) to load from memory


    // Get MPEG properties

    print("Version: " + String(describing: media.version))
    print("Layer: " + String(describing: media.layer))

    print("Duration (seconds): " + String(media.duration / 1000.0))

    print("Bit rate: " + String(media.bitRate))
    print("Sample rate: " + String(media.sampleRate))

    print("Channels: " + String(media.channels))

    print("Bit rate mode: " + String(describing: media.bitRateMode))
    print("Channel mode: " + String(describing: media.channelMode))


    // Get Tag information

    print("Title: " + media.title)
    print("Artists: " + media.artists.joined(separator: " & "))

    print("Album: " + media.album)
    print("Genres: " + media.genres.joined(separator: "/"))

    print("Release date: " + String(describing: media.releaseDate))

    print("Track number: " + String(describing: media.trackNumber))
    print("Disc number: " + String(describing: media.discNumber))

    let coverArtImage = UIImage(data: Data(media.coverArt.data))

    print("Copyrights: " + media.copyrights.joined(separator: "\n"))
    print("Comments: " + media.comments.joined(separator: "\n"))

    print("Lyrics: " + String(describing: media.lyrics))


    // Write Tag information

    media.title = "Title"
    media.artists = ["Artist"]

    media.album = "Album"
    media.genres = ["Genre"]

    media.releaseDate = TagDate(year: 2016, month: 11, day: 17)

    media.trackNumber = TagNumber(3, total: 4)
    media.discNumber = TagNumber(1)

    if let newCoverArtImage = UIImage(contentsOfFile: "sample.png") {
        if let pngRepresentation = UIImagePNGRepresentation(newCoverArtImage) {
            media.coverArt = TagImage(data: [UInt8](pngRepresentation))
        }
    }

    media.copyrights = ["Copyright"]
    media.comments = ["Comment"]

    media.lyrics = TagLyrics(pieces: [TagLyrics.Piece("Lyrics text piece", timeStamp: 1230)])


    // Save the information to the mp3 file

    if !media.save() {
        print("The file is corrupted and cannot be saved or it is read only.")
    }

} catch MediaError.invalidFormat {
    print("The file is not an MPEG file.")

} catch MediaError.invalidFile {
    print("The file does not exist.")

} catch MediaError.invalidData {
    print("The file or data is empty.")

} catch {
    print("Unknown error")
}
```

## License
Metatron and its assets are released under the [Apache Version 2.0 License](LICENSE)
