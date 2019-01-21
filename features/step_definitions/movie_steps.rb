When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  # use String#split to split up the rating_list, then
  # iterate over the ratings and reuse the "When I check..." or
  # "When I uncheck..." steps in lines 89-95 of web_steps.rb
  rating_list.split(',').each do |rating|
    field = "ratings_#{rating.strip}"
    if uncheck
      uncheck field
    else
      check field
    end
  end
end

Then /(.*) seed movies should exist/ do | n_seeds |
  expect(Movie.count).to eq(n_seeds.to_i)
end

Then /I should see all the movies/ do
  rows = page.all('#movies tr').size - 1
  expect(rows).to eq(Movie.count())
end

Given(/^the following movies exist:$/) do |table|
  # table is a Cucumber::MultilineArgument::DataTable
  table.hashes.each do |movie|
      Movie.create!(movie)
  end
end

Then(/^the director of "([^"]*)" should be "([^"]*)"$/) do |arg1, arg2|
  Movie.find_by_title(arg1).director == arg2
end