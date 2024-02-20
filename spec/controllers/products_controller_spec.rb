require 'rails_helper'

RSpec.describe Api::V1::ProductsController, type: :controller do
  describe "GET #index" do
    it "returns a success response" do
      get :index, format: :json
      expect(response).to be_successful
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      product = Product.create(name: "Product 1", description: "Description of Product 1", price: 10.99)
      get :show, params: { id: product.to_param }, format: :json
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    it "creates a new product" do
      expect {
        post :create, params: { product: { name: "New Product", description: "Description of New Product", price: 20.99 } }, format: :json
      }.to change(Product, :count).by(1)
      expect(response).to have_http_status(:created)
    end
  end

  describe "PUT #update" do
    it "updates the requested product" do
      product = Product.create(name: "Product 1", description: "Description of Product 1", price: 10.99)
      put :update, params: { id: product.to_param, product: { name: "Updated Product" } }, format: :json
      product.reload
      expect(product.name).to eq("Updated Product")
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested product" do
      product = Product.create(name: "Product 1", description: "Description of Product 1", price: 10.99)
      expect {
        delete :destroy, params: { id: product.to_param }, format: :json
      }.to change(Product, :count).by(-1)
      expect(response).to have_http_status(:no_content)
    end
  end
end
