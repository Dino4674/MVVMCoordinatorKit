# MVVMCoordinatorKit

A Swift Kit that helps you with Screen navigation and organizing Screens into reusable coherent flows using a `Coordinator` pattern.

[![CI Status](https://img.shields.io/travis/Dino Bartosak/MVVMCoordinatorKit.svg?style=flat)](https://travis-ci.org/Dino Bartosak/MVVMCoordinatorKit)
[![Version](https://img.shields.io/cocoapods/v/MVVMCoordinatorKit.svg?style=flat)](https://cocoapods.org/pods/MVVMCoordinatorKit)
[![License](https://img.shields.io/cocoapods/l/MVVMCoordinatorKit.svg?style=flat)](https://cocoapods.org/pods/MVVMCoordinatorKit)
[![Platform](https://img.shields.io/cocoapods/p/MVVMCoordinatorKit.svg?style=flat)](https://cocoapods.org/pods/MVVMCoordinatorKit)

## Description

This Kit aims to speed up your development and help you organize screens into coherent flows that are easily reusable using the `Coordinator` pattern, making navigation between screens simple and readable.

This Kit also helps you create `UIViewController` (the `View` in the `MVVM` pattern) and its `ViewModel`. `Model` is not part of this Kit, as it is up to the developers to define their models in the app.

## Requirements

- iOS 13.0+

## Installation

MVVMCoordinatorKit is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'MVVMCoordinatorKit'
```

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Naming Conventions
In a classic `MVVM` pattern:
- `M` is `Model`
- `V` is `View`
- `VM` is `ViewModel`

Since our `Screen` is a `UIViewController`, this Kit uses different naming conventions for `View` because `UIView` is a subview of a `Screen` (`UIViewController`).
- `View` -> `Screen`
- `ViewModel` -> `ScreenModel`

## Templates

## Usage

Main classes of interest:
- `Coordinator` - encapsulates a particular flow of screens and its business logic (e.g. AuthCoordinator, PurchaseCordinator, ProfileCordinator...)
- `Router` - has a reference to `UINavigationController` handles navigation logic (push/pop/present/dismiss)

Each `Coordinator` has its own `Router` which you use to do all the push/pop/present/dismiss calls.

However, base `Coordinator` class has convenience 

Typically if we want to PRESENT flow, we would create a new `Router` with new `UINavigationController`. 



If we want to PUSH flow, we will use the same `Router` from the current parent `Coordinator`

MVVMCoordinatorKit is designed not to depend on any particular bindings implementation. The Example app uses Combine for bindings and in the Example app there is a implementation of Coordinator which uses Combine (`CombineCoordinator`).

## Author

Dino Bartosak, dino.bartosak@gmail.com

## License

MVVMCoordinatorKit is available under the MIT license. See the LICENSE file for more info.
