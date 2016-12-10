class API < PhotositeServerBase
  map("/init") { run InitRoutes.new }
end
