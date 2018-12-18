# seeds
# TODO: use postgre




puts "**************"

# for data from .txt translations:
# seeder_txts = SeedsFromTxts.new
# seeder_txts.directory_iterator

# for data of Rashad's translation from masjidtucson.org:
# SeedsFromMasjidTucson.new.getters_iterator
SeedsFromTxts.new.directory_iterator
puts "** success! **"
puts "**************"
