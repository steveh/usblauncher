require "./launcher.rb"
$LAUNCHER = Launcher.new

require "sinatra"

class LauncherServer < Sinatra::Base

  get "/" do
    File.open("index.html", "r").read
  end

  get "/left/:duration" do
    duration = params[:duration].to_i || 1000

    $LAUNCHER.left(duration)
  end

  get "/right/:duration" do
    duration = params[:duration].to_i || 1000

    $LAUNCHER.right(duration)
  end

  get "/up/:duration" do
    duration = params[:duration].to_i || 1000

    $LAUNCHER.up(duration)
  end

  get "/down/:duration" do
    duration = params[:duration].to_i || 1000

    $LAUNCHER.down(duration)
  end

  get "/fire" do
    projectiles = 1

    $LAUNCHER.fire(projectiles)
  end

  get "/fire/:projectiles" do
    projectiles = params[:projectiles].to_i || 1

    $LAUNCHER.fire(projectiles)
  end

end
