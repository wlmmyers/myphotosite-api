class API < PhotositeServerBase
  map("/init") { run InitRoutes.new }
  map("/users") { run UserRoutes.new }
end
