require "net/http"

module ProjectsHelper

    # url_string must be a full http url
    def url_exist?(url_string)
      url = URI.parse(url_string)
      req = Net::HTTP.new(url.host, url.port)
      req.use_ssl = (url.scheme == 'https')
      path = url.path if url.path.present?
      res = req.request_head(path || '/')
      if res.kind_of?(Net::HTTPRedirection)
        url_exist?(res['location']) # Go after any redirect and make sure you can access the redirected URL 
      else
        ! %W(4 5).include?(res.code[0]) # Not from 4xx or 5xx families
      end
    rescue Errno::ENOENT, SocketError
      false #false if can't find the server
    end
    
    # Return entire github http string
    # repo_name format: USER/PROJECT
    # Assumes valid repo_name format
    def github_url(repo_name)
      "https://github.com/#{repo_name}"
    end

end
