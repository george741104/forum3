namespace :data do

  task :post => :environment do
    puts"creating fake POST data"

    50.times do |i|
      p = Post.create(:title => Faker::App.name, :content=>Faker::Lorem.paragraph(10))
      p.save
    end
  end
end
