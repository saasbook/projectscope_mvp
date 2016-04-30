# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

projectscope = Project.create(name: "ProjectScope")
projectscope.create_pull_request(repo: "dhhxu/projectscope")
projectscope.create_slack_metric(slack_api_token: ENV['SLACK_API_TOKEN'])
projectscope.create_code_climate_metric(url: "https://codeclimate.com/github/dhhxu/projectscope")
projectscope.create_pivotal_tracker(tracker_id: '1542709')
projectscope.create_slack_trend(slack_api_token: ENV['SLACK_API_TOKEN'])

project_data = [
  ['One Circle Foundation', 'arifeuer/cs169ocf', '1543433'],
  ['Berkeley Student Cooperative', 'momochanfitz/coop-workshift-app', '1545105'],
  ['CityDogShare', 'abhishek776/cds-prof-services', '1540217'],
  ['Trinity Health', 'ProvidenceXz/Trinity-Health', '1544149'],
  ['CSUA', 'lillianchou94/csua169', '1544819'],
  ['Cal Dining', 'veersuvrat/CalDining-169', '1546341'],
  ['Course Question Bank', 'jshoe/coursequestionbank', '1544183'],
  ['Effective Altruists of Berkeley (Giving Game)', 'kimjunh/giver-game', '1544779'],
  ['RateMyPup', 'cjzcpsyx/rate-my-pup', '1542559'],
  ['One Eighty Degrees Consulting', 'fununloaded/One_Eighty_Degrees_Consulting', '1545635'],
  ['ClassMap', 'dannyighsu/ucb-senior-map', '1543413'],
  ['SmileyGo', 'piccoloman/cs169-smileygo', '1546147'],
  ['Nature in the City', 'Nature-in-the-City/Nature_Calendar', '1540479'],
  ['PigeonPalomacy', 'bicro/PigeonPalomacy', '1546011'],
  ['SFCESS Job Portal', 'charleslee94/CESS-Job_Portal', '1545543'],
  ['Shift Scheduler', '', ''],
  ['Great Course Guide', 'sophiazheng/CS169_Great_Course_Guide', '1541787'],
  ['Bernal Heights App', 'candychang/bernal-heights', '1543993'],
  ['Boys Hope Girls Hope', 'dianhua1560/bhgh', '1543373'],
  ['California Preservation Foundation', 'ydong/places-initiative', ''],
  ['Maitri Compassionate Care', 'nhironaka/maitri-app', '1547099'],
  ['Mak', 'lenawu/mak-169', '1542641'],
  ['Congregation B\'nah Emunah', 'TheXienator/Congregation-Bnai-Emunah/', '1545153'],
  ['Environmental Science Associates', 'zhawtof/ESA169', '1548917'],
  ['Richmond Main Street Initiative', 'mmpollard/RMSIVendorRegApp', '1540861'],
  ['CommunityGrows', 'aneeshvaidya/communitygrows', '1541793'],
  ['Thera', 'Thera169/thera', '1545429'],
  ['Espolea', 'ESheahan/espolea', '1545907'],
  ['CodeandoMexico', 'UCB-ITESM/codeandomexico.org', '1548747'],
  ['Debate Society of Berkeley', 'SwordElucidator/American-parliamentary-debate-society', '1541745'],
  ['Project Hermione', 'pragaashp/hermione-app', '1546067'],
  ['SafeSpace', 'hendolim/countonanon', '1543989'],
  ['AFX Dance', 'amylwong/AFX-Dance', '1543479'],
  ['Harmony Plus', 'xyixyi/harmony-plus', '1544921'],
  ['Engineers Without Borders', 'carmentang/engineerswithoutborders', '1546415'],
  ['Wherewoof', 'lawrencechanyewlong/wherewolfpro', '1546107']
]

project_data.each do |name, repo, tid|
  proj = Project.create(name: name)
  proj.create_pull_request(repo: repo)
  proj.create_pivotal_tracker(tracker_id: tid)
  proj.create_slack_metric(slack_api_token: '')
  proj.create_slack_trend(slack_api_token: '')
  
  code_climate_url = "https://codeclimate.com/github/#{repo}"
  if repo == ""
    code_climate_url = ""
  end
  proj.create_code_climate_metric(url: code_climate_url)
  
  # num_slack_users = 5 + rand(2)
  # rand_msg_counts = num_slack_users.times.map{ rand(200) }
  # rand_msg_counts.each do |count|
  #   rand_name = (0...8).map { (65 + rand(26)).chr }.join
  #   proj.slack_metric.slack_data_points.create(user: rand_name, messages: count)
  # end

  # st_array = 3.times.map{Random.rand(50..100)}
  # proj.create_slack_trend(weekone: st_array[0], weektwo: st_array[1], weekthree: st_array[2])
  
end
