require 'rails_helper'

describe TicketPolicy do
  context "permissions" do
    subject { TicketPolicy.new(user, ticket) }

    let(:user) { FactoryBot.create(:user) }
    let(:project) { FactoryBot.create(:project) }
    let(:ticket) { FactoryBot.create(:ticket, project: project) }

    context 'for anonymous users' do
      let(:user) { nil }

      it { should_not permit_action :show }
      it { should_not permit_action :create }
      it { should_not permit_action :update }
      it { should_not permit_action :destroy }
      it { should_not permit_action :change_state }
      it { should_not permit_action :tag }
    end

    context 'for viewers of the project' do
      before { assign_role!(user, :viewer, project) }

      it { should permit_action :show }
      it { should_not permit_action :create }
      it { should_not permit_action :update }
      it { should_not permit_action :destroy }
      it { should_not permit_action :change_state }
      it { should_not permit_action :tag }
    end

    context 'for editors of the project' do
      before { assign_role!(user, :editor, project) }

      it { should permit_action :show }
      it { should permit_action :create }
      it { should_not permit_action :update }
      it { should_not permit_action :destroy }
      it { should_not permit_action :change_state }
      it { should_not permit_action :tag }

      context 'when the editor created the ticket' do
        # ticket is called before in editor context
        # here set ticket.author in memory
        # it calls subject using ticket in memory
        before { ticket.author = user }

        it { should permit_action :update }
      end
    end

    context 'for manager of the project' do
      before { assign_role!(user, :manager, project) }

      it { should permit_action :show }
      it { should permit_action :create }
      it { should permit_action :update }
      it { should permit_action :destroy }
      it { should permit_action :change_state }
      it { should permit_action :tag }
    end

    context 'for manager of other projects' do
      before do
        assign_role!(user, :manager, FactoryBot.create(:project))
      end

      it { should_not permit_action :show }
      it { should_not permit_action :create }
      it { should_not permit_action :update }
      it { should_not permit_action :destroy }
      it { should_not permit_action :change_state }
      it { should_not permit_action :tag }
    end

    context 'for administrators' do
      let(:user) { FactoryBot.create(:user, :admin) }

      it { should permit_action :show }
      it { should permit_action :create }
      it { should permit_action :update }
      it { should permit_action :destroy }
      it { should permit_action :change_state }
      it { should permit_action :tag }
    end
  end
end
