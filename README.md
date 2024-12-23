# Advent of Code 2024 in Swift

This is my solutions for Advent of code 2024 in Swift.

[![Language](https://img.shields.io/badge/language-Swift-red.svg)](https://swift.org)

Below is my current advancement in Advent of code:

| Day | Part 1 | Part 2 |
|:---|:---:|:---:|
| Day 1 | :star: | :star: |
| Day 2 | :star: | :star: |
| Day 3 | :star: | :star: |
| Day 4 | :star: | :star: |
| Day 5 | :star: (22min) | :star: (21min) |
| Day 6 | :star: |  |
| Day 7 | :star: (45min) | :star: (33min) |
| Day 8 | :star: (20min) | :star: (16min) |
| Day 9 | :star: (1h51) | :star: (43min) |
| Day 10 | :star: (28min) | :star: (3min) |
| Day 11 | :star: (28min) | :star: (1min) |
| Day 12 | :star: | :star: |
| Day 13 | :star: | :star: (5min) |
| Day 14 | :star: | :star: |
| Day 15 | :star: (1h04) |  |
| Day 16 |  |  |
| Day 17 | :star: |  |
| Day 18 |  |  |
| Day 19 |  |  |
| Day 20 |  |  |
| Day 21 |  |  |
| Day 22 |  |  |
| Day 23 |  |  |
| Day 24 |  |  |

## Out of order fun moments

A collection of moments I want to remember.

### When I finally saw the Christmas tree of day 14

![day 14 tree](./assets/day14-tree.png)

<details>
<summary>How to use this repo</summary>

Daily programming puzzles at [Advent of Code](https://adventofcode.com/), by
[Eric Wastl](http://was.tl/). This is a small example starter project for
building Advent of Code solutions.

## Usage

Swift comes with Xcode, or you can [install it](https://www.swift.org/install/)
on a supported macOS, Linux, or Windows platform.

If you're using Xcode, you can open this project by choosing File / Open and
select the parent directory.

If you prefer the command line, you can run the test suite with `swift test`,
and run the output with `swift run`.

If you're using Visual Studio Code to edit, you might find these Swift
extensions useful:

- [Swift](https://marketplace.visualstudio.com/items?itemName=sswg.swift-lang)
  (provides core language edit / debug / test features)
- [apple-swift-format](https://marketplace.visualstudio.com/items?itemName=vknabel.vscode-apple-swift-format)
  (supports the [swift-format](https://github.com/apple/swift-format) package)

## Challenges

The challenges assume three files (replace 00 with the day of the challenge).

- `Sources/Data/Day00.txt`: the input data provided for the challenge
- `Sources/Day00.swift`: the code to solve the challenge
- `Tests/Day00.swift`: any unit tests that you want to include

To start a new day's challenge, make a copy of these files, updating 00 to the
day number.

```diff
// Add each new day implementation to this array:
let allChallenges: [any AdventDay] = [
-  Day00()
+  Day00(),
+  Day01(),
]
```

Then implement part 1 and 2. The `AdventOfCode.swift` file controls which challenge
is run with `swift run`. Add your new type to its `allChallenges` array. By default
it runs the most recent challenge.

The `AdventOfCode.swift` file controls which day's challenge is run
with `swift run`. By default that runs the most recent challenge in the package.

To supply command line arguments use `swift run AdventOfCode`. For example,
`swift run -c release AdventOfCode --benchmark 3` builds the binary with full
optimizations, and benchmarks the challenge for day 3.

## Linting and Formatting

Challenge source code can be linted and formatted automatically using the
included dependency on `swift-format`.

Lint source code with the following command:

```shell
swift package lint-source-code
```

Format source code with the following command:

```shell
$ swift package format-source-code
Plugin ‘Format Source Code’ wants permission to write to the package directory.
Stated reason: “This command formats the Swift source files”.
Allow this plugin to write to the package directory? (yes/no)
```

To avoid the interactive prompt when formatting source code, use the
`--allow-writing-to-package-directory` flag.

```shell
swift package format-source-code --allow-writing-to-package-directory
```

swift-format will use the built-in default style to lint and format code. A
`.swift-format` configuration file can be used to customize the style used, see
[Configuration](https://github.com/apple/swift-format/blob/main/Documentation/Configuration.md)
for more details.
</details>
