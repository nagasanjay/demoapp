require "application_system_test_case"

class FoodServicesTest < ApplicationSystemTestCase
  setup do
    @food_service = food_services(:one)
  end

  test "visiting the index" do
    visit food_services_url
    assert_selector "h1", text: "Food Services"
  end

  test "creating a Food service" do
    visit food_services_url
    click_on "New Food Service"

    fill_in "Contact number", with: @food_service.contact_number
    fill_in "Status", with: @food_service.status
    fill_in "Time interval", with: @food_service.time_interval
    click_on "Create Food service"

    assert_text "Food service was successfully created"
    click_on "Back"
  end

  test "updating a Food service" do
    visit food_services_url
    click_on "Edit", match: :first

    fill_in "Contact number", with: @food_service.contact_number
    fill_in "Status", with: @food_service.status
    fill_in "Time interval", with: @food_service.time_interval
    click_on "Update Food service"

    assert_text "Food service was successfully updated"
    click_on "Back"
  end

  test "destroying a Food service" do
    visit food_services_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Food service was successfully destroyed"
  end
end
