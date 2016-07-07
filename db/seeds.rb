# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
user = CreateAdminService.new.call
puts 'CREATED ADMIN USER: ' << user.email
HealthCareFacility.create(name: 'Memorial Hospital', user_id: 1)
HcfLocation.create(address:'123 Main St', phone:'313-521-2512', email:'none@gmail.com', city:'Detroit', state:'MI', zip:'60640', health_care_facility_id:1)
DniPharmacy.create(name:'Walgreens',address:'4556 Less St', phone:'313-737-1347', email:'none@gmail.com', city:'Detroit', state:'MI', zip:'48234', latitude:'0', longitude:'0', match_score:'0', surescripts_id:'0', stateList_id:'0', npi:'1233')

user.health_care_facility_id = 1 
user.save