require "application_system_test_case"

class ArchitectsTest < ApplicationSystemTestCase
  setup do
    @architect = architects(:one)
  end

  test "visiting the index" do
    visit architects_url
    assert_selector "h1", text: "Architects"
  end

  test "should create architect" do
    visit architects_url
    click_on "New architect"

    click_on "Create Architect"

    assert_text "Architect was successfully created"
    click_on "Back"
  end

  test "should update Architect" do
    visit architect_url(@architect)
    click_on "Edit this architect", match: :first

    click_on "Update Architect"

    assert_text "Architect was successfully updated"
    click_on "Back"
  end

  test "should destroy Architect" do
    visit architect_url(@architect)
    click_on "Destroy this architect", match: :first

    assert_text "Architect was successfully destroyed"
  end
end
