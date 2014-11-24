# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
 Tag.create([
    {name:'biking', description:'person like biking', created_by: 1},
    {name:'hiking', description:'person like hiking', created_by: 2},
    {name:'baseball', description:'person like baseball', created_by: 4},
    {name:'computers', description:'person like computers', created_by: 3}
  ])

 User.create([
  {username:'admin', password:'admin1', firstname:'Add First Name'},
  {username:'user1', password:'user1', firstname:'Add First Name'},
  {username:'user2', password:'user2', firstname:'Add First Name'},
  {id: 13, username:'user13', password:'user13', firstname:'Add First Name'},
  {username:'user3', password:'user3', firstname:'Add First Name'},
  {username:'user4', password:'user4', firstname:'Add First Name'}
  ])

Project.create([
  {name:'project1', description: 'a crappy project', user_id: 1},
  {name:'project5', description: 'a great one', user_id: 1},
  {name:'project2', description: 'a crappy project', user_id: 2},
  {name:'project3', description: 'a crappy project', user_id: 2},
  {name:'project4', description: 'a crappy project', user_id: 3}
  ])

Name.create([
  {name: "pooop", project_id: 1},
  {name: "poooop", project_id: 1},
  {name: "pooooop", project_id: 1},
  {name: "interesting1", project_id: 2},
  {name: "interesting2", project_id: 2},
  {name: "interesting3", project_id: 2},
  {name: "pooop", project_id: 3},
  {name: "poooop", project_id: 3}
  ])