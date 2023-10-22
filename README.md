
<img src="https://github.com/emresoysuren/app_manager/blob/main/readme-assets/app_manager.png?raw=true" style="display: block; margin-left: auto; margin-right: auto;">

<p align="center">
  <a href="https://pub.dev/packages/app_manager">
    <img src="https://img.shields.io/badge/pub-v0.1.0-%237f7eff?style=flat&logo=flutter">
  </a>
  <a href="https://github.com/emresoysuren/app_manager">
    <img src="https://img.shields.io/badge/GitHub-v0.1.0-%237f7eff?style=flat&logo=github">
  </a>
</p>

# Flutter App Manager (app_manager)

**Flutter App Manager** is a `lightweight` Flutter package that `simplifies` the `customization` of Flutter apps.

Some of the things you can achieve with this package include:

- Easy management of your app's `theme`, allowing you to create custom themes.
- Convenient management of your app's `language` settings.

And much more...

Explore the [Example App](https://github.com/emresoysuren/app_manager/tree/main/example) to see practical usage examples.

# Table of Contents
- [Flutter App Manager (app_manager)](#flutter-app-manager-app_manager)
- [Getting Started](#getting-started)
  - [Creating Cores](#creating-cores)
    - [Creating a Core](#creating-a-core)
      - [1. The `modes` Getter](#1-the-modes-getter)
      - [2. The `defaultMode` Getter](#2-the-defaultmode-getter-the-modes-getter)
      - [3. Binding Utilities with Cores](#3-binding-utilities-with-cores-the-modes-getter)
    - [Creating a Style Core](#creating-a-style-core)
  - [Connecting the AppManager to Your App](#connecting-the-appmanager-to-your-app)
    - [Using AppManagerConfig](#using-appmanagerconfig)
    - [Using AppManagerScope](#using-appmanagerscope)
  - [Using Cores](#using-cores)
    - [Accessing Cores](#accessing-cores)
    - [Changing a Core's Mode](#changing-a-cores-mode)
  - [Creating Custom Utilities](#creating-custom-utilities)

# Getting Started

From this point onward, this article will provide a comprehensive, step-by-step guide covering everything you need to know about utilizing the `app_manager` package.

## Creating Cores

The `app_manager` package utilizes subunits known as `cores`. You can envision a `core` as a mode handler. It stores modes and enables the app to use the currently active mode. This mode is changeable and can respond to system changes.  

### Creating a Core

Creating a `core` is just simple as extening a class. To create a core just extend the `AppManagerCore` class.

```dart
class YourCore extends AppManagerCore {}
```

The `AppManagerCore` requires 3 overrides.

#### 1. The `modes` Getter

The `modes` getter is where the `AppManagerCore` stores its modes. Each `mode` consists of a key and a value, therefore modes are stored in a map. The `key` of a mode is defined as an `enum` and is referred to as the `mode key`, while the value of a mode is a model referred to as the `mode model`.

To create your `mode keys`, define an enum, and for your `mode models`, create a model class. 

```dart
enum YourCoreModes {
  mode1,
  mode2,
  mode3,
}
```

```dart
class YourCoreModel {
  final String yourString;

  YourCoreModel({
    required this.yourString,
  });
}
```

Following that, you can create your modes by using the `mode key` you've created as the `key`, and the corresponding model as the `value` within the `modes` map.

```dart
class YourCore extends AppManagerCore {
  @override
  Map<YourCoreModes, YourCoreModel> get modes => {
        YourCoreModes.mode1: YourCoreModel(
          yourString: "mode1 strig",
        ),
        YourCoreModes.mode2: YourCoreModel(
          yourString: "mode2 strig",
        ),
        YourCoreModes.mode3: YourCoreModel(
          yourString: "mode3 strig",
        ),
      };
}
```

Now that you've created modes for your core, before we proceed further, there is one more step to complete. We must always utilize the `generics` of the `AppManagerCore` class. The `AppManagerCore` class contains two generic fields: the first one should correspond to the `mode key` enum, and the second one should correspond to the `mode module` class you've created.

```dart
class YourCore extends AppManagerCore<YourCoreModes, YourCoreModel> {
  @override
  Map<YourCoreModes, YourCoreModel> get modes => {
        YourCoreModes.mode1: YourCoreModel(
          yourString: "mode1 strig",
        ),
        YourCoreModes.mode2: YourCoreModel(
          yourString: "mode2 strig",
        ),
        YourCoreModes.mode3: YourCoreModel(
          yourString: "mode3 strig",
        ),
      };
}
```

#### 2. The `defaultMode` Getter

The `defaultMode` getter is used when no modes are stored locally. Therefore, set the `mode key` of the mode you want to use as the default mode.

The `defaultMode` must exist as a `mode key` in the `modes` map. 

*Note: Its usage changes when the core is bound to an utility.*

```dart
class YourCore extends AppManagerCore<YourCoreModes, YourCoreModel> {
  @override
  YourCoreModes get defaultMode => YourCoreModes.mode1;

  @override
  Map<YourCoreModes, YourCoreModel> get modes => {
        YourCoreModes.mode1: YourCoreModel(
          yourString: "mode1 strig",
        ),
        YourCoreModes.mode2: YourCoreModel(
          yourString: "mode2 strig",
        ),
        YourCoreModes.mode3: YourCoreModel(
          yourString: "mode3 strig",
        ),
      };
}
```

#### 3. Binding Utilities with Cores

A utility acts as a middleman between the core and the system. Utilities listen the system and inform the core about the system's mode.

The core uses the system's mode if a utility is provided, and only if the current mode matches the provided `system mode` while the utility is being provided.

The core searches for a mode that matches the system's mode. During this search, the core compares the names of the `mode keys`, and if it finds a mode that matches the string returned from the utility as the `system mode`, it uses that mode.

To bind a utility with a core, you should override the `util` getter of the core. The `util` getter takes an `AppManagerUtilOptions` class, which has two parameters. The `util` parameter accepts an instance of the `AppManagerUtil`, while the `system` parameter takes a `mode key`.

The `mode key` provided to the `system` parameter is not just an ordinary `mode key`. This `mode key` serves as the `system mode key`, and for this reason, it must not be used in the `modes` map or as the `default mode`. The `system mode key` still allows the core to use a mode just like a regular `mode key`, even if it doesn't exist in the `modes` map. Instead of providing only one mode, it adapts and changes its mode depending on the system's mode. The mode chosen depending on the system's mode will be one of the `modes` provided by you. If the `core` finds a matching mode, it will use that mode. However, if it cannot find a mode that matches the `system's mode`, it will use the `default mode` instead.

Lastly, the core prefers to use the `system mode` over the `default mode` when no modes are stored locally. You can disable the use of the `system mode` instead of the `default mode` by setting the `useSystemAsDefault` getter to `false`. By default, it is set to `true`.

You can provide either built-in or your own custom utilities to the `util` getter. We will cover creating your own custom utilities in the [Creating Custom Utilities](#creating-custom-utilities) chapter. As for the built-in utilities, we have the following options:
- `AppManagerUtil.theme` or `AppManagerThemeUtil`
- `AppManagerUtil.lang` or `AppManagerLangUtil`

The `AppManagerUtil.theme` binds the core to the `system's theme mode`. It looks for a `mode key` (enum) named as `dark` if the system uses dark mode, or as `light` if it uses light mode. Just as explained earlier, these two modes must exist in the `modes` map; otherwise, the `default mode` will be used in place of a non-existing mode.

The `AppManagerUtil.lang` binds the core to the `system's language mode`. It searches for a `mode key` named as the `language code` of the current language. You can find the language codes in the [IANA Language Subtag Registry](https://www.iana.org/assignments/language-subtag-registry/language-subtag-registry).

Now, let's apply what we've covered in this chapter so far. First, we need to add an enum value to our `mode key` enum that we won't use in the `modes` map. This enum will serve as our `system mode key`.

```dart
enum YourCoreModes {
  system, // Adding this to use as the `system mode key`, we call it as system in our example but you can name it whatever you want.
  mode1,
  mode2,
  mode3,
}
```

Following that, when we provide an `AppManagerUtilOptions` to the `util` parameter of the core, with our `system mode key` set as the value for the `system` parameter, and the utility we wish to use as the `util` parameter's value getter, we are finished.

```dart
class YourCore extends AppManagerCore<YourCoreModes, YourCoreModel> {
  @override
  AppManagerUtilOptions<YourCoreModes>? get util => AppManagerUtilOptions(
        util: AppManagerUtil.<util>, // Utility you want to use.
        system: YourCoreModes.system, // The enum value you created to use as a system mode key.
      );

  @override
  YourCoreModes get defaultMode => YourCoreModes.mode1;

  @override
  Map<YourCoreModes, YourCoreModel> get modes => {
        YourCoreModes.mode1: YourCoreModel(
          yourString: "mode1 strig",
        ),
        YourCoreModes.mode2: YourCoreModel(
          yourString: "mode2 strig",
        ),
        YourCoreModes.mode3: YourCoreModel(
          yourString: "mode3 strig",
        ),
      };
}
```

You also have the option to use the `useSystemAsDefault` getter and set its value to `false` if you prefer to use the `default mode` when no modes are stored locally.

```dart
class YourCore extends AppManagerCore<YourCoreModes, YourCoreModel> {
  @override
  AppManagerUtilOptions<YourCoreModes>? get util => AppManagerUtilOptions(
        util: AppManagerUtil..<util>,
        system: YourCoreModes.system,
      );

  @override
  YourCoreModes get defaultMode => YourCoreModes.mode1;

  @override
  YourCoreModes get useSystemAsDefault => false; // The `default mode` will be used instead.

  @override
  Map<YourCoreModes, YourCoreModel> get modes => {
        YourCoreModes.mode1: YourCoreModel(
          yourString: "mode1 strig",
        ),
        YourCoreModes.mode2: YourCoreModel(
          yourString: "mode2 strig",
        ),
        YourCoreModes.mode3: YourCoreModel(
          yourString: "mode3 strig",
        ),
      };
}
```

### Creating a Style Core

A `style core` functions similarly to a regular class. You can access its values, methods, and getters. In addition to these, a style core rebuilds the widget it's used in, and it also enables you to access the cores without the need for a context using its `core` method.

Creating a `style core` is even easier than creating a regular core. To create a style core, simply extend the `AppManagerStyleCore` class.

```dart
class YourStyleCore extends AppManagerStyleCore {}
```

That's all there is to it. Now you can use it just like a regular class, with the added features it provides. For example, let's access the `YourCore` core we created earlier.

```dart
class YourStyleCore extends AppManagerStyleCore {
  YourCore get yourCoreCurrentMode => core<YourCore>().current; // Returns the currently active mode (You will learn more about accessing to cores later.)
}
```

## Connecting the AppManager to Your App

Now that we've created our cores, it's important for our app to be aware of them. The `AppManagerScope` facilitates access to its cores for the widgets under it, and we configure it by specifying an `AppManagerConfig` as its `config` parameter's value. Therefore, let's begin by discussing how to use the `AppManagerConfig`.

### Using AppManagerConfig

To create a config just extend the `AppManagerConfig` class.

```dart
class YourConfig extends AppManagerConfig {}
```

Now, you can configure the cores that you intend to use in your app. These cores will only function if they are included in the list provided to the `cores` getter. Attempting to use a core that is not included in the `cores` list will result in an error.

```dart
class YourConfig extends AppManagerConfig {
  @override
  List<AppManagerBaseCore>? get cores => [
        YourCore(),
        YourStyleCore(),
      ];
}
```

### Using AppManagerScope

The final step before using your cores is to ensure that you place the `AppManagerScope` above the location where you intend to access your cores. We recommend placing it above the `MaterialApp` widget to ensure that all pages can access it. Once you've done that, pass the config class you created to the `config` parameter. With that, you're all set to begin using your cores within your app.

```dart
void main() {
  runApp(const YourApp());
}

class YourApp extends StatelessWidget {
  const YourApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AppManagerScope(
      config: YourConfig(), /// Use your config here
      child: const MaterialApp(),
    );
  }
}
```

## Using Cores

Now, let's explore how you can use your cores within your app.

### Accessing Cores

Accessing your cores is simple. You can either call the `core` method of the `AppManager` class or use the `core` method from the `context` extension.

Accessing cores using `AppManager`:
```dart
AppManager.core<YourCore>(context);
```

Accessing cores using `context`:
```dart
context.core<YourCore>();
```

As mentioned earlier, `style cores` are similar to regular classes, and as such, you can use their getters, methods, or variables along with additional features. For instance, when a core's mode is updated, they will rebuild the widget they were called from. This is because their values might change as well.

```dart
context.core<YourStyleCore>().<yourGetter>;
```

To access the currently active mode of a core, use its `current` getter.

```dart
context.core<YourCore>().current;
```

It will provide access to the fields of the `mode model` of the currently active mode.

```dart
context.core<YourCore>().current.yourString; // Accessing the `yourString` field of the currently active mode's YourCoreModel (mode model).
```

### Changing a Core's Mode

To change the mode of a core, call its `changeMode` method and provide the `mode key` of the desired mode you want to switch to.

```dart
context.core<YourCore>().changeMode(YourCoreModes.mode2);
```

After that, when you call the `current` method of the core, you will access the new `mode model` instead.

```dart
context.core<YourCore>().current; // Now you will access the mode model of the `YourCoreModes.mode2`.
```

If you wish to either "save" or "not save" the current mode locally, you can use the `saveChanges` argument of the `changeMode` method. This argument is optional, and its default value is set to `true`.

*This might be useful if you want to show a preview of a mode.*

```dart
context.core<YourCore>().changeMode(YourCoreModes.yourMode, false); // This mode won't be saved locally and the last saved mode will be used when the app starts again.
```

## Creating Custom Utilities