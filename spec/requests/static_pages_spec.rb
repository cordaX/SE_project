require 'rails_helper'

RSpec.describe 'StaticPages', type: :request do
  it 'should have the right links on the layout' do
    visit root_path
    click_link 'About'
    expect(page).to have_title('About Us')
    click_link 'Help'
    expect(page).to have_title('Help')
    click_link 'Contact'
    expect(page).to have_title('Contact')
    #click_link 'Home'
    #click_link 'Sign up now!'
    #expect(page).to have_title('Sign up')
    click_link 'Home'
    #这个挺厉害的，相当于模仿了用户的点击流程
    click_link 'Find course now!'
    #expect(page).to # fill in
    #click_link 'sample app'
    #expect(page).to # fill in
  end


  subject { page }

  describe 'Home page' do
    before {visit root_path}
    it 'should have the h1 "Moyu"' do
      expect(page).to have_content('Moyu')
    end
    it {should have_title('Moyu')}
    it {should_not have_title('| Home')}

    describe "for signed-in users" do
      let(:user) { FactoryBot.create(:user) }
      before do
        FactoryBot.create(:micropost, user: user, content: "Lorem ipsum")
        FactoryBot.create(:micropost, user: user, content: "Dolor sit amet")
        sign_in user
        visit root_path
      end
      it "should render the user's feed" do
        user.feed.each do |item|
          expect(page).to have_selector("li##{item.id}", text: item.content)
        end
      end
    end
  end

  describe 'Help page' do
    before {visit help_path}
    it {should have_content('Help')}
    it {should have_title('Help')}
  end

  describe 'About page' do
    before {visit about_path}
    it {should  have_content('About Us')}
    it {should have_title('About Us')}
  end

  describe 'Contact page' do
    before {visit contact_path}
    it {should have_content('Contact')}
    it {should have_title('Moyu | Contact')}
  end
end
