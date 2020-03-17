[![codebeat badge](https://codebeat.co/badges/efd4eaaa-1fec-4fda-a775-bb1064bcea1a)](https://codebeat.co/projects/github-com-luanachen-awesomebeers-master)

# AwesomeBeers
- Studying project with +80% test coverage.

## Requirements

- iOS 11.0+
- Xcode 10.2+
- Swift 5.0
- Carthage 0.34.0+

## QuickStart

### How to run the project

This project uses [Carthage](https://github.com/Carthage/Carthage) as a dependency manager of choice. The dependencies are not included in the project so you need open this folder in Terminal and run the following command:

```sh
carthage bootstrap --platform ios
```

## Architecture

When possible, AwesomeBeers follows MVVM-C architecture. View controllers send events to the coordinator by using the delegate pattern and networking session stored in a interface using Facade pattern.

## Project structure

The whole project is structured in modules where each module represents one screen in the app. Each module consists of one `*ViewController`, `*ViewModel`, and a `*view` file.

All the other files are structured in their particular category, e.g. `Model`, `Networking`, `Extensions`, etc.

## Testing

The project has a few unit and UI tests implemented. The tests are written using the standart `XCTest` framework and are mainly focused on JSON parsing. You can run the tests by simply pressing `CMD+U` in Xcode.

# Contact

- Luana Chen
- luanachen@gmail.com
- https://www.linkedin.com/in/luanachen/
