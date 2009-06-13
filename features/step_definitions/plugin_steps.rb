def div_name_to_css(name)
  name.gsub(' ','-').downcase
end

Before do
  Sham.reset
end

Given /^I am on the (.*)$/ do |page_name|
  visit path_to(page_name)
end

Given /^there is a user$/ do
  @user = User.make
end

Given /^I am logged in$/ do
  @current_user = User.make
  User.stubs(:current).returns(@current_user)
end

Then /^I should see a "top" menu item called "(.*)"$/ do |name|
  assert_select("div#top-menu") do
    assert_select("a", name)
  end
end

Then /^I should see an? "(.*)" column$/ do |column_name|
  assert_select("#kanban") do
    assert_select("div##{div_name_to_css(column_name)}.column")
  end
end

Then /^I should see an? "(.*)" pane in "(.*)"$/ do |pane_name, column_name|
  assert_select("#kanban") do
    assert_select("div##{div_name_to_css(column_name)}.column") do
      assert_select("div##{div_name_to_css(pane_name)}.pane")
    end
  end
end

Then /^I should see an? "(.*)" column in "(.*)"$/ do |inner_column_name, column_name|
  assert_select("#kanban") do
    assert_select("div##{div_name_to_css(column_name)}.column") do
      assert_select("div##{div_name_to_css(inner_column_name)}.column")
    end
  end
end

Then /^there should be a user$/ do
  assert_equal 1, User.count(:conditions => {:login => @user.login})
end
