heartbeat_root = File.expand_path(File.dirname(__FILE__))
require heartbeat_root + "/application"
require heartbeat_root + "/test_application"

app = Rack::Builder.app do
  map "/test" do
    # env["PATH_INFO"] equals "/200" once within Application
    run Heartbeat::Application
  end

  map "/" do
    run Heartbeat::TestApplication
  end
end

run app
