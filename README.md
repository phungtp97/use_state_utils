
# UseStateMixin for Flutter

`UseStateMixin` simplifies the management of Flutter resources such as `AnimationController`, `StreamSubscription`, `Timer`, and `ValueNotifier` in your `StatefulWidget`. It helps reduce boilerplate code by managing the lifecycle of these resources automatically. This plugin is inspired from `flutter_hooks` and `obx` from `get`

## Features

- **Lifecycle Management**: Ensures proper creation and disposal of resources.
- **Reduced Boilerplate**: Less code to manage animations, streams, timers, and value notifiers.
- **Ease of Use**: Simplifies common tasks into single method calls.
- **Customizable**: Easy to integrate your custom disposable components to mixin life-cycle
- **Less code**: Write less code, more efficiency. Let us dispose the resources for you.

## Visual Example

### useNotifier<V>
![screenshot](https://i.imgur.com/HxdGO06.png)

### usePeriodicTimer

![screenshot](https://i.imgur.com/nKgKwdt.png)

### useStreamSubscription
![screenshot](https://i.imgur.com/9WW3TfX.png)

### useAnimationController
![screenshot](https://i.imgur.com/ivbW9fK.png)

## Getting Started

To use this mixin in your Flutter application, follow these steps:

### Installation

Add `use_state_utils` to your Flutter project by adding the following line to your `pubspec.yaml`:

```yaml  
dependencies:  
 use_state_utils:   
 ```
Then, run `flutter pub get` to install the package.

### Usage Example

Here is a quick example of using `UseStateMixin` with an `AnimationController`:
```  
class _MyAnimatedWidgetState extends State<MyAnimatedWidget> with TickerProviderStateMixin, UseStateMixin<MyAnimatedWidget> {  
 late AnimationController _controller;  
 @override void initState() { super.initState(); _controller = useAnimationController(key: 'anim1', duration: const Duration(seconds: 2), vsync: this); _controller.forward(); }  
 @override Widget build(BuildContext context) { return FadeTransition( opacity: _controller, child: const Center(child: Text('Hello, World!')), ); }}  
```

## API

### `useNotifier<V>`

-   **Description**: Creates an `AnimationController` with specified `duration` and `vsync`.
-   **Parameters**:
    -   `key`: `String` key of UseStateScene.
    -   `initialValue`: `V` of the animation.


### `useAnimationController`

-   **Description**: Creates an `AnimationController` with specified `duration` and `vsync`.
-   **Parameters**:
    -   `key`: `String` key of UseStateScene.
    -   `duration`: `Duration` of the animation.
    -   `vsync`: `TickerProvider` for the controller.

### `useStreamSubscription`

-   **Description**: Manages a `StreamSubscription`.
-   **Parameters**:
    -   `key`: `String` key of UseStateScene.
    -   `stream`: The stream to subscribe to.
    -   `onData`: Callback for data events.

### `useTextEditingController`

-   **Description**: Manages a `StreamSubscription`.
-   **Parameters**:
    -   `key`: `String` key of UseStateScene.
    -   `text`: `String?` initial value.

### `useTimer` and `usePeriodicTimer`

-   **Description**: Manages a single-shot or periodic timer.
-   **Parameters**:
    -   `key`: `String` key of UseStateScene.
    -   `duration`: `Duration` between timer ticks or until the timer fires.
    -   `callback`: Function to execute when the timer ticks or fires.

### `useCustomScene<R>`

-   **Description**: Manages a `Custom Disposable Components`.
-   **Parameters**:
    -   `key`: `String` key of UseStateScene.
    -   `createHandler`: The R object creation function.
    -   `disposeHandler`: Callback to dispose the object inside this UseStateScene.

## Contributing

Contributions are welcome! Feel free to submit pull requests or open issues to discuss potential improvements.