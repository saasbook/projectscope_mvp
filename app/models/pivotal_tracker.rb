class PivotalTracker < ActiveRecord::Base
  belongs_to :project
  
  def get_data
    begin
      client = TrackerApi::Client.new(token: ENV['PIVOTAL_TRACKER_TOKEN'])
      project = client.project(self.tracker_id.to_i)
      green, yellow, red, gray = 0, 0, 0, 0
      green += project.stories(with_state: :accepted||:delivered||:finished).size
      yellow += project.stories(with_state: :started).size
      red += project.stories(with_state: :unstarted||:planned).size
      gray += project.stories(with_state: :unscheduled).size
      pt_hash = {done: green, new: yellow, old: red, older: gray, total: green+yellow+red+gray}
    rescue TrackerApi::Error
      pt_hash = {done: -1, new: -1, old: -1, older: -1, total: -1}
    ensure
      self.update_attributes(pt_hash)
    end
  end
  
  def url
      if self.tracker_id
        "https://www.pivotaltracker.com/n/projects/#{self.tracker_id}"
      else
        ''
      end
  end
  
  def message
    if self.total >= 0
      "User stories: #{project.pivotal_tracker.total}"
    else
      "User stories: "
    end
  
  end

end
