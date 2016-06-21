RSpec.feature 'A user performs a search with the search box', js: true, vcr: true, slow: true do
  let(:kereru) {Kereru.new}
  let(:search_page) {kereru.search}
  let(:search_category) {search_page.search_category}
  let(:search_term_literal) { 'Wellington' }

  context 'on the records index page' do
    before do
      search_page.load(query: {
        text: search_term_literal
      })
    end

    feature 'Search within a category by clicking toplevel categories' do
      context "the user clicks the 'Search' button" do
        it 'performs a search with the users entered input' do
          search_page.wait_until_search_category_visible

          pwork = Capybara.current_session
          pwork.driver.save_screenshot 'screenshot2.png'
          pwork.save_and_open_page 'page2.html'

          puts "ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ"
          puts find(:css, ".dropdown").text
          puts find(:css, ".dropdown li a").path
          # puts find(:css, ".dropdown li a:eq(0)").visible?
          expect(search_page).to have_dropdown_category_btn
          search_page.dropdown_category_btn.click
          search_page.toptier_category_btns[1].click
          # search_category_node = search_page.search_category
          # puts search_category_node.inspect

          # if search_category.dropdown_button.visible?
          #   puts "--->"+search_category_node.text
          # end

          # puts search_category_node.dropdown_button
          # puts search_category_node.category_tabs
          puts pwork.current_url
          expect(page).to have_current_path("/records?text=#{search_term_literal}&tab=Images")
          puts "ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ"

          # find(:css, ".dropdown li a").click
          Capybara::Screenshot.screenshot_and_open_image 
          pwork.driver.save_screenshot 'screenshot3.png'
          pwork.save_and_open_page 'page3.html'          
          
          query_hash = Rack::Utils.parse_nested_query(URI.parse(page.current_url).query)
          expect(query_hash.deep_symbolize_keys).to eq({
            text: search_term_literal,          
            tab: "Images"
          })
        end
      end
    end

    feature 'Search within a category by clicking dropdown-level categories' do
      context "the user clicks the 'Search' button" do
        it 'performs a search with the users entered input' do
          search_page.wait_until_search_category_visible

          pwork = Capybara.current_session
          pwork.driver.save_screenshot 'screenshot2.png'
          pwork.save_and_open_page 'page2.html'

          puts "ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ"
          # puts find(:css, ".dropdown").text
          # puts find(:css, ".dropdown li a").path
          # find(:css, ".dropdown li a").click
        
          expect(search_page).to have_dropdown_category_btn
          puts search_page.dropdown_category_btn.path
          search_page.dropdown_category_btn.click          

          sleep 3
          pwork.save_and_open_page 'page4.html'  
          Capybara::Screenshot.screenshot_and_open_image 
          puts search_page.lowtier_category_btns[0]
          search_page.lowtier_category_btns[0].click
          # search_category_node = search_page.search_category
          # puts search_category_node.inspect

          # if search_category.dropdown_button.visible?
          #   puts "--->"+search_category_node.text
          # end

          # puts search_category_node.dropdown_button
          # puts search_category_node.category_tabs
          puts pwork.current_url
          expect(page).to have_current_path("/records?text=#{search_term_literal}&tab=Books")
          puts "ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ"

          # find(:css, ".dropdown li a").click
          Capybara::Screenshot.screenshot_and_open_image 
          pwork.driver.save_screenshot 'screenshot3.png'
                   
          
          query_hash = Rack::Utils.parse_nested_query(URI.parse(page.current_url).query)
          expect(query_hash.deep_symbolize_keys).to eq({
            text: search_term_literal,          
            tab: "Books"
          })
        end
      end
    end
  end

end


# RSpec.feature 'A user performs a search with the search box', js: true, vcr: true, slow: true do
#   let(:kereru) {Kereru.new}
#   let(:search_page) {kereru.search}
#   # let(:search_category) {search_page.search_category}

#   context 'on the records index page' do
#     before {search_page.load}

#     feature 'Performing a search' do
#       context "the user clicks the 'Search' button" do
#         it 'performs a search with the users entered input' do
#           search_page.search_input.set 'wellington'


#           # :( capybara doesn't appear to have support for waiting for the URL to change
#           sleep 5


#           pwork = Capybara.current_session
#           pwork.driver.save_screenshot 'screenshot2.png'
#           pwork.save_and_open_page 'page2.html'
        
# 		  search_page.wait_until_search_category_visible
#           sleep 5
# 		Capybara::Screenshot.screenshot_and_save_page
# 		Capybara::Screenshot.screenshot_and_open_image 
#           puts "ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ"
#           puts find(:css, ".dropdown").text
#           puts find(:css, ".dropdown li a").path
#           puts find(:css, ".dropdown li a").visible?

#           # search_category_node = search_page.search_category
#           # puts search_category_node.inspect

#           # if search_category.dropdown_button.visible?
#           # 	puts "--->"+search_category_node.text
#           # end

#           # puts search_category_node.dropdown_button
#           # puts search_category_node.category_tabs
#           puts pwork.current_url
#           puts "ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ"

#           find(:css, ".dropdown li a").click

#           pwork.driver.save_screenshot 'screenshot3.png'
#           pwork.save_and_open_page 'page3.html'          
          

#           query_hash = Rack::Utils.parse_nested_query(URI.parse(page.current_url).query)
#           expect(query_hash.deep_symbolize_keys).to eq({
#             text: 'Wellington',
#           })
#         end
#       end
#     end
#   end

# end