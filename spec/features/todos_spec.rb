require 'rails_helper'

feature 'Todos', js: true do
  let(:todo) { create(:todo) }
  before { visit todo_path(todo) }

  describe 'Tasklist' do
    context 'without tasks' do
      it 'Shows a spinner' do
        expect(page).to have_content('Tasks')
        expect(page).to have_no_selector('.list-group-item')
        expect(page).to have_selector('.glyphicon-spin')
      end

      context 'with tasks' do
        before do
          allow(Task).to receive(:all).and_return ([task])
          visit todos_path
        end

        xit 'Shows tasklist' do
          expect(page).to have_content('Tasks')
          expect(page).to have_no_selector('.spinner')
          expect(page).to have_selector('.list-group-item', count: 1)
        end
      end
    end
  end

  describe 'Submit task' do
    before do
      visit todos_path
      fill_in 'title', with: 'task title'
      find('.submitTask').click
    end
    xit 'creates a task in the db' do
      expect(page).to have_selector('.list-group-item', count: 1)
    end
  end

  describe 'Change task title' do
    before do
      visit todos_path
      # click task title
      # modify name
      # click outside task
    end
    xit 'modifies task title' do
      # expect it to have the new name
      # expect it to have the new name (db check? console.log?)
    end
  end

  describe 'Remove task' do
    before do
      allow(Task).to receive(:all).and_return ([task])
      visit todos_path
    end

    xit 'removes task form tasklist' do
      expect(page).to have_selector('.list-group-item', count: 1)
      find('.deleteTask').click
      expect(page).to have_no_selector('.list-group-item')
    end
  end
end
