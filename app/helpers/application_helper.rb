module ApplicationHelper

  #define a base title and then add page title if it exists
  def title
  	base_title = "DIG4503 - Sarah Sheehan - Semester Project"

  	if @title.nil?
  		base_title
  	else
  		"#{base_title} | #{@title}"
  	end
  end

end
