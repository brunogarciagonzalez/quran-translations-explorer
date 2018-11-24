# each text file is a translation of Quran. Author can be found in website:
# http://tanzil.net/trans/

# other possible source of txts:
# http://www.qurandatabase.org/

require "rest-client"

class SeedsFromTxts
  def directory_iterator
    # go through each translation_file in the 'texts' directory
    # author and language are in the filename, so this can be parsed and can be fed into #translation_instantiator
      # language.Author_Names.txt

    progress_counter = 1
    progress_denominator = Dir.glob('./texts/*.txt').length

    Dir.glob('./texts/*.txt') do |txt_file_path|
      # do work on files ending in .txt in the 'texts directory
      # example of txt_file_path: "../texts/english.Mohammad_Habib_Shakir.txt"

      author_name = self.author_name_parser(txt_file_path.split("/")[2].split(".")[1])

      translation_language = self.language_formatter(txt_file_path.split("/")[2].split(".")[0])

      translation_filepath = txt_file_path

      self.translation_instantiator(author_name, translation_language, translation_filepath, progress_counter, progress_denominator)
      progress_counter += 1
    end

  end

  private
  
  def translation_instantiator(author_name, translation_language, translation_filepath, progress_counter, progress_denominator)
    # need to produce an instance of Translation
    current_translation = Translation.create(author: author_name, language: translation_language)

    current_chapter = nil

    canonical_verse_number_counter = 1

    File.open( translation_filepath ).each do |line|
      # NoMethodError: undefined method `split' for nil:NilClass
        # => return out of the parser once a line is a blank line
      if line == "\n"
        puts "**************"
        return
      end
      chapter_number = self.chapter_number_parser(line)
      integer_chapter_num = chapter_number.to_i
      chapter_title = self.chapter_title_map[chapter_number.to_i]
      verse_number = self.verse_number_parser(line)
      verse_content = self.verse_content_parser(line)

      # check to see if chapter is same as last iteration
      # if not, then need to produce new instance of Chapter
      if current_chapter
        if current_chapter.number != integer_chapter_num
          current_chapter = Chapter.create(translation_id: current_translation.id, number: chapter_number, title: chapter_title, requires_addition_of_bismillah: !(          integer_chapter_num == 1 || integer_chapter_num == 9))
        end
      else
        current_chapter = Chapter.create(translation_id: current_translation.id, number: chapter_number, title: chapter_title, requires_addition_of_bismillah: !(          integer_chapter_num == 1 || integer_chapter_num == 9))
      end

      # need to produce instances of Verse with current_chapter as its chapter
      Verse.create(chapter_id: current_chapter.id, number: verse_number, content: verse_content, canonical_verse_id: canonical_verse_number_counter)
      canonical_verse_number_counter += 1
      puts "Added to DB [file #{progress_counter} of #{progress_denominator}]:: Translation: #{author_name} (#{translation_language}), Chapter: #{chapter_number} (#{chapter_title}), Verse #{verse_number}."
    end

  end

  def verse_content_parser(line)
    # returns current verse content from line

    # remove chapter and verse number from left end
    # remove "\n" from right end

    line.split("|")[2].split("\n")[0]
  end

  def chapter_number_parser(txt_file_line)
    # returns current chapter number
    txt_file_line.split("|")[0]
  end

  def verse_number_parser(txt_file_line)
    # returns current chapter number
    txt_file_line.split("|")[1]
  end

  def author_name_parser(name_string)
    # example: "Mohammad_Habib_Shakir"
    #split on underscore, join with space
    name_string.split("_").join(" ")
  end

  def language_formatter(language_string)
    language_string.capitalize
  end

  def chapter_title_map
    {1=>"Al-Faatiha", 2=>"Al-Baqara", 3=>"Aal-i-Imraan", 4=>"An-Nisaa", 5=>"Al-Maaida", 6=>"Al-An'aam", 7=>"Al-A'raaf", 8=>"Al-Anfaal", 9=>"At-Tawba", 10=>"Yunus", 11=>"Hud", 12=>"Yusuf", 13=>"Ar-Ra'd", 14=>"Ibrahim", 15=>"Al-Hijr", 16=>"An-Nahl", 17=>"Al-Israa", 18=>"Al-Kahf", 19=>"Maryam", 20=>"Taa-Haa", 21=>"Al-Anbiyaa", 22=>"Al-Hajj", 23=>"Al-Muminoon", 24=>"An-Noor", 25=>"Al-Furqaan", 26=>"Ash-Shu'araa", 27=>"An-Naml", 28=>"Al-Qasas", 29=>"Al-Ankaboot", 30=>"Ar-Room", 31=>"Luqman", 32=>"As-Sajda", 33=>"Al-Ahzaab", 34=>"Saba", 35=>"Faatir", 36=>"Yaseen", 37=>"As-Saaffaat", 38=>"Saad", 39=>"Az-Zumar", 40=>"Ghafir", 41=>"Fussilat", 42=>"Ash-Shura", 43=>"Az-Zukhruf", 44=>"Ad-Dukhaan", 45=>"Al-Jaathiya", 46=>"Al-Ahqaf", 47=>"Muhammad", 48=>"Al-Fath", 49=>"Al-Hujuraat", 50=>"Qaaf", 51=>"Adh-Dhaariyat", 52=>"At-Tur", 53=>"An-Najm", 54=>"Al-Qamar", 55=>"Ar-Rahmaan", 56=>"Al-Waaqia", 57=>"Al-Hadid", 58=>"Al-Mujaadila", 59=>"Al-Hashr", 60=>"Al-Mumtahana", 61=>"As-Saff", 62=>"Al-Jumu'a", 63=>"Al-Munaafiqoon", 64=>"At-Taghaabun", 65=>"At-Talaaq", 66=>"At-Tahrim", 67=>"Al-Mulk", 68=>"Al-Qalam", 69=>"Al-Haaqqa", 70=>"Al-Ma'aarij", 71=>"Nooh", 72=>"Al-Jinn", 73=>"Al-Muzzammil", 74=>"Al-Muddaththir", 75=>"Al-Qiyaama", 76=>"Al-Insaan", 77=>"Al-Mursalaat", 78=>"An-Naba", 79=>"An-Naazi'aat", 80=>"Abasa", 81=>"At-Takwir", 82=>"Al-Infitaar", 83=>"Al-Mutaffifin", 84=>"Al-Inshiqaaq", 85=>"Al-Burooj", 86=>"At-Taariq", 87=>"Al-A'laa", 88=>"Al-Ghaashiya", 89=>"Al-Fajr", 90=>"Al-Balad", 91=>"Ash-Shams", 92=>"Al-Lail", 93=>"Ad-Dhuhaa", 94=>"Ash-Sharh", 95=>"At-Tin", 96=>"Al-Alaq", 97=>"Al-Qadr", 98=>"Al-Bayyina", 99=>"Az-Zalzala", 100=>"Al-Aadiyaat", 101=>"Al-Qaari'a", 102=>"At-Takaathur", 103=>"Al-Asr", 104=>"Al-Humaza", 105=>"Al-Fil", 106=>"Quraish", 107=>"Al-Maa'un", 108=>"Al-Kawthar", 109=>"Al-Kaafiroon", 110=>"An-Nasr", 111=>"Al-Masad", 112=>"Al-Ikhlaas", 113=>"Al-Falaq", 114=>"An-Naas"}
  end

end
