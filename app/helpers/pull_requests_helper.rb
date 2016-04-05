module PullRequestsHelper
  
  def pull_request_graphic(metric)
    data = metric.get_data
    total_prs = data.values.sum
    data.each do |color, value|
      data[color] = value.to_f / total_prs
    end
    graph = "<div class='pull_request_graphic'>"
    graph << pr_color_block(data, :red)
    graph << pr_color_block(data, :yellow)
    graph << pr_color_block(data, :green)
    graph << "</div>"
    return graph
  end
  
  def pr_color_block(data, color)
    "<div id = 'pr' style = 'height: #{(data[color]*100).round}px; background: #{color};'></div>"
  end
end
