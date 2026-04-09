# Godot State Provider

A Godot 4 addon that implements a **Provider/Consumer pattern** for state management. It lets you define state machines as gdscript classes and inject them into your scene tree (no singletons required).

## Requirements

- Godot 4.6+

## Core Concepts

### Value

`Value` is the base class for everything state related. Each subclass has a unique type identifier derived from its script name, which is used to locate the matching provider in the scene tree.

### State

`State` extends `Value` and adds two lifecycle hooks:

```gdscript
func _on_enter() -> void: pass
func _on_exit() -> void: pass
```

### StateMachine

`StateMachine` holds the current `State` and emits `state_changed` when the state transitions. It validates that only compatible state types are accepted and calls `_on_exit` / `_on_enter` automatically. Processors are a special type of state machine that also forward `_physics_process`, `_process`, and `_draw` to the active state's hooks, explained in the [`StateProcessor`](#stateprocessor) section.

## Nodes

### Providers

Providers instantiate a `Value` and make it available to all descendant nodes. They can be used directly in the scene tree without subclassing. Set the exported script property and add the node.

#### Provider

Set the `value_script` export to any `Value` subclass. When a consumer lower in the tree requests that type, it will receive the instance this node holds.

```
RootNode
  └── Provider (value_script = MyStateMachine)
        └── ... (any descendant can consume this)
```

#### StateProvider

A `Provider` specialised for `StateMachine` subclasses. Prefer this over the raw `Provider` when providing state machines, as it ensures the value is initialised as a `StateMachine`.

#### MultiProvider / StateMultiProvider

Accepts an array of scripts and automatically nests a `Provider` (or `StateProvider`) for each one, so a single node can provide multiple values to its children.

```
StateMultiProvider (scripts = [PlayerStateMachine, InventoryStateMachine])
  └── (children can consume both state machines independently)
```

---

### Consumers

Consumers walk up the scene tree to find the nearest `Provider` ancestor matching a given type and return its value. Unlike providers, **consumers are not useful on their own** you should extend them and override their hooks to add behaviour.

#### Consumer

The base consumer. For a quick setup just override `default_script_factory` and return the type of value you require from a provider, then call `get_value()` to retrieve it. For more complex use cases, override `_init`.

```gdscript
class_name MyConsumer extends Consumer

func default_script_factory() -> Script:
    return CustomValue

func do_something() -> void:
    var value: CustomValue = get_value()
```

#### StateConsumer

A `Consumer` specialised for `StateMachine` values. Extend this when you need access to a state machine.

#### StateListener

A `Consumer` that automatically connects to the state machine's `state_changed` signal. Extend it and override `_on_state_changed` to react to state transitions.

```gdscript
class_name NavigationListener extends StateListener

func _init() -> void:
    super._init(func() -> Script: return NavigationStateMachine)

func _on_state_changed(state: State) -> void:
    if state.is_type(NavigationState.Menu):
        # load menu scene
```

---

### Processor

#### ProcessorState / ProcessorStateMachine

`ProcessorState` extends `State` with `_physics_process`, `_process`, and `_draw` hooks that receive a reference to the processor node. `ProcessorStateMachine` delegates these calls to the active state.

```gdscript
class_name PlayerStateMachine extends ProcessorStateMachine

func _physics_process(delta: float, processor: PlayerProcessor) -> void:
	if Input.get_vector("move_left", "move_right", "move_up", "move_down") != Vector2.ZERO:
		set_state(PlayerState.Move.new())
	super._physics_process(delta, processor)
```

```gdscript
class_name PlayerState extends ProcessorState
		
class Move extends PlayerState:
	func _physics_process(_delta: float, _processor: PlayerProcessor) -> void:
		var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
		_processor.player.velocity = direction * _processor.SPEED
		_processor.player.move_and_slide()
```

#### StateProcessor

A `Consumer` whose `_physics_process`, `_process`, and `_draw` are forwarded to the active `ProcessorState`. Extend it and use the `_state_physics_process`, `_state_process`, and `_state_draw` callbacks to run logic on the processor node from within a state, or put the logic directly on the state class itself. Example provided in the included example project.

```gdscript
class_name PlayerProcessor extends StateProcessor

func _init() -> void:
    _value_container = ValueContainer.new(PlayerStateMachine.new())
```

## Example

The included example (`example/`) demonstrates two patterns:

**Navigation** - A `StateProvider` holds a `NavigationStateMachine`. A `StateListener` subclass reacts to navigation state changes and swaps scenes.

**Player** - A `StateProcessor` subclass drives a `PlayerStateMachine`. Movement logic lives inside the `PlayerState.Move` class and receives the processor as context, keeping state logic self contained.

## License

See [LICENSE.txt](LICENSE.txt).
