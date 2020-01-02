require "rails_helper"

RSpec.describe "#AccessTokens_Routes", type: :routing do
  it "deberá enrutar /login al CREATE de AccessTokensController." do
    expect(post("/login")).to route_to("access_tokens#create")
  end
end
