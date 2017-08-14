require 'rails_helper'
include RandomData


RSpec.describe WikisController, type: :controller do

  let(:my_wiki) {create(:wiki, user_id: standard_user.id) }
  let(:other_wiki) {create(:wiki, user_id: other_user.id)}
  let(:private_wiki) {create(:wiki, user_id: standard_user.id, private: true)}
  let(:other_private_wiki) {create(:wiki, user_id: other_user.id, private: true)}
  let(:other_user) {create(:user)}
  let(:standard_user) {create(:user)}
  let(:admin_user) {create(:user, role: :admin)}

  context "guest" do
    describe "GET show" do
      it "returns http success" do
        get :show, params: { id: my_wiki.id }
        expect(response).to have_http_status(:success)
      end

      it "renders the #show view" do
        get :show, params: { id: my_wiki.id }
        expect(response).to render_template :show
      end

      it "assigns my_wiki to @wiki" do
        get :show, params: {  id: my_wiki.id }
        expect(assigns(:wiki)).to eq(my_wiki)
      end
    end

    describe "GET new" do
      it "returns http redirect" do
        get :new, params: { }
        expect(response).to redirect_to(root_path)
      end
    end

    describe "POST create" do
      it "returns http redirect" do
        post :create, params: { wiki: { title: RandomData.random_sentence, body: RandomData.random_paragraph } }
        expect(response).to redirect_to(root_path)
      end
    end

    describe "GET edit" do
      it "returns http redirect" do
        get :edit, params: { id: my_wiki.id }
        expect(response).to redirect_to(root_path)
      end
    end

    describe "PUT update" do
      it "returns http redirect" do
        new_title = RandomData.random_sentence
        new_body = RandomData.random_paragraph

        put :update, params: { id: my_wiki.id, post: { title: new_title, body: new_body } }
        expect(response).to redirect_to(root_path)
      end
    end

    describe "DELETE destroy" do
      it "returns http redirect" do
        delete :destroy, params: { id: my_wiki.id }
        expect(response).to redirect_to(root_path)
      end
    end
  end

  context "standard user doing CRUD on a wiki they don't own" do

    before do
      sign_in(standard_user)
    end

    describe "GET show" do
      it "returns http success" do
        get :show, params: { id: other_wiki.id }
        expect(response).to have_http_status(:success)
      end

      it "renders the #show view" do
        get :show, params: { id: other_wiki.id }
        expect(response).to render_template :show
      end

      it "assigns other_wiki to @wiki" do
        get :show, params: { id: other_wiki.id }
        expect(assigns(:wiki)).to eq(other_wiki)
      end
    end

    describe "GET edit" do
      it "returns http redirect" do
        get :edit, params: {  id: other_wiki.id }
        expect(response).to redirect_to(root_path)
      end
    end

    describe "PUT update" do
      it "returns http redirect" do
        new_title = RandomData.random_sentence
        new_body = RandomData.random_paragraph

        put :update, params: { id: other_wiki.id, wiki: { title: new_title, body: new_body } }
        expect(response).to redirect_to(root_path)
      end
    end

    describe "DELETE destroy" do
      it "returns http redirect" do
        delete :destroy, params: {  id: other_wiki.id }
        expect(response).to redirect_to(root_path)
      end
    end
  end

  context "standard user doing CRUD on a wiki they own" do
    before do
      sign_in(standard_user)
    end

    describe "GET show" do
      it "returns http success" do
        get :show, params: {  id: my_wiki.id }
        expect(response).to have_http_status(:success)
      end

      it "renders the #show view" do
        get :show, params: { id: my_wiki.id }
        expect(response).to render_template :show
      end

      it "assigns my_wiki to @wiki" do
        get :show, params: {  id: my_wiki.id }
        expect(assigns(:wiki)).to eq(my_wiki)
      end
    end

    describe "GET edit" do
      it "returns http success" do
        get :edit, params: {  id: my_wiki.id }
        expect(response).to have_http_status(:success)
      end

      it "renders the #edit view" do
        get :edit, params: {  id: my_wiki.id }
        expect(response).to render_template :edit
      end

      it "assigns wiki to be updated to @wiki" do
        get :edit, params: {  id: my_wiki.id }
        wiki_instance = assigns(:wiki)

        expect(wiki_instance.id).to eq my_wiki.id
        expect(wiki_instance.title).to eq my_wiki.title
        expect(wiki_instance.body).to eq my_wiki.body
      end
    end

    describe "PUT update" do
      it "updates wiki with expected attributes" do
        new_title = RandomData.random_sentence
        new_body = RandomData.random_paragraph

        put :update, params: {  id: my_wiki.id, wiki: { title: new_title, body: new_body } }

        updated_wiki = assigns(:wiki)
        expect(updated_wiki.id).to eq my_wiki.id
        expect(updated_wiki.title).to eq new_title
        expect(updated_wiki.body).to eq new_body
      end

      it "redirects to the updated wiki" do
        new_title = RandomData.random_sentence
        new_body = RandomData.random_paragraph

        put :update, params: {  id: my_wiki.id, wiki: { title: new_title, body: new_body } }
        expect(response).to redirect_to my_wiki
      end
    end

    describe "DELETE destroy" do
      it "deletes the wiki" do
        delete :destroy, params: {  id: my_wiki.id }
        count = Wiki.where({id: my_wiki.id}).size
        expect(count).to eq 0
      end

      it "redirects to wikis index" do
        delete :destroy, params: {  id: my_wiki.id }
        expect(response).to redirect_to wikis_path
      end
    end
  end

  context "admin user doing CRUD on a wiki they don't own" do
    before do
      sign_in(admin_user)
    end

    describe "GET show" do
      it "returns http success" do
        get :show, params: {  id: my_wiki.id }
        expect(response).to have_http_status(:success)
      end

      it "renders the #show view" do
        get :show, params: {  id: my_wiki.id }
        expect(response).to render_template :show
      end

      it "assigns my_wiki to @wiki" do
        get :show, params: {  id: my_wiki.id }
        expect(assigns(:wiki)).to eq(my_wiki)
      end
    end

    describe "GET new" do
      it "returns http success" do
        get :new, params: {  }
        expect(response).to have_http_status(:success)
      end

      it "renders the #new view" do
        get :new, params: {  }
        expect(response).to render_template :new
      end

      it "instantiates @wiki" do
        get :new, params: {  }
        expect(assigns(:wiki)).not_to be_nil
      end
    end

    describe "POST create" do
      it "increases the number of Wiki by 1" do
        expect{ post :create, params: {  wiki: { title: RandomData.random_sentence, body: RandomData.random_paragraph, user_id: admin_user.id, private: false } } }.to change(Wiki,:count).by(1)
      end

      it "assigns the new wiki to @wiki" do
        post :create, params: {  wiki: { title: RandomData.random_sentence, body: RandomData.random_paragraph, user_id: admin_user.id, private: false } }
        expect(assigns(:wiki)).to eq Wiki.last
      end

      it "redirects to the new wiki" do
        post :create, params: {  wiki: { title: RandomData.random_sentence, body: RandomData.random_paragraph, user_id: admin_user.id, private: false } }
        expect(response).to redirect_to Wiki.last
      end
    end

    describe "GET edit" do
      it "returns http success" do
        get :edit, params: {  id: my_wiki.id }
        expect(response).to have_http_status(:success)
      end

      it "renders the #edit view" do
        get :edit, params: {  id: my_wiki.id }
        expect(response).to render_template :edit
      end

      it "assigns wiki to be updated to @wiki" do
        get :edit, params: {  id: my_wiki.id }
        wiki_instance = assigns(:wiki)

        expect(wiki_instance.id).to eq my_wiki.id
        expect(wiki_instance.title).to eq my_wiki.title
        expect(wiki_instance.body).to eq my_wiki.body
      end
    end

    describe "PUT update" do
      it "updates wiki with expected attributes" do
        new_title = RandomData.random_sentence
        new_body = RandomData.random_paragraph

        put :update, params: {  id: my_wiki.id, wiki: { title: new_title, body: new_body } }

        updated_wiki = assigns(:wiki)
        expect(updated_wiki.id).to eq my_wiki.id
        expect(updated_wiki.title).to eq new_title
        expect(updated_wiki.body).to eq new_body
      end

      it "redirects to the updated wiki" do
        new_title = RandomData.random_sentence
        new_body = RandomData.random_paragraph

        put :update, params: {  id: my_wiki.id, wiki: { title: new_title, body: new_body } }
        expect(response).to redirect_to my_wiki
      end
    end

    describe "DELETE destroy" do
      it "deletes the wiki" do
        delete :destroy, params: {  id: my_wiki.id }
        count = Wiki.where({id: my_wiki.id}).size
        expect(count).to eq 0
      end

      it "redirects to wikis index" do
        delete :destroy, params: {  id: my_wiki.id }
        expect(response).to redirect_to wikis_path
      end
    end
  end

  context "standard user doing CRUD on a private wiki they own" do

    before do
      sign_in(standard_user)
    end

    describe "GET show" do
      it "returns http success" do
        get :show, params: { id: private_wiki.id }
        expect(response).to have_http_status(:success)
      end

      it "renders the #show view" do
        get :show, params: { id: private_wiki.id }
        expect(response).to render_template :show
      end

      it "assigns private_wiki to @wiki" do
        get :show, params: { id: private_wiki.id }
        expect(assigns(:wiki)).to eq(private_wiki)
      end
    end

    describe "GET edit" do
      it "returns http success" do
        get :edit, params: {  id: private_wiki.id }
        expect(response).to have_http_status(:success)
      end

      it "renders the #edit view" do
        get :edit, params: {  id: private_wiki.id }
        expect(response).to render_template :edit
      end

      it "assigns wiki to be updated to @wiki" do
        get :edit, params: {  id: private_wiki.id }
        wiki_instance = assigns(:wiki)

        expect(wiki_instance.id).to eq private_wiki.id
        expect(wiki_instance.title).to eq private_wiki.title
        expect(wiki_instance.body).to eq private_wiki.body
      end
    end

    describe "PUT update" do
      it "updates wiki with expected attributes" do
        new_title = RandomData.random_sentence
        new_body = RandomData.random_paragraph

        put :update, params: {  id: private_wiki.id, wiki: { title: new_title, body: new_body } }

        updated_wiki = assigns(:wiki)
        expect(updated_wiki.id).to eq private_wiki.id
        expect(updated_wiki.title).to eq new_title
        expect(updated_wiki.body).to eq new_body
      end

      it "redirects to the updated wiki" do
        new_title = RandomData.random_sentence
        new_body = RandomData.random_paragraph

        put :update, params: {  id: private_wiki.id, wiki: { title: new_title, body: new_body } }
        expect(response).to redirect_to private_wiki
      end
    end

    describe "DELETE destroy" do
      it "deletes the wiki" do
        delete :destroy, params: {  id: private_wiki.id }
        count = Wiki.where({id: private_wiki.id}).size
        expect(count).to eq 0
      end

      it "redirects to wikis index" do
        delete :destroy, params: {  id: private_wiki.id }
        expect(response).to redirect_to wikis_path
      end
    end
  end

  context "standard user doing CRUD on a private wiki they don't own" do

    before do
      sign_in(standard_user)
    end

    describe "GET show" do
      it "returns http redirect" do
        get :show, params: {  id: other_private_wiki.id }
        expect(response).to redirect_to(root_path)
      end
    end

    describe "GET edit" do
      it "returns http redirect" do
        get :edit, params: {  id: other_private_wiki.id }
        expect(response).to redirect_to(root_path)
      end
    end

    describe "PUT update" do
      it "returns http redirect" do
        new_title = RandomData.random_sentence
        new_body = RandomData.random_paragraph

        put :update, params: { id: other_private_wiki.id, wiki: { title: new_title, body: new_body } }
        expect(response).to redirect_to(root_path)
      end
    end

    describe "DELETE destroy" do
      it "returns http redirect" do
        delete :destroy, params: {  id: other_private_wiki.id }
        expect(response).to redirect_to(root_path)
      end
    end
  end

  context "admin user doing CRUD on a private wiki they don't own" do
    before do
      sign_in(admin_user)
    end

    describe "GET show" do
      it "returns http success" do
        get :show, params: {  id: private_wiki.id }
        expect(response).to have_http_status(:success)
      end

      it "renders the #show view" do
        get :show, params: {  id: private_wiki.id }
        expect(response).to render_template :show
      end

      it "assigns private_wiki to @wiki" do
        get :show, params: {  id: private_wiki.id }
        expect(assigns(:wiki)).to eq(private_wiki)
      end
    end

    describe "GET new" do
      it "returns http success" do
        get :new, params: {  }
        expect(response).to have_http_status(:success)
      end

      it "renders the #new view" do
        get :new, params: {  }
        expect(response).to render_template :new
      end

      it "instantiates @wiki" do
        get :new, params: {  }
        expect(assigns(:wiki)).not_to be_nil
      end
    end

    describe "GET edit" do
      it "returns http success" do
        get :edit, params: {  id: private_wiki.id }
        expect(response).to have_http_status(:success)
      end

      it "renders the #edit view" do
        get :edit, params: {  id: private_wiki.id }
        expect(response).to render_template :edit
      end

      it "assigns wiki to be updated to @wiki" do
        get :edit, params: {  id: private_wiki.id }
        wiki_instance = assigns(:wiki)

        expect(wiki_instance.id).to eq private_wiki.id
        expect(wiki_instance.title).to eq private_wiki.title
        expect(wiki_instance.body).to eq private_wiki.body
      end
    end

    describe "PUT update" do
      it "updates wiki with expected attributes" do
        new_title = RandomData.random_sentence
        new_body = RandomData.random_paragraph

        put :update, params: {  id: private_wiki.id, wiki: { title: new_title, body: new_body } }

        updated_wiki = assigns(:wiki)
        expect(updated_wiki.id).to eq private_wiki.id
        expect(updated_wiki.title).to eq new_title
        expect(updated_wiki.body).to eq new_body
      end

      it "redirects to the updated wiki" do
        new_title = RandomData.random_sentence
        new_body = RandomData.random_paragraph

        put :update, params: {  id: private_wiki.id, wiki: { title: new_title, body: new_body } }
        expect(response).to redirect_to private_wiki
      end
    end

    describe "DELETE destroy" do
      it "deletes the wiki" do
        delete :destroy, params: {  id: private_wiki.id }
        count = Wiki.where({id: private_wiki.id}).size
        expect(count).to eq 0
      end

      it "redirects to wikis index" do
        delete :destroy, params: {  id: private_wiki.id }
        expect(response).to redirect_to wikis_path
      end
    end
  end
end
