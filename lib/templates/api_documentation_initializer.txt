Rails.application.config.after_initialize do
  Rails.application.reload_routes!
  ApiDocumentationService.generate_js_file()
end
