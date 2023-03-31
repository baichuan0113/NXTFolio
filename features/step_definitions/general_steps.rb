require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "paths"))

Given(/the following users exist/) do |users_table|
  users_table.hashes.each do |user|
    name = user['name'].split(".")
    fake_password = user['password']
    job = user['job']

    first_name = name[0]
    last_name = name[1]
    userkey = SecureRandom.hex(10)
    login_info = LoginInfo.new
    login_info.email = "#{first_name}.#{last_name}@example.com"
    login_info.password = fake_password
    login_info.password_confirmation = fake_password
    login_info.userKey = userkey
    login_info.save!

    general_info = GeneralInfo.new
    general_info.first_name = first_name
    general_info.last_name = last_name
    general_info.userKey = userkey
    general_info.company = "TestInc"
    general_info.industry = "Fashion"
    general_info.job_name = job
    general_info.highlights = "Just a test User"
    general_info.country = "United States"
    #general_info.state = "Texas"
    #general_info.city = "College Station"
    general_info.city = user['city']
    general_info.state = user['state']
    general_info.emailaddr = "#{first_name}.#{last_name}@example.com"
    general_info.save!
  end
end



Given(/^the following galleries exist$/) do |table|
  image_path = File.join(Rails.root, 'app', 'assets', 'images', '1.jpg')
  image_file = Rack::Test::UploadedFile.new(image_path, 'image/jpeg')
  table.hashes.each do |gallery_info|
    Gallery.create!(gallery_title: gallery_info['title'],
      gallery_description: gallery_info['description'],
      gallery_totalRate: gallery_info['id'],
      GeneralInfo_id: gallery_info['id'],
      gallery_totalRate: gallery_info['total'],
      gallery_totalRator: gallery_info['num'],
      gallery_picture: [image_file])
  end
end

And(/^the following reviews exist for galleries$/) do |table|
  ids = [1,2,3,4]
  index = 0
  table.hashes.each do |review_info|
    numss = review_info['rating'].split(",")
    nums = []
    for x in numss
      nums.push(x.to_i)
    end


    @gallery = Gallery.find_by(gallery_totalRate: ids[index])
    r = Review.create!(rating: nums, gallery_id: 1, general_info_id: 1)
    @gallery.reviews = r
    index += 1
  end
end

#  Given(/the following galleries exist/) do |gallery_table|

  
#   gallery_table.hashes.each do |gall|

#     gallery_info = Gallery.new
#     gallery_info.gallery_title = gall['title']
#     gallery_info.gallery_description = gall['description']
    
#     gallery_info.gallery_picture = [nil]
#     gallery_info.GeneralInfo_id = 1

#     gallery_info.reviews = Review.find(gallery_id: 1)
#     gallery_info.save!
#   end


# end

# Given(/the following reviews exist/) do |table|
#   table.hashes.each do |review|
#     review_info = Review.new
#     nums = review['rating'].split(",")
#     for x in nums 
#       x = x.to_i
#     end
#     review_info.rating = nums
#     review_info.general_info_id = review['general_info_id']
#     review_info.gallery_id = review['gallery_id']

#     review_info.save!
#   end
# end


# a handy debugging step you can use in your scenarios to invoke 'pry' mid-scenario and poke around
When /I debug/ do
  binding.pry
end

Then(/^I should be on (.+)$/) do |page_name|
  current_path = URI.parse(current_url).path
  expect(current_path).to eq(path_to(page_name))
end

Given(/^I am logged in$/) do
  visit 'login_info/login'
  fill_in "email", :with => @login_info.email
  fill_in "password", :with => @login_info.password
  click_button "Login"
end

Given(/^I am logged in as "(.+)"$/) do |user|
  # get user info
  name = user['name'].split(".")
  email = "#{name[0]}.#{name[1]}@example.com"
  login_info = LoginInfo.find_by(email: email)

  # login as user
  visit 'login_info/login'
  fill_in "email", :with => login_info.email
  fill_in "password", :with => login_info.password
  click_button "Login"
end

Given(/^I am on (.+)$/) do |page_name|
  visit path_to(page_name)
end

When(/^I fill in "([^"]*)" with "([^"]*)"$/) do |field, value|
  fill_in(field, :with => value)
end

When /^(?:|I )fill in the following:$/ do |fields|
  fields.rows_hash.each do |name, value|
    fill_in(name, :with => value)
  end
end

Then /^(?:|I )should see the following fields:$/ do |fields|
  fields.rows_hash.each do |name, value|
    expect(find_field(name).value).to eq(value)
  end
end

When /^(?:|I )follow "([^"]*)"$/ do |link|
  click_link(link)
end

When /^(?:|I )press "([^"]*)"$/ do |button|
  click_button(button)
end

When /^(?:|I )go to (.+)$/ do |page_name|
  visit path_to(page_name)
end

When /^(?:|I )select "([^"]*)" from "([^"]*)"$/ do |value, field|
  select(value, :from => field)
end

When(/^I click on "([^"]*)"$/) do |button|
  click_link_or_button(button)
end

Then(/^(?:|I )should see "([^"]*)"$/) do |text|
  expect(page).to have_content(text)
end

Then(/^(?:|I )should not see "([^"]*)"$/) do |text|
  expect(page).not_to have_content(text)
end

# untested method
Then /^(?:|I ) should see "([^"]*)" in the (.+) section/ do |expected_text, section_selector|
  expect(page).to have_selector(section_selector, text: expected_text)
end

# untested method
When(/^I hover over the "([^"]*)" element$/) do |element|
  # find the element using Selenium WebDriver
  target_element = find(:xpath, "//*[@id='#{element}']")

  # use the Selenium WebDriver 'action' object to hover over the element
  page.driver.browser.action.move_to(target_element.native).perform
end
