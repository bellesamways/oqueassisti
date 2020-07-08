require "application_system_test_case"

class ListsTest < ApplicationSystemTestCase
  setup do
    @list = lists(:one)
  end

  test "visiting the index" do
    visit lists_url
    assert_selector "h1", text: "Lists"
  end

  test "creating a List" do
    visit lists_url
    click_on "New List"

    fill_in "Movie", with: @list.movie_id
    fill_in "Name", with: @list.name
    fill_in "Show", with: @list.show_id
    fill_in "Type", with: @list.type
    fill_in "User", with: @list.user_id
    click_on "Create List"

    assert_text "List was successfully created"
    click_on "Back"
  end

  test "updating a List" do
    visit lists_url
    click_on "Edit", match: :first

    fill_in "Movie", with: @list.movie_id
    fill_in "Name", with: @list.name
    fill_in "Show", with: @list.show_id
    fill_in "Type", with: @list.type
    fill_in "User", with: @list.user_id
    click_on "Update List"

    assert_text "List was successfully updated"
    click_on "Back"
  end

  test "destroying a List" do
    visit lists_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "List was successfully destroyed"
  end
end
