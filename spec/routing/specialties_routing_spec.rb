require "rails_helper"

RSpec.describe SpecialtiesController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/specialties").to route_to("specialties#index")
    end

    it "routes to #show" do
      expect(get: "/specialties/1").to route_to("specialties#show", id: "1")
    end


    it "routes to #create" do
      expect(post: "/specialties").to route_to("specialties#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/specialties/1").to route_to("specialties#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/specialties/1").to route_to("specialties#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/specialties/1").to route_to("specialties#destroy", id: "1")
    end
  end
end
