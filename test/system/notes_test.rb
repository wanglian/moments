require "application_system_test_case"

class NotesTest < ApplicationSystemTestCase
  setup do
    @note = notes(:one)

    sign_in users(:will).email_address
  end

  test "visiting the index" do
    visit notes_url

    assert_selector "div.notes"
  end

  test "should create note" do
    visit notes_url
    click_on "Create moment"

    fill_in "Content", with: @note.content
    click_on "Save"

    assert_text "Moment was successfully created"
  end

  test "should update Note" do
    visit notes_url(anchor: dom_id(@note))
    click_on "Edit", match: :first

    fill_in "Content", with: @note.content
    click_on "Save"

    assert_text "Moment was successfully updated"
  end

  test "should destroy Note" do
    visit notes_url(anchor: dom_id(@note))
    click_on "Delete", match: :first

    assert_text "Moment was successfully destroyed"
  end
end
