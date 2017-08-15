require 'rails_helper'

RSpec.describe "collaborations/edit", type: :view do
  before(:each) do
    @collaboration = assign(:collaboration, Collaboration.create!())
  end

  it "renders the edit collaboration form" do
    render

    assert_select "form[action=?][method=?]", collaboration_path(@collaboration), "post" do
    end
  end
end
