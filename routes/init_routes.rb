class InitRoutes < PhotositeServerBase
  get "/" do
    Photo.select(
      :photos__id,
      :photos__filename,
      :photos__caption,
      :photos__comments,
      :photos__tags,
      :photos__created_at,
      :categories__title___category,
      :categories__hidden___category_hidden,
      :categories__saveable,
      :categories__thumb,
      :categories__slideshowBackColor,
      :categories__slideshowAccentColor,
      :categories__slideshowPlaceholderColor,
      :categories__sliderBackColor,
      :categories__sliderAccentColor,
      :categories__sliderCaptionColor,
      :categories__sliderTextColor,
      :categories__toggleCaption,
      :categories__defaultView,
      :categories__commentsEnabled
    )
    .join(:categories, :id => :category_id)
    .order(:categories__order, :categories__title, :photos__order)
    .all
  end
end
