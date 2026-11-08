// swift-tools-version:6.0
import PackageDescription

let binaryBaseURL = "https://github.com/dooop/vlc-player/releases/download/0.6.0/"

let package = Package(
  name: "swift-vlc-player",
  defaultLocalization: "en",
  platforms: [
    .macOS(.v15), .iOS(.v18), .tvOS(.v18),
  ],
  products: [
    .library(
      name: "VLC",
      targets: ["VLC"]
    ),
    .library(
      name: "VLCPlayer",
      targets: ["VLCPlayer"]
    ),
  ],
  dependencies: [],
  targets: [
    .target(
      name: "VLC",
      dependencies: [
        .target(name: "VLCKit", condition: .when(platforms: [.macOS])),
        .target(name: "MobileVLCKit", condition: .when(platforms: [.iOS])),
        .target(name: "TVVLCKit", condition: .when(platforms: [.tvOS])),
      ],
      path: "swift/Sources/VLC",
      linkerSettings: [
        .linkedFramework("QuartzCore", .when(platforms: [.iOS])),
        .linkedFramework("CoreText", .when(platforms: [.iOS, .tvOS])),
        .linkedFramework("AVFoundation", .when(platforms: [.iOS, .tvOS])),
        .linkedFramework("Security", .when(platforms: [.iOS])),
        .linkedFramework("CFNetwork", .when(platforms: [.iOS])),
        .linkedFramework("AudioToolbox", .when(platforms: [.iOS, .tvOS])),
        .linkedFramework("OpenGLES", .when(platforms: [.iOS, .tvOS])),
        .linkedFramework("CoreGraphics", .when(platforms: [.iOS])),
        .linkedFramework("VideoToolbox", .when(platforms: [.iOS, .tvOS])),
        .linkedFramework("CoreMedia", .when(platforms: [.iOS, .tvOS])),
        .linkedLibrary("c++", .when(platforms: [.iOS, .tvOS])),
        .linkedLibrary("xml2", .when(platforms: [.iOS, .tvOS])),
        .linkedLibrary("z", .when(platforms: [.iOS, .tvOS])),
        .linkedLibrary("bz2", .when(platforms: [.iOS, .tvOS])),
        .linkedFramework("Foundation", .when(platforms: [.macOS])),
        .linkedLibrary("iconv"),
      ]
    ),
    .target(
      name: "VLCPlayer",
      dependencies: ["VLC"],
      path: "swift/Sources/VLCPlayer",
      resources: [.process("UI/Resources")]
    ),
    .testTarget(
      name: "VLCTests",
      dependencies: ["VLC"],
      path: "swift/Tests/VLCTests"
    ),
    .testTarget(
      name: "VLCPlayerTests",
      dependencies: ["VLCPlayer"],
      path: "swift/Tests/VLCPlayerTests"
    ),
    .binaryTarget(
      name: "VLCKit",
      url: "\(binaryBaseURL)VLCKit.xcframework.zip",
      checksum: "1595bd3c795d05e3bd37d2fd8da1b9d187878713eade023388c422049e6e5ad2"
    ),
    .binaryTarget(
      name: "MobileVLCKit",
      url: "\(binaryBaseURL)MobileVLCKit.xcframework.zip",
      checksum: "7c6ddf153702a07c44a5680eed9a990866776575ff7f2c4e0bba8af3caee2712"
    ),
    .binaryTarget(
      name: "TVVLCKit",
      url: "\(binaryBaseURL)TVVLCKit.xcframework.zip",
      checksum: "97f780ab1b77de31ee88db3cea687c3745579106be69d33be760c0d6aef7b54d"
    ),
  ]
)
