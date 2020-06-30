require 'rails_helper'

RSpec.feature "ProductDetails", type: :feature, js: true do
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


  scenario "Clicks on the first product details button" do
    # ACT
    visit root_path

    # click on details button
    within first('.products > article') do
      find('a', text: 'Details »').click
    end
    # VERIFY
    expect(page).to have_css '.products-show'
    # check if products-show class exists

    page.save_screenshot('product_page_details.png')
  end

  scenario "Clicks on the first product image" do
    # ACT
    visit root_path

    # click on details button
    within first('.products > article') do
      find('img').click
    end
    # VERIFY
    expect(page).to have_css '.products-show'
    # check if products-show class exists

    page.save_screenshot('product_page_image.png')
  end

  scenario "Clicks on the first product title" do
    # ACT
    visit root_path

    # click on details button
    within first('.products > article') do
      find('h4').click
    end
    # VERIFY
    expect(page).to have_css '.products-show'
    # check if products-show class exists

    page.save_screenshot('product_page_title.png')
  end
end

