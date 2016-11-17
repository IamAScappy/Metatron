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

## Usage

To open a MPEG media file for reading and writing:
```swift
do
{
    // Open the MPEG media from file path

    let media = try MPEGMedia(fromFilePath: "sample.mp3", readOnly: false)

    // Use MPEGMedia(fromData: [UInt8], readOnly: Bool) to load from memory


    // Get MPEG properties

    print("Version: " + String(describing: media.version))
    print("Layer: " + String(describing: media.layer))

    print("Duration: " + String(media.duration))

    print("Bit rate: " + String(media.bitRate))
    print("Sample rate: " + String(describing: media.sampleRate))

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
Metatron and its assets are released under the [Apache Version 2.0 License](LICENSE.md)
