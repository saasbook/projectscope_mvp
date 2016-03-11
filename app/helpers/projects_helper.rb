module ProjectsHelper

  def graphic(metric)
    "<div class='graphic'>#{metric.get_data}</div>"
  end

end
