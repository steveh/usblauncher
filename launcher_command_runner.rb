class LauncherCommandRunner

  ACCEPTABLE_COMMANDS = [:down, :up, :left, :right, :fire, :zero, :pause]

  def initialize(launcher)
    @launcher = launcher
  end

  def run(lines = [])
    @launcher.zero
    lines.each do |line|
      command, *args = *line

      if ACCEPTABLE_COMMANDS.include?(command.to_sym)
        @launcher.send(command, *args)
      else
        raise ArgumentError, "Unknown command: #{command}"
      end
    end
  end

end
