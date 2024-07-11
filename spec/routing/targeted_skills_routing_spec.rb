require "rails_helper"

RSpec.describe TargetedSkillsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/targeted_skills").to route_to("targeted_skills#index")
    end

    it "routes to #show" do
      expect(get: "/targeted_skills/1").to route_to("targeted_skills#show", id: "1")
    end


    it "routes to #create" do
      expect(post: "/targeted_skills").to route_to("targeted_skills#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/targeted_skills/1").to route_to("targeted_skills#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/targeted_skills/1").to route_to("targeted_skills#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/targeted_skills/1").to route_to("targeted_skills#destroy", id: "1")
    end
  end
end
