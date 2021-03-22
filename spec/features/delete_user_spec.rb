require 'rails_helper'

describe "Deleting a user" do

  before do
    admin = User.create!(user_attributes(admin: true))
    sign_in(admin)
  end

  it "destroys the user and redirects to the home page" do
    user = User.create!(user_attributes(email: 'frida@example.com', username: 'Frida', name: 'frida'))

    visit user_path(user)

    click_link 'Delete Account'

    expect(current_path).to eq(root_path)
    expect(page).to have_text('Account successfully deleted!')

    visit users_path

    expect(page).not_to have_text(user.name)
  end

  it "automatically signs out that user" do
    user = User.create!(user_attributes(email: 'frida@example.com', username: 'Frida', name: 'frida'))
  
    visit user_path(user)
  
    click_link 'Delete Account'

    expect(page).not_to have_text(user.name)
  
    # expect(page).to have_link('Sign In')
    # expect(page).to have_link('Sign Out')
  end
end