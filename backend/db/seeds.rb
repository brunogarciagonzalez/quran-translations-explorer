# seeds

Verse.destroy_all
Chapter.destroy_all
Translation.destroy_all

puts "**************"

seeder = SeedsFromTxts.new
seeder.directory_iterator

puts "** success! **"
puts "**************"
