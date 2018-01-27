require 'rails_helper'

describe AttachmentPolicy do
  context 'permissions' do
    subject { AttachmentPolicy.new(user, attachment) }

    let(:user) { FactoryBot.create(:user) }
    let(:project) { FactoryBot.create(:project) }
    let(:ticket) { FactoryBot.create(:ticket, project: project) }
    let(:attachment) { FactoryBot.create(:attachment, ticket: ticket) }

    context 'for anonymous users' do
      let(:user) { nil }
      it { should_not permit_action :show }
    end

    context 'for viewers of the project' do
      before do
        assign_role!(user, :viewer, project)
      end

      it { should permit_action :show }
    end

    context 'for editors of the project' do
      before do
        assign_role!(user, :editor, project)
      end

      it { should permit_action :show }
    end

    context 'for managers of the project' do
      before do
        assign_role!(user, :manager, project)
      end

      it { should permit_action :show }
    end

    context 'for managers of other projects' do
      before do
        assign_role!(user, :manager, FactoryBot.create(:project))
      end

      it { should_not permit_action :show }
    end

    context 'for administrators' do
      let(:user) { FactoryBot.create :user, :admin }

      it { should permit_action :show }
    end
  end

  # let(:user) { User.new }

  # subject { AttachmentPolicy }

  # permissions ".scope" do
  #   pending "add some examples to (or delete) #{__FILE__}"
  # end

  # permissions :create? do
  #   pending "add some examples to (or delete) #{__FILE__}"
  # end

  # permissions :show? do
  #   pending "add some examples to (or delete) #{__FILE__}"
  # end

  # permissions :update? do
  #   pending "add some examples to (or delete) #{__FILE__}"
  # end

  # permissions :destroy? do
  #   pending "add some examples to (or delete) #{__FILE__}"
  # end
end
