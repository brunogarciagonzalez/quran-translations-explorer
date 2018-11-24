# seeds

Verse.destroy_all
Chapter.destroy_all
Translation.destroy_all

puts "**************"

# for data from .txt translations
# seeder_txts = SeedsFromTxts.new
# seeder_txts.directory_iterator

# for data of Rashad's translation from masjidtucson.com
seeder_masjid_tucson = SeedsFromMasjidTucson.new
seeder_masjid_tucson.getters_iterator

puts "** success! **"
puts "**************"
