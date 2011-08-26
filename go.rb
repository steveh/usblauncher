require "rubygems"
require "pp"

require "./launcher.rb"
require "./launcher_command_runner.rb"

launcher = Launcher.new
runner = LauncherCommandRunner.new(launcher)

brad = [
  [:right, 2930],
  [:up,     600],
  [:fire,     1],
]

runner.run(brad)
