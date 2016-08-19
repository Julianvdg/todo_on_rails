require 'rails_helper'

def fill_in_todo(fill)
    fill_in 'todo_title', with: "#{fill}"
    page.execute_script("$('form').submit()")
end

def expect_to_have(id, amount)
    expect( page.find(:css, "#{id}").text ).to eq "#{amount}"
end

feature 'Manage tasks', js: true do
    scenario 'add a new task' do

        visit todos_path
        fill_in_todo('Be Batman')

        expect(page).to have_content('Be Batman')
    end
    
    scenario 'counter changes' do
      visit todos_path
      fill_in_todo('Eat a cheese burger')

      sleep(1)
        
      expect_to_have('span#todo-count', '1')

    end
    
    scenario 'complete a task' do
      visit todos_path
      fill_in_todo('Eat a cheese burger')

      check('todo-1')

      sleep(1)
        
      expect_to_have('span#todo-count', '0')

    end
    
    scenario 'Check counts' do
        visit todos_path
        fill_in_todo('go to candy mountain')
        fill_in_todo('go to candy mountain')
        fill_in_todo('go to candy mountain')
        
        check('todo-1')
        check('todo-2')
        
        expect_to_have('span#total-count', '3')
        expect_to_have('span#completed-count', '2')
        expect_to_have('span#todo-count', '1')

    end
    
     scenario 'Check Cleanup' do
        visit todos_path
        fill_in_todo('go to candy mountain')   
        fill_in_todo('go to candy mountain')
        fill_in_todo('go to candy mountain')
        
        check('todo-1')
        check('todo-2')
         
        click_link('clean-up')
        
        expect_to_have('span#total-count', '1')
        expect_to_have('span#completed-count', '0')
        expect_to_have('span#todo-count', '1')
    
    end
end