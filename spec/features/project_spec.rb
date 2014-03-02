require 'spec_helper'

feature "Creating projects" do
  let(:user) do
    User.create!(username: "Peter_Parker",
      password: "spiderman",
      email: "peter@spiderman.com")
  end

  let(:client) do
    user.clients.create(name: "J. Jonah Jameson", company: "Daily Bugle")
  end

  before(:each) do
    login!(user)
    visit new_client_project_url(client)
  end

  it "users can create projects for their clients" do
    create_project
    expect(page).to have_content "For: J. Jonah Jameson at Daily Bugle"
  end

  it "opens the project page after creation" do
    create_project
    expect(page).to have_content "Status: OPEN"
  end

  context "with minimum info" do
    it "lets user not add a due date on creation" do
      create_project
      expect(page).to have_content "Status: OPEN"
    end

    it "lets user submit with only a name" do
      fill_in('Name:', with: "New Photo Project")
      click_button 'Add Project'
      expect(page).not_to have_content "Description can't be blank"
    end
  end

  context "with maximum info" do
    it "lets user add deliverables while creating the project" do
      create_project(true)
      expect(page).to have_content "Spiderman stealing"
    end

    it "lets user add a due date to the project" do
      create_project(true)
      expect(page).to have_content "Deliver by: 1 week from today"
    end
  end
end

feature "Project profile page" do
  let(:user) do
    User.create!(username: "Peter_Parker",
      password: "spiderman",
      email: "peter@spiderman.com")
  end

  let(:client) do
    user.clients.create(name: "J. Jonah Jameson", company: "Daily Bugle")
  end

  before(:each) do
    login!(user)
    visit new_client_project_url(client)
    create_project(true)
  end

  it "lets user add hours to deliverables" do
    click_button '+'
  end

  it "lets user check deliverable off as 'complete'" do
    click_button 'complete'
    expect(page).to have_content 'completed'
  end

  it "does not let user add hours to completed deliverable" do
    click_button 'complete'
    click_button '+'
    expect(page).to have_content "7"
  end

  it "counts up the total hours spent on total deliverables" do
    expect(page).to have_content "7 hours"
  end


end