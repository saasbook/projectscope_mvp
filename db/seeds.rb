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
projectscope.create_code_climate_metric(url: "https://codeclimate.com/github.com/github/dhhxu/projectscope")

project_data = [
  ['ER Moonlighter Scheduling', 'stevenbuccini/er-moonlighter-scheduler'],
  ['Rate My Pup', 'eabartlett/ratemypup/'],
  ['Artist Submission Site', 'cal-sfai/submission-site'],
  ['Database and development site for City Dog Share', 'sfstanley/citydogshare'],
  ['UC Berkeley Food Pantry App', 'michellelinggg/UCBerkeleyFoodPantry'],
  ['Maker Pass Admin System', 'MasonIII/cal-maker-pass'],
  ['Calendar Creation, Synchronization', 'calendar-makers/calendar-sync'],
  ['Mobile Intake App for BCEF', 'Berkeley-BCEF/IntakeApp'],
  ['Optimization of Volunteer Database for Hep B Project', 'navroopsingh/HepBProject'],
  ['Mass Spectrometry Tools', 'avadordi/mass-spectrometry'],
  ['Assessment Platform', 'cs169-bizworld/bizworld-app'],
  ['Course Question Bank', ''],
  ['CS 61AS Quiz System', 'cs169team61as/cs61as-quiz-system'],
  ['Automate Vendor Signup Forms on SFVS.org website', 'neilkumar101/CS169_SFVS'],
  ['Khan Academy Burmese', 'DarryQueen/Khan-Burmese'],
  ['Berkeley Student Coop Workshift Website', 'bsc-networks/workshift-website'],
  ['Healthy EFF', 'ashleywillard/healthy-eff'],
  ['PenPal Gladiators', 'Fong-/CS169-PenPal-Gladiators'],
  ['SNAP', 'snap-cloud/snap-cloud'], 
  ['News Tab Website', ''],
  ['Jacobs Institute Project Documentation', 'jacobs-design/jortal'], 
  ['Youth Media Tracker/Uploader', 'hamzahashmi/youth-media-tracker'], 
  ['Practice Problem Portal', 'yujuncho7/practice-problem-portal'], 
  ['Lab assistant check-in', 'vincenttian/61A-Lab-Assistant'], 
  ['OK-Grading addition', 'joseph-choi/ok'], 
  ['Language Exchange Program Algorithm', 'swchoi727/LEP'], 
  ['Cal Central', 'Garyguo2011/CalCentral-Task-Planner'],
  ['Volunteer and Space rental portal integration', 'mleong245/bhnc-portal'], 
  ['Tracking the flow of donations of a nonprofit organization', 'donaldchen/TWC_Inventory_Tracker'], 
  ['Dogs who code', 'graceeekimmm/dogswhocode/'], 
  ['Peer Tracker', 'imranyousuf/PeerTracker'], 
  ['DeCal Program Website', 'ericcquachh/decal'], 
  ['Staffoution', 'hpec/staffolution'], 
  ['Koin Rides', 'wesley-hsu/KoinRides'], 
  ['Saffron Strand Website Redevelopment', ''],
  ['Oski Survey', 'uc-swirl/surveyoski/'],
  ['College Track Student Portal', 'forgottn/collegetrack_portal'], 
  ['Revamp Project Portal', 'chrisbrown/project-portal'], 
  ['Haas Career Management Legend', 'huangshan108/CareerNet'], 
  ['Redeemify', ''], 
  ['ER Core Staff Scheduler', 'charlespark94/ER-Core-Staff-Scheduler'],
]

project_data.each do |name, repo|
  proj = Project.create(name: name)
  proj.create_pull_request(repo: repo)
  proj.create_slack_metric(slack_api_token: '')
  
  
  code_climate_url = "https://codeclimate.com/github/#{repo}"
  if repo == ""
    code_climate_url = ""
  end
  proj.create_code_climate_metric(url: code_climate_url)
  
  num_slack_users = 5 + rand(2)
  rand_msg_counts = num_slack_users.times.map{ rand(200) }
  rand_msg_counts.each do |count|
    rand_name = (0...8).map { (65 + rand(26)).chr }.join
    proj.slack_metric.slack_data_points.create(user: rand_name, messages: count)
  end
end
