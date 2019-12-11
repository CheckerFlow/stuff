require "application_system_test_case"

class EarlyAccessRequestsTest < ApplicationSystemTestCase
  setup do
    @early_access_request = early_access_requests(:one)
  end

  test "visiting the index" do
    visit early_access_requests_url
    assert_selector "h1", text: "Early Access Requests"
  end

  test "creating a Early access request" do
    visit early_access_requests_url
    click_on "New Early Access Request"

    fill_in "Email", with: @early_access_request.email
    click_on "Create Early access request"

    assert_text "Early access request was successfully created"
    click_on "Back"
  end

  test "updating a Early access request" do
    visit early_access_requests_url
    click_on "Edit", match: :first

    fill_in "Email", with: @early_access_request.email
    click_on "Update Early access request"

    assert_text "Early access request was successfully updated"
    click_on "Back"
  end

  test "destroying a Early access request" do
    visit early_access_requests_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Early access request was successfully destroyed"
  end
end
