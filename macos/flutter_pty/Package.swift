// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "flutter_pty",
    platforms: [
        .macOS("10.15")
    ],
    products: [
        // The product name is hyphen separated: Flutter's generated plugin
        // package depends on `.product(name: "flutter-pty", package: "flutter_pty")`.
        .library(name: "flutter-pty", targets: ["flutter_pty"])
    ],
    targets: [
        // FFI plugin: only C sources, no Flutter plugin registration, so the
        // FlutterFramework package dependency is intentionally omitted.
        .target(
            name: "flutter_pty",
            path: "Sources/flutter_pty",
            publicHeadersPath: "include"
        )
    ]
)
