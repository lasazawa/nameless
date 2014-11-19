# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
 Tag.create([{name:'biking', description:'person like biking', created_by: 1}])

 Tag.create([{name:'hiking', description:'person like hiking', created_by: 2}])

 Tag.create([{name:'baseball', description:'person like baseball', created_by: 4}])

 Tag.create([{name:'computers', description:'person like computers', created_by: 3}])