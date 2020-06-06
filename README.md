### About

Elm Sandbox is a boilerplate repo for spinning up toy projects. It is essentially a dev environment wrapped around the [buttons](https://elm-lang.org/examples/buttons) example from the Elm documentation. The emphasis of this project is on learning and ease of use for beginners.

### Prerequisites

Elm Sandbox assumes the following binaries are installed on your system...
- elm
- elm-format
- elm-test
- elm-live

If you don't already have them, install them with...
```
npm install -g elm elm-format elm-test elm-live
```

### Getting Started

Elm Sandbox is setup to use npm as a script runner. Just run `npm run`...
- `dev` - this will open your browser with your application running and the browser will be reloaded after any code changes
- `build` - this will compile your Elm code in `src/Main.elm` to `main.js`
- `serve` - this will use elm reactor to server your application, but the dev script is more convenient
- `format` - this will use elm-format to format everything in `src`
- `test` - this will run all tests in the `tests` directory

### Future Improvements

- Install husky to run tests, format code, etc. on git commits
- Write a couple tests (unit and fuzz)
- Consider upgrading from the buttons example to something more feature-rich, like TodoMVC
  - Might need to rename to something like "Elm Scratchpad" if we ditch Browser.sandbox
