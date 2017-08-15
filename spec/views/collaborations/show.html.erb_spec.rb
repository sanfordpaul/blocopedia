require 'rails_helper'

RSpec.describe "collaborations/show", type: :view do
  before(:each) do
    @collaboration = assign(:collaboration, Collaboration.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
