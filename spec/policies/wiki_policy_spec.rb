require 'rails_helper'

RSpec.describe WikiPolicy do
  subject { described_class.new(user, wiki) }

  context 'being a guest' do
    let(:user) {  nil }
    let(:wiki) { build(:wiki) }

    it { is_expected.to permit_action(:show) }
    it { is_expected.to permit_action(:index) }


    [:new, :create, :update, :edit, :destroy].each do |s|

      it "should raise a NotAuthorized error on #{s}" do
        expect{ is_expected.to permit_action(s) }.to raise_error( Pundit::NotAuthorizedError )
      end
    end

  end
  context 'being a standard user' do
    let(:user) { build(:user) }
    let(:wiki) { build(:wiki) }

    it { is_expected.to permit_action(:show) }
    it { is_expected.to permit_new_and_create_actions }
    it { is_expected.to forbid_action(:destroy) }

    describe "with owned posts" do
      let(:user) { build(:user, id: 123) }
      let(:wiki) { build(:wiki, user_id: 123) }

      it { is_expected.to permit_edit_and_update_actions }

    end

    describe "with others posts" do
      let(:user) { build(:user, id: 123) }
      let(:wiki) { build(:wiki, user_id: 777) }

      it { is_expected.to forbid_edit_and_update_actions }
    end
  end

  context 'being an administrator' do
    let(:user) { build(:user, role: :admin) }
    let(:wiki) { build(:wiki) }
    it { is_expected.to permit_action(:show) }
    it { is_expected.to permit_new_and_create_actions }
    it { is_expected.to permit_edit_and_update_actions }
    it { is_expected.to permit_action(:destroy) }
  end
end
