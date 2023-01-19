40.times do |n|
  Studio.seed do |s|
    s.name = "stusio#{n}"
  end
end
