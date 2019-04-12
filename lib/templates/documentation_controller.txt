class DocumentationController < ApplicationController

  def index
    @all_routes = get_api_array
    render template: 'documentation/index', layout: 'documentation'
  end

    private

      def get_api_array
        get_api_routes.map { |e| get_api_object(e) }
      end

      def get_api_object route_hash
        {
          method: route_hash[:method],
          route: route_hash[:route],
          params: get_params(route_hash[:route]),
          middleware: ['Not Available'],
          route_header: "text-white bg-#{get_method_color(route_hash[:method])}",
          submit_button_color: "btn btn-outline-#{get_method_color(route_hash[:method])}",
          camel_cased: camelize_route(route_hash),
          allow_params: route_hash[:route].split(':').length > 1,
          allow_body: route_hash[:method] != 'GET',
          description: ['No Description available'],
        }
      end

      def get_method_color method
        lookup = {
          GET: 'success',
          POST: 'info',
          PATCH: 'warning',
          PUT: 'warning',
          DELETE: 'danger',
        }
        lookup[method.to_sym] || 'dark'
      end

      def get_params route
        route.split('/').select { |e| /\:/.match(e) }.map { |e| e.split(':')[1] }
      end

      def camelize_route route
        ApiDocumentationService.camelize_route(route)
      end

      def get_api_routes
        ApiDocumentationService.get_api_routes
      end

end
