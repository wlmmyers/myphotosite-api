class Time
  # follow RFC 3339 specifications
  def to_json(options = nil)
    utc.strftime('%FT%TZ').to_json(options)
  end
end
