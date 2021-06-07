require "test_helper"

class FoodServicesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @food_service = food_services(:one)
  end

  test "should get index" do
    get food_services_url
    assert_response :success
  end

  test "should get new" do
    get new_food_service_url
    assert_response :success
  end

  test "should create food_service" do
    assert_difference('FoodService.count') do
      post food_services_url, params: { food_service: { contact_number: @food_service.contact_number, status: @food_service.status, time_interval: @food_service.time_interval } }
    end

    assert_redirected_to food_service_url(FoodService.last)
  end

  test "should show food_service" do
    get food_service_url(@food_service)
    assert_response :success
  end

  test "should get edit" do
    get edit_food_service_url(@food_service)
    assert_response :success
  end

  test "should update food_service" do
    patch food_service_url(@food_service), params: { food_service: { contact_number: @food_service.contact_number, status: @food_service.status, time_interval: @food_service.time_interval } }
    assert_redirected_to food_service_url(@food_service)
  end

  test "should destroy food_service" do
    assert_difference('FoodService.count', -1) do
      delete food_service_url(@food_service)
    end

    assert_redirected_to food_services_url
  end
end
