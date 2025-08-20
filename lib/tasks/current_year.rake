desc 'Generete current year'
task current_year: :environment do
  puts "Generete 2025 current year"

  Year.update_all(current_year: false)
  Year.create(name: 2025, current_year: true)
end
