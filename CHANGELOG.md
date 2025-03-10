## 0.2.9

- feat: change `Icon icon` to `Widget icon` for more flexibility

## 0.2.8

- feat: add `onTap`

## 0.2.7

- feat: add `maxLines`, `minLines`, and `expands` parameters to `StringField`

## 0.2.6

- chore: update pubspec tags

## 0.2.5

- test: add tests for `StringField`, setup CI
- docs: update README

## 0.2.4

- fix: do not add decimal separator if `decimalDigits` is `0` during user input
- fix: add missing generic type for `BaseNumberField`

## 0.2.3

- feat: add `autofocus` parameter

## 0.2.2

- feat: add `obscureText` and `obscuringCharacter` parameters

## 0.2.1

- feat: add `strutStyle`, `textAlign`, and `textAlignVertical` parameters

## 0.2.0

- feat: optional `onCleared` callback to show a clear button
- feat: add `suggestedDate` and `suggestedTime` to `DateField`, `DateTimeField`, and `TimeField`
- **BREAKING**: move `parser` and `formatter` to `CustomNumberFormat` class
- **BREAKING**: add `onTap` parameter to `builder` function for `DateTimeField`, `DateField`, and `TimeField`

## 0.1.4

- fix: only trigger `onChanged` in `StringField` when the value actually changes

## 0.1.3

- feat: add `DoubleField` `DateField`, `TimeField`, `DateTimeField`
- feat: add optional versions: `OptionalStringField`, `OptionalIntField`, `OptionalDoubleField`
- fix: add missing mounted check

## 0.1.2

- feat: add `InputDecoration` and aliases to constructors

## 0.1.1

- docs: update README.md
- fix: `IntField.onSubmitted` should have `int` as parameter

## 0.1.0

Initial release
