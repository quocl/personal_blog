module ApplicationHelper
  def sortable(column, title = nil)
    title ||= column.titleize
    direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
    link_to title, :sort => column, :direction => direction
  end
  
  def display_tags(tag_list)
    # Display the tag list of a model in a nice way
    raw tag_list.map{|t| link_to t.name, tag_path(t.name)}.join(", ")
  end
end
