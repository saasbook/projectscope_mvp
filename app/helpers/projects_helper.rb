module ProjectsHelper

  def graphic(metric)
    "<div class='graphic'>#{metric.get_data}</div>" if metric
  end

end
