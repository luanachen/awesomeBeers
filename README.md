[![Build Status](https://app.bitrise.io/app/5b5ae8059712cc92/status.svg?token=RIj8ZHbymZBLZhGJnDloZw&branch=master)](https://app.bitrise.io/app/5b5ae8059712cc92)

# AwesomeBeers
## Requirements

- iOS 11.0+
- Xcode 10.1+
- Swift 4.2
- Carthage 0.32.0+

## QuickStart

### How to run the project

This project uses [Carthage](https://github.com/Carthage/Carthage) as a dependency manager of choice. The dependencies are not included in the project so you need open this folder in Terminal and run the following command:

```sh
carthage bootstrap --platform ios
```

## Architecture

When possible, AwesomeBeers follows MVVM-C architecture. View controllers send events to the coordinator by using the delegate pattern.

## Project structure

The whole project is structured in modules where each module represents one screen in the app. Each scene consits of one `*ViewController`, `*ViewModel`, and a `*view` file.

All the other files are structured in their particular category, e.g. `Model`, `Networking`, `Extensions`, etc.

## Testing

The project has a few unit and UI tests implemented. The tests are written using the standart `XCTest` framework and are mainly focused on JSON parsing. You can run the tests by simply pressing `CMD+U` in Xcode.

# Contact

- Luana Chen
- luanachen@gmail.com
- https://www.linkedin.com/in/luanachen/
