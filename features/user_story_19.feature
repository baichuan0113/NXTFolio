Feature:  In Search, Profile add and edition pages, US will be selected as default country and in search pages, country and city option should be added


  As a professional and application user,

  While searching, I should fill up the country and city information and during adding and editing profile, United States
  should be selected as default option.


  Scenario: Country and city adding option in both of the search pages
    Given I am a professional and search for another professional
    When I click on search button on home page
    Then I should be able to provide country and city information on that page
    And And after clicking search, I can again provide country and city information on that page.

  Scenario: United states will be selected in search profile
    Given I am a professional and search for another professional
    When I click on search button on home page
    Then Default country option united states should be selected
    And After submitting this search page, I can again see united states as the default contry in search result page

  Scenario: United states will be selected in search profile
    Given I am a professional and search for another professional
    When I click on search button on home page
    Then Default country option united states should be selected
    And After submitting this search page, I can again see united states as the default contry in search result page

  Scenario: United states will be selected while adding profile
    Given I am a professional adding my profile
    When I click on country option
    Then I will see United States as the default option

  Scenario: United states will be selected while editing profile
    Given I am a professional adding my profile
    When I click on country option
    Then I will see United States as the default option





