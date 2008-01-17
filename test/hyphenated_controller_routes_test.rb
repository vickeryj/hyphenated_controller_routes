require 'test/unit'
require 'rubygems'
require 'active_record'
require 'action_controller'
require File.dirname(__FILE__) + '/../lib/hyphenated_controller_routes'

module ActionController::Routing
  class << self
    def possible_controllers
      ["test_underscore"]
    end
  end
end

class HyphenatedControllerRoutesTest < Test::Unit::TestCase
  def test_add_routes
    routes = ActionController::Routing::Routes
    routes.draw do |map|
      map.add_hyphenated_routes()
    end
    assert routes.routes[0].segments[1].to_s =~ /test-underscore/
  end

  def test_hyphenated_resources
    routes = ActionController::Routing::Routes
    routes.draw do |map|
      map.resources :test_underscore
    end
    routes.routes.each do |route|
      assert route.segments[1].to_s =~ /test_underscore/
    end
    routes.draw do |map|
      map.use_hyphenated_resources()
      map.resources :test_underscore
    end
    routes.routes.each do |route|
      assert route.segments[1].to_s =~ /test-underscore/
    end
  end
end
