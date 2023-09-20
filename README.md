# MVVMCoordinatorKit

A Swift Kit that helps you with Screen (`UIViewController`) creation, navigation, and organization into reusable coherent flows using the `MVVM` pattern in combination with the `Coordinator` pattern.

[![CI Status](https://img.shields.io/travis/Dino Bartosak/MVVMCoordinatorKit.svg?style=flat)](https://travis-ci.org/Dino Bartosak/MVVMCoordinatorKit)
[![Version](https://img.shields.io/cocoapods/v/MVVMCoordinatorKit.svg?style=flat)](https://cocoapods.org/pods/MVVMCoordinatorKit)
[![License](https://img.shields.io/cocoapods/l/MVVMCoordinatorKit.svg?style=flat)](https://cocoapods.org/pods/MVVMCoordinatorKit)
[![Platform](https://img.shields.io/cocoapods/p/MVVMCoordinatorKit.svg?style=flat)](https://cocoapods.org/pods/MVVMCoordinatorKit)

## Description

This Kit aims to speed up your development and help you organize Screens into coherent flows that are easily reusable using the `Coordinator` pattern, making navigation between screens simple and readable.

This Kit also helps you create `UIViewController` (the `View` in the `MVVM` pattern) and its `ViewModel`.

`Model` is not part of this Kit, as it is up to the developers to define their models in the app.

**NOTE**: *This README is not meant to describe the ins and outs of the `MVVM` pattern and the evolution from `MVC` to `MVVM`. There are lots of articles online about the `MVVM` and why it is better than `MVC`. If you are reading this README, it is likely that you are already familiar with the `MVVM` and just want a framework that helps you with `MVVM` development.*

## Requirements

- iOS 10.0+

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
- `M` stands for `Model`
- `V` stands for `View`
- `VM` stands for `ViewModel`

Since Apple forces us through their APIs to use the `MVC` pattern (yes, I am talking about the `UIViewController`), we are used to naming our custom ViewControllers with the *ViewController* suffix, which does not fit well with the `MVVM` naming conventions. We want to treat `UIViewController` as the `Screen`.

`UIView` in iOS represents a view that is part of a `UIViewController`'s view hierarchy, and we want to treat `UIViewController` as the 'main' view -> `Screen`.

Since our `Screen` is a `UIViewController`, this Kit uses different naming conventions for the `View` part of the `MVVM`:
- `View` -> `Screen`
- `ViewModel` -> `ScreenModel`

We can call our `MVVM` the `MSSM` (Model-Screen-ScreenModel)

This is to distinguish between the `UIViewController` and `UIView` file names because in your apps, you are likely to have lots of custom `UIView`s, and you are almost certainly going to append *View* suffix to those custom views. Additionally, when creating a `UIViewController`, you are likely to name it with the *ViewController* suffix, which, as mentioned, does not fit well with the `MVVM` naming conventions.

## Main classes of interest

### `Coordinator<DeepLinkType, CoordinatorOutput>`
Encapsulates a particular flow of screens and its business logic, with the ability to push/present/setRoot child coordinators.

`Coordinator` has a `CoordinatorOutput` type which is used to notify its parent `Coordinator` when it is finished with its flow.

It also has a `DeepLinkType`, which you can use to implement deep linking specifically to your app needs. Note that each `Coordinator` that you create in a "coordinators tree" will have to have the exact same concrete implementation of `DeepLinkType` (In 99.99% of cases, this will be an `enum` named `DeepLinkOption`).

### `Router`
Has a reference to `UINavigationController` and handles navigation logic (push/pop/present/dismiss/setRoot). Each `Coordinator` has a reference to one `Router`.

### `Screen<ScreenModel>`
A base `UIViewController` with its `ScreenModel`. Each `Screen` is defined with its `ScreenModel`.

### `ScreenModel<Result>`
A `ScreenModel`, coupled with its holding `Screen`. Each `ScreenModel` defines its `Result` type, which is used to notify the `Coordinator` in charge when it produces results worthy of navigation changes.

## Bindings (between `Screen` and `ScreenModel`)

MVVMCoordinatorKit is designed NOT to depend on any particular bindings implementation. The Example app uses `Combine` for bindings between the `Screen` and its `ScreenModel`. You can use `Combine` or any other of your preferred bindings implementation.

## Templates

To reduce the time when creating a particular `Screen+ScreenModel` or `Coordinator`, you can [download](https://github.com/Dino4674/MVVMCoordinatorKit/files/12659000/MVVMCoordinatorKit.Screen.%2B.ScreenModel.%2B.Coordinator.zip) custom templates made for this Kit. Move the root extracted folder `MVVMCoordinatorKit (Screen + ScreenModel + Coordinator)` into one of these two folders: 

```
~/Library/Developer/Xcode/Templates
```
```
/Applications/Xcode.app/Contents/Developer/Library/Xcode/Templates/File Templates
```

*NOTE: If you add templates to the 2nd location, they won't survive the Xcode update. I prefer adding all my custom templates to the 1st location.*

![Screenshot 2023-09-19 at 12 59 53](https://github.com/Dino4674/MVVMCoordinatorKit/assets/1395703/e60cfebc-e87b-4791-8e3d-7dde07bb93fc)

With these templates, you can create files more quickly without the need for adding boilerplate code every time.
There are templates for `Screen+ScreenModel` and for `Coordinator`.

Additionally, when using the `Screen+ScreenModel` template you can pick a *View type*:
- *Code*
    - creates a `*Module Name*Screen.swift` WITHOUT a `.xib` file (plus the `*Module Name*ScreenModel.swift`).
- *With XIB*
    - creates a `*Module Name*Screen.swift` WITH a companion `.xib` file (plus the `*Module Name*ScreenModel.swift`).

![MVVM-1](https://github.com/Dino4674/MVVMCoordinatorKit/assets/1395703/4a9b65c2-7a4c-41e3-9cf2-561ab410089f)

Optionally select whether to import `Combine` framework with an example code serving you as a starter point for your `Screen` and `ScreenModel`.

![MVVM-2](https://github.com/Dino4674/MVVMCoordinatorKit/assets/1395703/aea9591f-5d2e-4fd1-81c8-1e9a572bb11f)

In the screenshots example above, template will generate these 3 files:

![MVVM-3](https://github.com/Dino4674/MVVMCoordinatorKit/assets/1395703/da04e732-39eb-4e09-9050-4b35633c7fa5)

## Usage

The best way to explore MVVMCoordinatorKit is to examine the Example app, which contains all the examples.

### Coordinator + Router

Each `Coordinator` has its own `Router`, which you use to do all the push/pop/present/dismiss calls. However, the `BaseCoordinator` class has convenience functions for `push`, `present`, and `setRoot` `Coordinator`, which automatically handles the release of resources for you.

```
public func pushCoordinator(_ coordinator: BaseCoordinator, deepLink: DeepLinkType? = nil, animated: Bool = true, onPop: RouterCompletion? = nil)
public func presentCoordinator(_ coordinator: BaseCoordinator, deepLink: DeepLinkType? = nil, animated: Bool = true, onDismiss: RouterCompletion? = nil)
public func setRootCoordinator(_ coordinator: BaseCoordinator, deepLink: DeepLinkType? = nil, animated: Bool = true, onPop: RouterCompletion? = nil)
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

When a `Coordinator` adds a child `Coordinator` (push, present, doesn't matter), it will need to observe its child results, and it is doing it through this callback:
```
public var finishFlow: ((CoordinatorOutput) -> ())?
```

`CoordinatorOutput` is defined in `Coordinator` class and it will most likely be some `enum`:

```
enum ProfileCoordinatorResult {
    case didLogout
}

class ProfileCoordinator: Coordinator<DeepLinkOption, ProfileCoordinatorResult>
```

e.g.
```
let coordinator = ExampleCoordinator(router: router)
coordinator.finishFlow = { [weak self] coordinatorOutput in
  switch coordinatorOutput {
  case .someCaseOfYour-MostLikelySomeEnum
  }
}

pushCoordinator(coordinator)
```

### Screen + ScreenModel

Each `Screen` needs to define its `ScreenModel`, e.g.:
```
class ProfileScreen: Screen<ProfileScreenModel>
```

`ScreenModel` needs to define its `Result` type (can be `Void` if not needed), which is needed for its parent `Coordinator` for results observation:

`ProfileScreenModel<MostLikelySomeEnum>`

`Screen` class has two convenience functions for instantiating a `Screen`:
```
public static func createWithNib(screenModel: T) -> Self // Screen with .xib file
public static func create(screenModel: T) -> Self // in-code Screen
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

A parent `Coordinator`, which sets up the `ScreenModel` will listen for `ScreenModel` results through this callback:
```
public var onResult: ((Result) -> Void)?
```

e.g.
```
let screenModel = ProfileScreenModel()
screenModel.onResult = { [weak self] result in
  switch result {
  case .someCaseOfYour-MostLikelySomeEnum
  }
```

## Author

Dino Bartosak, dino.bartosak@gmail.com

## License

MVVMCoordinatorKit is available under the MIT license. See the LICENSE file for more info.
