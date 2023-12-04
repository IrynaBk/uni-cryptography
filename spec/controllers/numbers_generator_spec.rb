# # spec/controllers/numbers_controller_spec.rb

# require 'rails_helper'

# RSpec.describe NumbersController, type: :controller do
#   describe 'GET #generate' do
#     it 'assigns @numbers and @period' do
#       get :generate, params: { x: 1, n: 10 }
#       expect(assigns(:numbers)).to be_present
#       expect(assigns(:period)).to be_present
#     end

#     it 'renders the generate template' do
#       get :generate, params: { x: 1, n: 10 }
#       expect(response).to render_template('generate')
#     end

#     context 'with invalid parameters' do
#       it 'assigns default values to x and n' do
#         get :generate, params: { x: 'invalid', n: 'invalid' }
#         expect(assigns(:numbers)).to be_present
#         expect(assigns(:period)).to be_present
#       end

#       it 'sets flash error message' do
#         get :generate, params: { x: 'invalid', n: 'invalid' }
#         expect(flash[:error]).to include('Parameters should be non-negative number.')
#       end
#     end

#     context 'with valid parameters' do
#       it 'generates an array of pseudo-random numbers' do
#         # Example: for x = 4, n = 4
#         get :generate, params: { x: 4, n: 4 }
#         numbers = assigns(:numbers)
#         expected_numbers = [4312, 808, 2175, 6539]
        
#         expect(numbers).to be_an(Array)
#         expect(numbers).to eq(expected_numbers)
#       end

#       it 'generates another array of pseudo-random numbers' do
#         # Example: for x = 1, n = 5
#         get :generate, params: { x: 1, n: 5 }
#         numbers = assigns(:numbers)
#         expected_numbers = [3128, 3140, 7876, 6739, 317]
        
#         expect(numbers).to be_an(Array)
#         expect(numbers).to eq(expected_numbers)
#       end
#     end
#   end

#   describe 'GET #download' do
#     it 'sends a file for download' do
#       numbers = [1, 2, 3, 4, 5]
#       filename = 'numbers.txt'
      
#       expect(controller).to receive(:send_data).with(numbers.join("\n"), filename: filename)
      
#       get :download, params: { numbers: numbers, filename: filename }
#     end
#   end
# end
