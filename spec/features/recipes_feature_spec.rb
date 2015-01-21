require 'rails_helper'

feature 'Managing Recipes', type: :feature do
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
		recipe = FactoryGirl.create(:recipe)
		# recipe = Recipe.create!(title: 'toast dont care', instructions: 'burn it') #replaced by FactoryGirl recipe = create(:recipe)
		visit "recipes/#{recipe.id}/edit"
		fill_in 'Category', with: 'BANANAS'

		click_button 'Save'
		within('.recipe_category') do
			expect(page).to have_content 'Burgers'
		end
	end

	# scenario 'showing a recipe' do

	# end

	# scenario 'updating a recipe'

	# scenario 'deleting a reicpe'
end