require 'rails_helper'

RSpec.describe "collaborations/index", type: :view do
  before(:each) do
    assign(:collaborations, [
      Collaboration.create!(),
      Collaboration.create!()
    ])
  end

  it "renders a list of collaborations" do
    render
  end
end
