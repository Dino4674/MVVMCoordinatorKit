# MVVMCoordinatorKit

A Swift Kit that helps you with Screen (`UIViewController`) creation, navigation, and organization into reusable coherent flows using `MVVM` pattern in combination with `Coordinator` pattern.

[![CI Status](https://img.shields.io/travis/Dino Bartosak/MVVMCoordinatorKit.svg?style=flat)](https://travis-ci.org/Dino Bartosak/MVVMCoordinatorKit)
[![Version](https://img.shields.io/cocoapods/v/MVVMCoordinatorKit.svg?style=flat)](https://cocoapods.org/pods/MVVMCoordinatorKit)
[![License](https://img.shields.io/cocoapods/l/MVVMCoordinatorKit.svg?style=flat)](https://cocoapods.org/pods/MVVMCoordinatorKit)
[![Platform](https://img.shields.io/cocoapods/p/MVVMCoordinatorKit.svg?style=flat)](https://cocoapods.org/pods/MVVMCoordinatorKit)

## Description

This Kit aims to speed up your development and help you organize Screens into coherent flows that are easily reusable using the `Coordinator` pattern, making navigation between screens simple and readable.

This Kit also helps you create `UIViewController` (the `View` in the `MVVM` pattern) and its `ViewModel`.

*`Model` is not part of this Kit, as it is up to the developers to define their models in the app.*

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

Since our `Screen` is a `UIViewController`, this Kit uses different naming conventions for `View` part of the `MVVM`.

`UIView` in iOS represents a view that is part of a `UIViewController`'s view hierarchy, and we want to treat `UIViewController` as the 'main' view --> `Screen`.

So changes in namings are these:
- `View` -> `Screen`
- `ViewModel` -> `ScreenModel`

We can call our `MVVM` the `MSSM` (Model-Screen-ScreenModel)

This is to distinguish between the `UIViewController` and `UIView` file names because in your apps, you are likely to have lots of custom `UIView`s, and you are almost certainly going to append *View* suffix to those custom views. Additionally, when creating a `UIViewController`, you are likely to name it with the *ViewController* suffix, which does not fit well with the `MVVM` naming conventions. We want to treat `UIViewController` as the `Screen`.

## Main classes of interest:

- `Coordinator` (inherits from `BaseCoordinator`) - encapsulates a particular flow of screens and its business logic
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

![Screenshot 2023-09-19 at 12 59 53](https://github.com/Dino4674/MVVMCoordinatorKit/assets/1395703/e60cfebc-e87b-4791-8e3d-7dde07bb93fc)

With these templates, you can create files more quickly without the need for adding boilerplate code every time.
There are templates for `Coordinator` and for `Screen+ScreenModel`.

Additionally, when using the `Screen+ScreenModel` template you can pick a *View type*:
- *Code* - just a `*Module Name*Screen.swift` (`UIViewController`) without a `.xib` file.
- *With XIB* - `*Module Name*Screen.swift` (`UIViewController`) with a companion `.xib` file.

Optionally select whether to import `Combine` framework with an example code serving you as a starter point for your `Screen` and `ScreenModel`.

![MVVM-1](https://github.com/Dino4674/MVVMCoordinatorKit/assets/1395703/4a9b65c2-7a4c-41e3-9cf2-561ab410089f)
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
