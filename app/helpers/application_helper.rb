module ApplicationHelper
  def object_id(object)
    "#{object.class.name.underscore}_#{object.id}"
  end
end
