desc 'insert candidate'
task insert_candidate: :environment do
  puts "insert candidate"

  categories_data = {
    "CINEMA" => [
      "DJAFFAR HANZALI",
      "FARUK ISSA",
      "LAWALY GAZALY",
      "MAHAMADOU TASSIOU",
      "NASSER CLEMENT",
      "RAPHAEL",
    ],
    "INFLUENCEUR" => [
      "AMINA AMADOU",
      "AU MICRO DE MOUSSA",
      "DON CESAR",
      "KALIYA GOURO",
      "LE FADJIKARISTE",
      "MAIMOUNA ABDOULAYE MODI",
      "MARIAMA OUSMANE LA ZINDEROISE",
      "REINATOU SADOU",
      "SADIA BLOG",
      "SANNY 3",
      "YASMINA SAIDOU",
    ],
    "MAITRE DE CEREMONIE" => [
      "ABDINE ABDOULAYE",
      "DJ KASS KASS",
      "KAD LA ZONE",
      "LEYO RAZAK",
      "PAPUS T",
      "SEYNO 50%",
    ],
    "MEILLEUR ARTISTE FEMININ" => [
      "CHOCOLATE",
      "FAD DIORI",
      "FADI",
      "FATOU MATA",
      "MARIE DIALLO",
      "NANA ALOKO",
    ],
    "MEILLEUR CLIP DE L'ANNEE" => [
      "AKEEM",
      "DARE",
      "LIL MED",
      "MARIE DIALLO",
    ],
    "MEILLEUR HUMOURISTE DE L'ANNEE" => [
      "DIALLO 227",
      "SAM L'HUMOURISTE",
      "WANOUSKY MONTANA",
    ],
    "MUSIQUE DANDALI" => [
      "AZO BABAN SOYYAYA",
      "MASSA OUDOU SOULEYMANE",
      "MOUSSA YARO",
      "NANA ALOKO",
      "RABIL AUTA",
    ],
    "MUSIQUE MODERNE" => [
      "ALI ATCHIBILI",
      "TESTO YARO",
    ],
    "MUSIQUE URBAINE" => [
      "AKEEM",
      "CHOCOLATE",
      "DARE",
      "EL DAMSERO",
      "ELSA",
      "HAMD MALLAM",
      "LIL MED",
      "MARIE DIALLO",
      "MASTER TAF",
      "MDM CREW",
      "NEW FLO",
      "TEAM MININKA",
    ],
    "PHOTOGRAPHE DE L'ANNEE" => [
      "ALTRUISTE 227",
      "B SOOL PICS",
      "BEDRABOX PHOTOGRAPHY",
      "HASSANE SOS SHOOTING",
      "LEYO 227 PHOTOGRAPHY",
      "LIGALI PHOTOGRAPHY",
      "RAWANI",
      "SADKHOUYA PHOTGRAPHY",
      "SOULEY ABDOULAYE",
    ],
    "PROMOTEUR CULTUREL" => [
      "BEN KARIM",
      "DJOBALA",
      "EBENEZER OTONO",
      "IMPERIAL MUSIC",
      "ISSA WASSABOY",
      "ZAMAN ALLAH",
    ],
    "REVELATION DE L'ANNEE" => [
      "2ML SIRIUS",
      "DJ WONKOY",
      "LAMIDO",
    ],
    "SLAM" => [
      "FAD DIORI",
      "FATOU MATA",
      "LASS PAROLIER",
      "RIDWANE",
    ],
    "SPORT" => [
      "ABBA IBRAHIM",
      "DJIBO ABDOUL AZIZ",
      "ISSAKA ISSAKA",
      "OUSOUMANE SEYDOU",
      "SALIMA AHMADOU",
      "YOUSSOUF OUMAROU",
    ],
    "STYLISME" => [
      "IBDI CREATION",
      "MouneH ² Designer",
    ],
    "TARMAMUN DE LA DIASPORA" => [
      "BALKISSA AHMADOU",
      "BEN KARIM",
      "FADI",
      "SANNY 3",
    ],
    "WEB HUMOURISTE" => [
      "DAN GUIDAN DJADI",
      "DJAMILOU OZIL",
      "ETINCELLE",
      "HAKILOU AMADOU",
      "WANOUSKY MONTANA",
    ],
  }
  
  year = Year.find_by(current_year: true)
  category_rank = 0

  categories_data.each do |category_name, candidates|
    category_rank += 1

    category = Category.find_or_create_by!(name: category_name) do |cat|
      cat.rank = category_rank
    end

    candidates.each_with_index do |candidate_name, index|
      candidate = Candidate.find_or_initialize_by(
        name: candidate_name,
        year_id: year.id,
        code: index + 1
      )
      if candidate.new_record?
        vote_code = nil
        loop do
          vote_code = SecureRandom.random_number(10000).to_s.rjust(4, '0')
          break unless Candidate.exists?(vote_code: vote_code)
        end
        candidate.vote_code = vote_code
        candidate.save!
      end

      unless CandidateCategory.exists?(candidate_id: candidate.id, category_id: category.id)
        CandidateCategory.create!(
          candidate_id: candidate.id,
          category_id: category.id
        )
      end
    end
  end
end
