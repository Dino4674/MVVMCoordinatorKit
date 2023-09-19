# MVVMCoordinatorKit

A Swift Kit that helps you with Screen navigation and organizing Screens into reusable coherent flows using a `Coordinator` pattern.

[![CI Status](https://img.shields.io/travis/Dino Bartosak/MVVMCoordinatorKit.svg?style=flat)](https://travis-ci.org/Dino Bartosak/MVVMCoordinatorKit)
[![Version](https://img.shields.io/cocoapods/v/MVVMCoordinatorKit.svg?style=flat)](https://cocoapods.org/pods/MVVMCoordinatorKit)
[![License](https://img.shields.io/cocoapods/l/MVVMCoordinatorKit.svg?style=flat)](https://cocoapods.org/pods/MVVMCoordinatorKit)
[![Platform](https://img.shields.io/cocoapods/p/MVVMCoordinatorKit.svg?style=flat)](https://cocoapods.org/pods/MVVMCoordinatorKit)

## Description

This Kit aims to speed up your development and help you organize screens into coherent flows that are easily reusable using the `Coordinator` pattern, making navigation between screens simple and readable.

This Kit also helps you create `UIViewController` (the `View` in the `MVVM` pattern) and its `ViewModel`.

*`Model` is not part of this Kit, as it is up to the developers to define their models in the app.*

## Requirements

- iOS 13.0+

## Installation

MVVMCoordinatorKit is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'MVVMCoordinatorKit'
```

## Example

To run the example project, clone the repo, and open `Example/MVVMCoordinatorKit.xcworkspace`.

## Naming Conventions

In a classic `MVVM` pattern:
- `M` is `Model`
- `V` is `View`
- `VM` is `ViewModel`

Since our `Screen` is a `UIViewController`, this Kit uses different naming conventions for `View` because `UIView` is a subview of a `Screen` (`UIViewController`).
- `View` -> `Screen`
- `ViewModel` -> `ScreenModel`

We can call our `MVVM` the `MSSM` (Model-Screen-ScreenModel)

## Main classes of interest:

- `Coordinator` - encapsulates a particular flow of screens and its business logic
- `Router` - has a reference to `UINavigationController` and handles navigation logic (push/pop/present/dismiss)
- `Screen` - a base `UIViewController` with its `ScreenModel`
- `ScreenModel`

## Bindings

MVVMCoordinatorKit is designed not to depend on any particular bindings implementation. The Example app uses `Combine` for bindings between the `Screen` and its `ScreenModel`. You can use `Combine` or any other of your preferred bindings.

## Templates

To reduce the time when creating a particular `Screen+ScreenModel` or `Coordinator`, you can [download](https://github.com/Dino4674/MVVMCoordinatorKit/files/12659000/MVVMCoordinatorKit.Screen.%2B.ScreenModel.%2B.Coordinator.zip) custom templates made for this Kit and move them into one of these two folders: 

```
~/Library/Developer/Xcode/Templates
```
```
/Applications/Xcode.app/Contents/Developer/Library/Xcode/Templates/File Templates
```
Move the root extracted folder (`MVVMCoordinatorKit (Screen + ScreenModel + Coordinator)`) into one of these two locations:

*NOTE: If you add templates to the 2nd location, they won't survive the Xcode update.*

![MVVMCoordinator_Templates](https://github.com/Dino4674/MVVMCoordinatorKit/assets/1395703/84bec8cc-d3f1-426b-a378-1b7466161a1e)

With these templates, you can create files more quickly without the need for adding boilerplate code every time.
There are templates for `Coordinator` and for `Screen+ScreenModel` (`MVVM`), and each of them has two versions, *Plain* (no binding framework added) and *Combine* (`Combine` binding imported with added example properties).

Additionally, when using the `MVVM` template (`Screen+ScreenModel`) you can pick a *View type*:
- *Code* - just a `Screen` (`UIViewController`) without a `.xib` file.
- *With XIB* - `Screen` (`UIViewController`) with a companion `.xib` file.

![MVVM_2](https://github.com/Dino4674/MVVMCoordinatorKit/assets/1395703/7d9e5d85-4168-4eec-b04d-390c7812c01d)
![MVVM_1](https://github.com/Dino4674/MVVMCoordinatorKit/assets/1395703/5394d998-cdf6-4798-9331-bf34d00ad039)

**IMPORTANT**:
See the *Bindings* section
If you use the `Coordinator (Combine)` template, you will need to add `CombineCoordinator` file into you project manually.

## Usage

The best way to explore MVVMCoordinatorKit is to examine the Example app, which contains all the examples.

### Coordinator + Router

Each `Coordinator` has its own `Router`, which you use to do all the push/pop/present/dismiss calls. However, the base `Coordinator` class has convenience functions for `push`, `present`, and `setRoot` `Coordinator`, which automatically handles the release of resources for you.

```
public func pushCoordinator(_ coordinator: Coordinator, animated: Bool = true, onPop: RouterCompletion? = nil)
public func presentCoordinator(_ coordinator: Coordinator, animated: Bool = true, onDismiss: RouterCompletion? = nil)
public func setRootCoordinator(_ coordinator: Coordinator, animated: Bool = true, onPop: RouterCompletion? = nil)
```

Typically if we want to PRESENT flow, we would create a new `Router` with a new `UINavigationController`:
```
let navigationController = UINavigationController()
let router = Router(navigationController: navigationController)
let coordinator = ExampleCoordinator(router: router)
presentCoordinator(coordinator)
```

If we want to PUSH flow, we will use the same `Router` from the current `Coordinator`:
```
let coordinator = ExampleCoordinator(router: router)
pushCoordinator(coordinator)
```

### Screen + ScreenModel

Each `Screen` needs to define its `ScreenModel`, e.g.:

```
class ProfileScreen: Screen<ProfileScreenModel>
```

`Screen` class has two convenience functions for instantiating a `Screen`:

```
public static func createWithNib(screenModel: T) -> Self // Screen with .xib file
public static func create(screenModel: T) -> Self // in code Screen
```

If we are using *Code* template:
```
let screenModel = ProfileScreenModel()
let screen = ProfileScreen.create(screenModel: screenModel)
```

If we are using *With XIB* template:
```
let screenModel = ProfileScreenModel()
let screen = ProfileScreen.createWithNib(screenModel: screenModel)
```

## Author

Dino Bartosak, dino.bartosak@gmail.com

## License

MVVMCoordinatorKit is available under the MIT license. See the LICENSE file for more info.
