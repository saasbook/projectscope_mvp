require 'httparty'

repo = 'https://codeclimate.com/github/cal-sfai/submission-site'


def get_data(repo)
    gpa_url = repo + '/badges/gpa.svg'
    cov_url = repo + '/badges/coverage.svg'
    
    
    gpa_stats = parse_data(gpa_url)
    cov_stats = parse_data(cov_url)
    
    puts gpa_stats
    puts cov_stats
end

def parse_data(url)
    response = HTTParty.get(url)
    
    color_regex = /path fill="([^"]+)"\s/
    if response.body =~ color_regex
        color = $1 
    else
        color = nil 
    end
    
    stat_regex = /fill-opacity=".3">.*?fill-opacity=".3">([^<]+)/

    if response.body =~ stat_regex
        stat = $1
    else
        stat = nil
    end
    
    out = {:stat => stat, :color => color}
    
end

get_data(repo)