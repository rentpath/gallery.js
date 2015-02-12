
# gallery.js
A reusable gallery component.
Implemented as FlightJS components in Coffeescript.

[Read the component API documentation.](API.md)

## Using gallery in an application.

- Add the appropriate line to bower.json
- Update the path section of the application's requirejs config. For rails, this is probably config/requirejs.yml.
```
  "gallery": "gallery/dist"
```

## Getting started for development.
```
git checkout dev
git pull origin dev
git checkout -b my_branch
npm run preversion
```

## A basic red-green-refactor workflow.

```
npm install
npm run watch
npm run watch:test # in another terminal window or pane
```

## Examples of common tasks.

npm script commands are defined in the scripts section of package.json.
To see a full list of available npm commands, run:

```
npm run
```

### Install Node and Bower components.

```
npm install
```

### One-time compile of application source and tests.

```
npm run compile
```

### Compile application source & tests and build the distribution when files change.

```
npm run watch
```

### Running Tests.

One time.

```
npm test
```

Watch continuously and run tests when code or specs change.

```
npm run watch:test
```

### Cleaning

Remove compiled code and tests in .tmp/.

```
npm run clean
```

Remove compiled code and tests, node_modules/ and app/bower_components/

```
npm run clean:all
```

Remove compiled code, tests, node_modules/ and app/bower_components/; reinstall
node modules and bower components; recompile code and tests.

```
npm run reset
```

### Demo App

Start a demo app on localhost

```
npm run start
```

### Building a Distribution

To build a distribution and tag it, run one of the following commands.

```
npm version patch -m "Bumped to %s"
npm version minor -m "Bumped to %s"
npm version major -m "Bumped to %s"
```

There's a 'preversion' script in package.json that does the following:
  - Remove the .tmp/ directory.
  - Remove the node_modules and app/bower_components directories.
  - Install all npm and bower packages.
  - Compile the application source and specs.
  - Run the tests.
  - Remove the dist/ directory and rebuild the distribution.

Just build a distribution.

```
npm run build
```

## Notes
  - The dist/ directory must be part of the repo - don't gitignore it!

