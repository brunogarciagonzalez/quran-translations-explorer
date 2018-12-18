# seeds
# TODO: use postgre




puts "**************"

# for data from .txt translations:
# seeder_txts = SeedsFromTxts.new
# seeder_txts.directory_iterator

# for data of Rashad's translation from masjidtucson.org:
test = SeedsFromMasjidTucson.new.getters_iterator
byebug

puts "** success! **"
puts "**************"
