# danger-inspect

Danger plugin for code inspections.

|IntelliJ IDEA|Danger|
|:-:|:-:|
|<img width="588" alt="スクリーンショット 2021-10-10 15 12 11" src="https://user-images.githubusercontent.com/810189/136684847-a191193b-a43c-4a61-a53f-68b92259d8d3.png">|<img width="608" alt="スクリーンショット 2021-10-10 15 21 35" src="https://user-images.githubusercontent.com/810189/136685067-1b832a71-730d-4408-83ef-355b089c19b8.png">


## Installation
```sh
$ gem install danger-inspect
```

## Usage

### Inspect
[Run code inspections from the command line.](https://www.jetbrains.com/help/idea/command-line-code-inspector.html)
```sh
$ idea.sh inspect #{workspace} #{workspace}/inspect.xml /path/to/inspect-result_dir
```
```sh
$ /opt/android-studio/bin/inspect.sh #{workspace} #{workspace}/inspect.xml /path/to/inspect-result_dir
```

### Dangerfile
*Please inspect before danger step.*
```rb
inspect.report 'path/to/inspect-result_dir'
```

## Development

1. Clone this repo
2. Run `bundle install` to setup dependencies.
3. Run `bundle exec rake spec` to run the tests.
4. Use `bundle exec guard` to automatically have tests run as you make changes.
5. Make your changes.
