require 'rails_helper'

RSpec.describe 'Task management function', type: :system do
  describe 'Registration function' do
    context 'When registering a task' do
      it 'The registered task is displayed' do
        FactoryBot.create(:task)
        visit @task
        expect(page).to have_content 'Préparation des documents'
      end
    end
  end

  describe 'List display function' do
    context 'When transitioning to the list screen' do
      it 'A list of registered tasks is displayed' do
        FactoryBot.create(:task)
        visit tasks_path
        expect(page).to have_content 'Préparation des documents'
      end
    end
  end

  describe 'Detailed display function' do
     context 'When transitioned to any task details screen' do
       it 'The content of the task is displayed' do
        FactoryBot.create(:task)
        visit @task
        expect(page).to have_content 'Créer une proposition.'
       end
     end
  end
end