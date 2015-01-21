require 'rails_helper'

feature 'Managing Recipes', type: :feature do
	given(:recipe) { FactoryGirl.create(:recipe) }
	scenario 'creating a new recipe' do
		visit 'recipes/new'

		fill_in 'Title', with: 'Chocolate Milk'
		fill_in 'Instructions', with: 'step 1: drink it.'
		# save_and_open_page #opens the page when rspec runs holy smokes
		click_button 'Save'

		expect(page).to have_content 'Success'
		expect(page).to have_content 'Chocolate Milk'
	end

	scenario 'adding a category to a recipe' do
		# recipe = FactoryGirl.create(:recipe)
		# recipe = Recipe.create!(title: 'toast dont care', instructions: 'burn it') #replaced by given FactoryGirl recipe = create(:recipe)
		visit "recipes/#{recipe.id}/edit"
		fill_in 'Category', with: 'BANANAS'

		click_button 'Save'
		within('.recipe_category') do
			expect(page).to have_content 'Burgers'
		end
	end

	scenario 'showing a recipe' do
		#calls factory girl, creates model, puts recipe data in database
		# recipe = FactoryGirl.create(:recipe)
		visit "recipes/#{recipe.id}"

		expect(page).to have_content recipe.title
		expect(page).to have_content recipe.instructions
		expect(page).to have_content recipe.category
	end

	scenario 'updating a recipe' do
		# recipe = FactoryGirl.create(:recipe)
		visit "recipes/#{recipe.id}/edit"

		fill_in 'Title', with: 'SECRET_TITLE'
		click_button 'Save'

		expect(page).to have_content 'SECRET_TITLE'
		expect(page).not_to have_content recipe.title
	end

	scenario 'deleting a reicpe' do
		visit "recipes/#{recipe.id}"	
		# recipe = FactoryGirl.create(:recipe)
		# recipe.destroy

		click_link 'Delete'
		# expect(page).not_to have_content 
		expect {
			visit "/recipes/#{recipe.id}"
		}.to raise_error ActiveRecord::RecordNotFound
	end
end
















