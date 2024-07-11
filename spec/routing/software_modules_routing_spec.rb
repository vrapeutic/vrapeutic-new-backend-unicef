require "rails_helper"

RSpec.describe SoftwareModulesController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/software_modules").to route_to("software_modules#index")
    end

    it "routes to #show" do
      expect(get: "/software_modules/1").to route_to("software_modules#show", id: "1")
    end


    it "routes to #create" do
      expect(post: "/software_modules").to route_to("software_modules#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/software_modules/1").to route_to("software_modules#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/software_modules/1").to route_to("software_modules#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/software_modules/1").to route_to("software_modules#destroy", id: "1")
    end
  end
end
