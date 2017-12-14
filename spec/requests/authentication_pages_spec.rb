require 'rails_helper'

RSpec.describe "AuthenticationPages", type: :request do
  # describe "GET /authentication_pages" do
  #   it "works! (now write some real specs)" do
  #     get authentication_pages_index_path
  #     expect(response).to have_http_status(200)
  #   end
  # end

  subject {page}

  describe "signin page" do
    before { visit signin_path }
    it { should have_content('登陆') }
    it { should have_title('登陆') }

    describe "with invalid information" do
      before { click_button '登陆' }

      it { should have_title('登陆') }
      it { should have_selector('div.alert.alert-error', text: '无效的') }

      describe "after visiting another page" do
        before { click_link "Home" }
        it { should_not have_selector('div.alert.alert-error') }
      end

    end

    describe "with valid information" do
      let(:user) { FactoryBot.create(:user) }
      before do
        fill_in "Email", with: user.email.upcase
        fill_in "Password", with: user.password
        click_button '登陆'
      end
      # before { valid_signin(user) }

      it { should have_title(user.name) }
      it { should have_link('Profile', href: user_path(user)) }
      it { should have_link('Sign out', href: signout_path) }
      it { should_not have_link('登陆', href: signin_path) }

      describe "followed by signout" do
        before { click_link "Sign out" }
        it { should have_link('登陆') }
      end

    end

  end
end
