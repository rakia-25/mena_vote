desc 'insert candidate'
task insert_candidate: :environment do
  puts "insert candidate"

  categories_data = {
    "MEILLEUR ENTRAINEUR" => [
      "DIABATE SEYDOU OUMAROU",
    ],
    "MEILLEUR ESPOIR" => [
      "SAMAILA DANJA",
      "AHAMAT JALIL",
      "GOUMEY DJIBRIL ABDOUL LATIF",
      "HAROUNA HASSANE",
    ],
    "MEILLEUR GARDIEN" => [
      "HABIBOULAYE HAINIKOYE",
      "MAHAMADOU DJIBRIL TANDJA",
      "BOUKARI KANTA",
    ],
    "MEILLEUR JOUEUSE" => [
      "LAOULI SADDIA",
      "AHMED ALASSANE AICHATOU",
      "ZAKARI NANA FIRDAOUSS",
    ]
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
