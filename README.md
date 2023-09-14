# MVVMCoordinatorKit

A Swift Kit that helps you with Screen navigation and organizing Screens into reusable coherent flows using a `Coordinator` pattern.

[![CI Status](https://img.shields.io/travis/Dino Bartosak/MVVMCoordinatorKit.svg?style=flat)](https://travis-ci.org/Dino Bartosak/MVVMCoordinatorKit)
[![Version](https://img.shields.io/cocoapods/v/MVVMCoordinatorKit.svg?style=flat)](https://cocoapods.org/pods/MVVMCoordinatorKit)
[![License](https://img.shields.io/cocoapods/l/MVVMCoordinatorKit.svg?style=flat)](https://cocoapods.org/pods/MVVMCoordinatorKit)
[![Platform](https://img.shields.io/cocoapods/p/MVVMCoordinatorKit.svg?style=flat)](https://cocoapods.org/pods/MVVMCoordinatorKit)

## Description

This Kit aims to speed up your development and help you organize screens into coherent flows that are easily reusable using `Coordinator` pattern, making navigation between screens simple and readable.

This Kit also helps you with the creation of `UIViewController` (the `View` in `MVVM` pattern) and its `ViewModel`. `Model` is not part of this Kit, as it is up to the developers to define their own models in the app.

## Naming Conventions
In a classic `MVVM` pattern:
- `M` is `Model`
- `V` is `View`
- `VM` is `ViewModel`

Since our `Screen` is actually a `UIViewController`, this Kit uses different naming conventions for `View` because `UIView` is actually a subview of a `Screen` (`UIViewController`).
- `View` -> `Screen`
- `ViewModel` -> `ScreenModel`


## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

MVVMCoordinatorKit is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'MVVMCoordinatorKit'
```

## Author

Dino Bartosak, dino.bartosak@gmail.com

## License

MVVMCoordinatorKit is available under the MIT license. See the LICENSE file for more info.
