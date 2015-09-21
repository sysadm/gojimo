module QualificationsHelper
  def star_color(color)
    (color.blank? or color.nil?) ? "white" : color
  end
end
