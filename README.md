# MVVMCoordinatorKit

A Swift Kit that helps you with Screen (`UIViewController`) creation, navigation, and organization into reusable coherent flows using the `MVVM` pattern in combination with the `Coordinator` pattern.

https://github.com/Dino4674/MVVMCoordinatorKit/assets/1395703/760508e3-d3ec-453f-89dd-0869f712cf47

[![Version](https://img.shields.io/cocoapods/v/MVVMCoordinatorKit.svg?style=flat)](https://cocoapods.org/pods/MVVMCoordinatorKit)

## Description

This Kit aims to speed up your development and help you organize Screens into coherent flows that are easily reusable using the `Coordinator` pattern, making navigation between screens simple and readable.

This Kit also helps you create `UIViewController` (the `View` in the `MVVM` pattern) and its `ViewModel`.

`Model` is not part of this Kit, as it is up to the developers to define their models in the app.

**NOTE**: *This README is not meant to describe the ins and outs of the `MVVM` pattern and the evolution from `MVC` to `MVVM`. There are lots of articles online about the `MVVM` and why it is better than `MVC`. If you are reading this README, it is likely that you are already familiar with the `MVVM` and just want a framework that helps you with `MVVM` development.*

## Requirements

- iOS 11.0+
- Swift 5.0+

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

Since Apple forces us through their APIs to use the `MVC` pattern (yes, talking about the `UIViewController`), we are used to naming our custom ViewControllers with the *ViewController* suffix, which does not fit well with the `MVVM` naming conventions. We want to treat `UIViewController` as the `Screen`.

`UIView` in iOS represents a view that is part of a `UIViewController`'s view hierarchy, and we want to treat `UIViewController` as the "main" view -> `Screen`.

Since our `Screen` is a `UIViewController`, this Kit uses different naming conventions for the `View` part of the `MVVM`:
- `View` -> `Screen`
- `ViewModel` -> `ScreenModel`

We can call our `MVVM` the `MSSM` (Model-Screen-ScreenModel).

This is to distinguish between the `UIViewController` and `UIView` file names because in your apps, you are likely to have lots of custom `UIView`s, and you are almost certainly going to append *View* suffix to those custom views. Additionally, when creating a `UIViewController`, you are likely to name it with the *ViewController* suffix, which, as mentioned, does not fit well with the `MVVM` naming conventions. This Kit encourages the usage of the *Screen* suffix for `UIViewController`s.

## Main classes of interest

### `Coordinator<DeepLinkType, ResultType>`
Encapsulates a particular flow of screens and its business logic, with the ability to push/present/setRoot child coordinators.

`Coordinator` has a `ResultType` type which is used to notify its parent `Coordinator` when it is finished with its flow.

It also has a `DeepLinkType`, which you can use to implement deep linking specifically to your app needs. Note that each `Coordinator` that you create in a "coordinators tree" will have to have the exact same concrete implementation of `DeepLinkType` (In 99.99% of cases, this will be an `enum` named `DeepLinkOption`).

### `Router`
Has a reference to `UINavigationController` and handles navigation logic (push/pop/present/dismiss/setRoot/popToRoot). Each `Coordinator` has a reference to one (and only one) `Router`.

### `Screen<ScreenModel>`
A base `UIViewController` with its `ScreenModel`. Each `Screen` is defined with its `ScreenModel`.

### `ScreenModel<Result>`
A `ScreenModel`, coupled with its holding `Screen`. Each `ScreenModel` defines its `Result` type, which is used to notify the `Coordinator` in charge when it produces results worthy of navigation changes.

## Bindings (between `Screen` and `ScreenModel`)

MVVMCoordinatorKit is designed NOT to depend on any particular bindings implementation. The Example app uses `Combine` for bindings between the `Screen` and its `ScreenModel`. You can use `Combine` or any other of your preferred bindings implementation.

## Templates

To reduce the time when creating a particular `Screen + ScreenModel` or `Coordinator`, you can [download](https://github.com/Dino4674/MVVMCoordinatorKit/files/12697636/MVVMCoordinatorKit.zip) custom templates made for this Kit. Move the root extracted folder `MVVMCoordinatorKit` into one of these two folders: 

```
~/Library/Developer/Xcode/Templates
```
```
/Applications/Xcode.app/Contents/Developer/Library/Xcode/Templates/File Templates
```

*NOTE: If you add templates to the 2nd location, they won't survive the Xcode update.*

![269855421-998eb21b-d248-4f69-b031-78d37d26ac00](https://github.com/Dino4674/MVVMCoordinatorKit/assets/1395703/92887417-f7a2-438f-94aa-0a7948a1898e)

With these templates, you can create files more quickly without the need for adding boilerplate code every time.
There are templates for `Screen + ScreenModel` and for `Coordinator`.

Additionally, when using the `Screen + ScreenModel` template you can pick a *View type*:
- *Code*
    - creates a `*Module Name*Screen.swift` WITHOUT a `.xib` file (plus the `*Module Name*ScreenModel.swift`).
- *With XIB*
    - creates a `*Module Name*Screen.swift` WITH a companion `.xib` file (plus the `*Module Name*ScreenModel.swift`).

![268934845-4a9b65c2-7a4c-41e3-9cf2-561ab410089f](https://github.com/Dino4674/MVVMCoordinatorKit/assets/1395703/d8d944dd-d5b4-4fff-85c9-37d4f64a62b0)

Optionally select whether to import `Combine` framework with an example code serving you as a starter point for your `Screen` and `ScreenModel`.

![268934859-aea9591f-5d2e-4fd1-81c8-1e9a572bb11f](https://github.com/Dino4674/MVVMCoordinatorKit/assets/1395703/6dbdd16e-407c-454e-ae66-588e62149f7b)

In the screenshots example above, the template will generate these 3 files:

![268934861-da04e732-39eb-4e09-9050-4b35633c7fa5](https://github.com/Dino4674/MVVMCoordinatorKit/assets/1395703/c984f657-091c-489d-aa8d-16de7be24f6e)

## Usage

The best way to explore MVVMCoordinatorKit is to examine the Example app, which contains all the examples.

### `Coordinator` + `Router`

#### Navigation (Push/Present)

Each `Coordinator` has its own `Router`, which you use to do all the push/pop/present/dismiss calls. However, the `BaseCoordinator` class has convenience functions for `push`, `present`, and `setRoot` `Coordinator`, which automatically handles the release of resources for you when `Screen` is removed from the view stack. It doesn't matter how the `Screen` is removed, all cases are supported for resources autorelease:
- Pushed `Coordinator`
    - *Back* button from `UINavigationController`
    - interactive left-screen-edge pan pop gesture
    - manual call to `router.popModule`
- Presented `Coordinator`
    - interactive top-to-bottom pan dismiss gesture
    - manual call to `router.dismissModule`

```
public func pushCoordinator(_ coordinator: BaseCoordinator, deepLink: DeepLinkType? = nil, animated: Bool = true, onPop: RouterCompletion? = nil)
public func presentCoordinator(_ coordinator: BaseCoordinator, deepLink: DeepLinkType? = nil, animated: Bool = true, onDismiss: RouterCompletion? = nil)
public func setRootCoordinator(_ coordinator: BaseCoordinator, deepLink: DeepLinkType? = nil, animated: Bool = true, onPop: RouterCompletion? = nil)
```

Typically if we want to PRESENT a flow, we would create a new `Router` with a new `UINavigationController`:
```
let navigationController = UINavigationController()
let router = Router(navigationController: navigationController)
let coordinator = ExampleCoordinator(router: router)
presentCoordinator(coordinator)
```

If we want to PUSH a flow, we will use the same `Router` from the current `Coordinator`:
```
let coordinator = ExampleCoordinator(router: router)
pushCoordinator(coordinator)
```

#### Observing child coordinator's results

When a `Coordinator` adds a child `Coordinator` (push, present, doesn't matter), it will need to observe its child results, and it is doing it through this callback:
```
public var finishFlow: ((ResultType) -> ())?
```

`ResultType` is defined in the `Coordinator` class, and it will most likely be some `enum`.

The `Coordinator` template will autogenerate this `enum` for you, ready to be filled with your use cases:

e.g.
```
enum ProfileCoordinatorResult {
    case didLogout
}

class ProfileCoordinator: Coordinator<DeepLinkOption, ProfileCoordinatorResult>
```

```
let coordinator = ProfileCoordinator(router: router)
coordinator.finishFlow = { [weak self] result in
  switch result {
  case .didLogout: // do something here...
    // push or present another flow,
    // or call self?.finishFlow to propagate the event up the tree and let the parent Coordinator decide what to do next
    break
  }
}

pushCoordinator(coordinator)
```

### `Screen` + `ScreenModel`

Each `Screen` needs to define its `ScreenModel`.

e.g.
```
class ProfileScreen: Screen<ProfileScreenModel>
```

#### Instantiate a `Screen` with `ScreenModel`

The `Screen` class has two convenience functions for instantiating a `Screen`:
```
public static func createWithNib(screenModel: T) -> Self // Screen with .xib file
public static func create(screenModel: T) -> Self // in-code Screen
```

If we are using the *Code* template:
```
let screenModel = ProfileScreenModel()
let screen = ProfileScreen.create(screenModel: screenModel)
```

If we are using the *With XIB* template:
```
let screenModel = ProfileScreenModel()
let screen = ProfileScreen.createWithNib(screenModel: screenModel)
```

#### Observing `ScreenModel`'s results

`ScreenModel` needs to define its `Result` type (can be `Void` if not needed), which is needed for its parent `Coordinator` for results observation:

`ProfileScreenModel<MostLikelySomeEnum>`

The `Screen + ScreenModel` template will autogenerate this `enum` for you, ready to be filled with your use cases:

e.g.
```
extension ProfileScreenModel {
    enum Result {
        case didLogout
    }
}

class ProfileScreenModel: ScreenModel<ProfileScreenModel.Result>
```

A parent `Coordinator`, which sets up the `ScreenModel`, will listen for `ScreenModel`'s results through this callback:
```
public var onResult: ((Result) -> Void)?
```

e.g.
```
// We are in ProfileCoordinator here
let screenModel = ProfileScreenModel()
screenModel.onResult = { [weak self] result in
  switch result {
  case .didLogout: self?.finishFlow?(.didLogout)
  }
}
```

#### `ScreenModel` <--> `Screen` bindings

Since this Kit does not depend on any particular bindings implementation, it is up to you which one you want to use. The `Screen + ScreenModel` template will generate two empty `struct`s inside `ScreenModel`, which you can use for the `Screen`'s `input` and `output`:
- `Input`
    - fill with all possible inputs from the view (e.g. `buttonTap`, `swipeGestureActivated`, or any other...)
- `Output`
    - fill with all possible outputs for the view (e.g. `loginButtonTitle`, `screenTitle`, `actionButtonEnabled`, or any other...)

e.g. (Using `Combine`)
```
extension ProfileScreenModel: ScreenModelType {
    struct Input {
        let logout: PassthroughSubject<Void, Never>
    }

    struct Output {
        let screenTitle: AnyPublisher<String?, Never>
        let logoutButtonTitle: AnyPublisher<String?, Never>
    }
}
```

## Logging

A quick note on logging in this Kit. There is an `MVVMCoordinatorKitLogger` class used for debugging this Kit to make sure all resources are properly released.
Logging is disabled by default. You can enable it by calling this (e.g. from `AppDelegate`):

```
MVVMCoordinatorKitLogger.loggingEnabled = true
```

You probably won't need this, as it will just pollute your logs.

## Credits and Sources

This Kit was made possible by a bunch of other people who explored and wrote about Coordinators. This Kit is a combination of ideas from those people.
It is not meant to be perfect, and it will always have space for improvement. Feel free to write suggestions, feature requests, pull requests, or just say Hi!

#### How all of this started:

https://khanlou.com/2015/01/the-coordinator/

https://khanlou.com/2015/10/coordinators-redux/

#### When the first problems arrived (handling Screen removal from the view stack, UINavigationController's back button, and screen-edge gesture):

https://khanlou.com/2017/05/back-buttons-and-coordinators/

#### When the back button problem was solved (with the `Router`):

https://hackernoon.com/coordinators-routers-and-back-buttons-c58b021b32a

*MVVMCoordinatorKit also has an upgrade for interactive dismissal of presented `UIViewController` (sheet) and autorelease of resources, which the original `Router` solution did not support. Additionally, MVVMCoordinatorKit has an upgrade for `setRootModule` and its completion block, which is used for the autorelease of resources.*

#### When somebody put all this together nicely (these two articles and hackernoon article above are the biggest inspiration for MVVMCoordinatorKit):

https://medium.com/blacklane-engineering/coordinators-essential-tutorial-part-i-376c836e9ba7

https://medium.com/blacklane-engineering/coordinators-essential-tutorial-part-ii-b5ab3eb4a74

#### Honorable mentions (not many ideas taken from these two articles, but still a good read if you want to explore the Coordinator pattern):

https://www.hackingwithswift.com/articles/71/how-to-use-the-coordinator-pattern-in-ios-apps

https://www.hackingwithswift.com/articles/175/advanced-coordinator-pattern-tutorial-ios

## Author

Dino Bartosak, dino.bartosak@gmail.com

## License

MVVMCoordinatorKit is available under the MIT license. See the LICENSE file for more info.
