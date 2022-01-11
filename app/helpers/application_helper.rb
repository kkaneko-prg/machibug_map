module ApplicationHelper
  def page_title(page_title = '')
    base_title = '街バグmap | machibug_map'
    page_title.empty? ? base_title : "#{page_title} | #{base_title}"
  end
end
