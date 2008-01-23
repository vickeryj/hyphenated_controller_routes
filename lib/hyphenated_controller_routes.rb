module ActionController
  module Routing
    class RouteSet
      class Mapper
        UNDERSCORE_PATTERN = /^[^_]+?(_[^_]+)+?$/
        def add_hyphenated_routes

          controller_dir = File.join(RAILS_ROOT, 'app/controllers')
          controllers = []
          Dir.chdir(controller_dir) do
            controllers = Dir["*_controller.rb"].map{|c| c.sub(/\_controller.rb$/,'')}
          end

          controllers.each do |controller|
            if controller =~ UNDERSCORE_PATTERN
              @set.add_named_route(controller, 
                "/#{ controller.gsub(/_/,'-')}/:action/:id", :controller => controller)
            end
          end
        end

        def use_hyphenated_resources
          Resources::Resource.send(:define_method, :path) do
            @path ||= "#{path_prefix}/#{plural.to_s.gsub(/_/,'-')}"
          end
        end
      end
    end
  end

end


