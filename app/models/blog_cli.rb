
class BlogCLI
    
    attr_reader :current_user, :last_input 

    def run
        puts "\nWelcome to Blogging!"
        self.login
        self.menu
    end

    def login
        puts "\nEnter your name to login:"
        @current_user = Author.find_or_create_by(:name => user_input.downcase.capitalize)
        puts "\nYou are now logged in as #{current_user.name.downcase.capitalize}.".colorize(:blue)
    end

    def menu
        puts "\nWhat would you like to do?"
        puts "\n1. Create a post"
        puts "2. List YOUR posts"
        puts "3. List ALL posts"
        puts "4. Find posts by category"
        puts "5. Exit"
        menu_loop
    end

    def menu_loop
        while user_input != "exit"
            case last_input.to_i
            when 1
                self.create_post
                break
            when 2
                self.list_user_posts
                break
            when 3
                self.list_all_posts
                break
            when 4
                self.list_categories
                break
            when 5
                exit 
            else
                puts "\nInvalid input. Try again."
            self.menu
            break
            end 
        end 
    end 

    def create_post
        post_info = {}
        puts "\nPlease enter the title of your new post:"
        post_info[:title] = user_input 
        puts "\nPlease enter the category of your new post:"
        category = user_input.downcase.capitalize
        puts "\nPlease enter the content of your new post:"
        post_info[:content] = user_input

        post = @current_user.posts.build(post_info)
        post.save

        post.build_category(:name => category)
        post.save 

        puts "\nPost ##{post.id}".colorize(:light_red) + " created at #{post.created_at}.".colorize(:blue)
        self.menu
    end 

    def user_input
        @last_input = gets.strip
    end 

    def list_user_posts
        puts "\nHere are all of your posts #{current_user.name.capitalize}:".colorize(:blue)
        puts "\n"
        current_user.posts.each {|post| puts "Post ##{post.id} - #{post.title}"}
        
        puts "\nEnter the Post ID you would like to view. Enter 'back' to go back to the menu."
        if (1..Post.all.size).include?(user_input.to_i)
            self.show_user_post
        elsif last_input == 'back'
            self.menu
        else
            puts "\nInvalid input. Please try again.".colorize(:light_red)
            self.list_user_posts
        end
    end 

    def show_user_post
        if post = current_user.posts.find_by(:id => last_input.to_i)
            puts "\n******************************************]\n"
            puts "\nPost ##{post.id}"
            puts "Title: #{post.title}"
            puts "By: #{post.author.name}"
            puts "Category: #{post.category.name}"
            puts "Date Created: #{post.created_at}"
            puts "\n#{post.content}"
            self.menu
        else 
            puts "\nInvalid input. Please try again.".colorize(:light_red)
            self.list_user_posts
        end 
    end 

    def list_all_posts
        puts "\nHere are all of the posts in the database:".colorize(:blue)
        puts "\n"
        Post.all.each {|post| puts "Post ##{post.id} - #{post.title} - #{post.author.name}"}

        puts "\nEnter the Post ID you would like to view. Enter 'back' to go back to the menu."
        if (1..Post.all.size).include?(user_input.to_i)
            self.show_all_post
        elsif last_input == 'back'
            self.menu
        else 
            puts "\nInvalid input. Please try again.".colorize(:light_red)
            self.list_all_posts
        end
    end

    def show_all_post
        if post = Post.all.find_by(:id => last_input.to_i)
            puts "\n******************************************]\n"
            puts "\nPost ##{post.id}"
            puts "Title: #{post.title}"
            puts "By: #{post.author.name}"
            puts "Category: #{post.category.name}"
            puts "Date Created: #{post.created_at}"
            puts "\n#{post.content}"
            self.menu
        else 
            puts "\nInvalid input. Please try again.".colorize(:light_red)
            self.list_all_posts
        end 
    end 

    def list_categories
        puts "\nHere are the available categories of posts in the database:".colorize(:blue)
        puts "\n"
        Category.all.each {|category| puts category.name}.uniq

        puts "\nWhich category would you like to show posts for?"
        if category = Category.all.find_by(:name => user_input.downcase.capitalize)
            puts "\nHere are all of the ".colorize(:blue) + "#{last_input}".colorize(:light_red) + " posts:".colorize(:blue)
            puts "\n"
            category.posts.each {|post| puts "Post ##{post.id} - #{post.title} - #{post.author.name} - #{post.category.name}"}
            self.prompt_category_post
        else 
            puts "\nThere are no posts with #{last_input} as the category. Please try again.".colorize(:light_red)
            self.list_categories
        end 
    end

    def prompt_category_post
        puts "\nEnter the Post ID you would like to view. Enter 'back' to go back to the menu."
        if (1..Post.all.size).include?(user_input.to_i)
            self.show_category_post
        elsif last_input == 'back'
            self.menu
        else
            puts "\nInvalid input. Please try again.".colorize(:light_red)
            self.prompt_category_post
        end
    end

    def show_category_post
        if post = Post.all.find_by(:id => last_input.to_i)
            puts "\n******************************************]\n"
            puts "\nPost ##{post.id}"
            puts "Title: #{post.title}"
            puts "By: #{post.author.name}"
            puts "Category: #{post.category.name}"
            puts "Date Created: #{post.created_at}"
            puts "\n#{post.content}"
            self.menu
        else 
            puts "\nInvalid input. Please try again.".colorize(:light_red)
            self.list_all_posts
        end 
    end 


end 