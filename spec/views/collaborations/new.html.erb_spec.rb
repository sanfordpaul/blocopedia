require 'rails_helper'

RSpec.describe "collaborations/new", type: :view do
  before(:each) do
    assign(:collaboration, Collaboration.new())
  end

  it "renders new collaboration form" do
    render

    assert_select "form[action=?][method=?]", collaborations_path, "post" do
    end
  end
end
