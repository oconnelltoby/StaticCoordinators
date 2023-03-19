// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Core",
    platforms: [
        .iOS("15.0"),
    ],
    products: [
        .library(name: "Initial", targets: ["Initial"]),
        .library(name: "Navigation", targets: ["Navigation"]),
        .library(name: "Analytics", targets: ["Analytics"]),
        .library(name: "Color", targets: ["Color"]),
        .library(name: "Number", targets: ["Number"]),
        .library(name: "Alphabet", targets: ["Alphabet"]),
        .library(name: "AnalyticsMocks", targets: ["AnalyticsMocks"]),
        .library(name: "NavigationMocks", targets: ["NavigationMocks"]),
    ],
    dependencies: [],
    targets: [
        .target(name: "Navigation"),
        .target(name: "Analytics"),
        .target(name: "Initial", dependencies: ["Color", "Number", "Alphabet", "Navigation", "Analytics"]),
        .target(name: "Color", dependencies: ["Navigation", "Analytics", "Number"]),
        .target(name: "Number", dependencies: ["Navigation", "Analytics"]),
        .target(name: "Alphabet", dependencies: ["Navigation", "Analytics"]),
        
        .target(name: "AnalyticsMocks", dependencies: ["Analytics"]),
        .target(name: "NavigationMocks", dependencies: ["Navigation"]),

        .testTarget(name: "ColorTests", dependencies: ["Color", "AnalyticsMocks", "NavigationMocks"]),
        .testTarget(name: "NumberTests", dependencies: ["Number", "AnalyticsMocks", "NavigationMocks"]),
        .testTarget(name: "AlphabetTests", dependencies: ["Alphabet", "AnalyticsMocks", "NavigationMocks"]),
        .testTarget(name: "InitialTests", dependencies: ["Initial", "AnalyticsMocks", "NavigationMocks"]),
    ]
)
