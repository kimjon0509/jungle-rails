require 'rails_helper'

RSpec.feature "AddToCarts", type: :feature, js: true do
  # SETUP
  before :each do
    @category = Category.create! name: 'Apparel'

    10.times do |n|
      @category.products.create!(
        name:  Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99
      )
    end
  end


  scenario "Clicks on the first product" do
    # ACT
    visit root_path

    expect(page).to have_content('My Cart (0)')
    # within nav bar

    #click on the add button 
    within first('.products > article') do
      find_button('Add').click
    end
    # page.first('img').click

    # DEBUG
    # VERIFY
    expect(page).to have_content('My Cart (1)')
    page.save_screenshot('add_to_cart.png')
    # check if products-show class exists
  end

  # scenario "Clicks on the first product" do
  #   # ACT
  #   visit root_path

  #   expect(page).to have_content('My Cart (0)')
  #   # within nav bar

  #   # range(1,10)
  #   # keep track of index
  #   # nth:child

  #   page.all(:css, '.button_to').each do |element|
  #     within (element) do
  #       sleep 4
  #       puts element.find_button('Add').trigger('click')
  #       # find_button('Add').click
  #     end

  #     # element.click
  #     # puts element.inspect
  #   end

  #   puts 'finished'

  #   # DEBUG
  #   # VERIFY
  #   expect(page).to have_content('My Cart (10)')
  #   page.save_screenshot('add_to_cart_all.png')
  #   # check if products-show class exists
  # end
end
