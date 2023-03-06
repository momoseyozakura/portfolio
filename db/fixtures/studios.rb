40.times do |n|
  Studio.seed do |s|
    s.id = n + 1
    s.name = "studio#{n + 1}"
  end
end
