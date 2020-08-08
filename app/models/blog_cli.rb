
class BlogCLI
    
    attr_reader :current_user, :last_input 

    def run
        puts "\nWelcome to Blogging!"
        self.login
        self.menu
    end

    def login
        puts "\nEnter your name to login:"
        @current_user = Author.find_or_create_by(:name => user_input)
        puts "\nYou are now logged in as #{current_user.name.capitalize}."
    end

    def menu
        puts "\nWhat would you like to do?"
        puts "\n1. Create a post"
        puts "2. List YOUR posts"
        puts "3. List ALL posts"
        puts "4. Exit"
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
        puts "\nPlease enter the content of your new post:"
        post_info[:content] = user_input

        post = @current_user.posts.build(post_info)
        post.save

        puts "\nSaved Post ##{post.id}."
        self.menu
    end 

    def user_input
        @last_input = gets.strip
    end 

    def list_user_posts
        puts "\nHere are all of your posts #{current_user.name.capitalize}:"
        puts "\n"
        current_user.posts.each {|post| puts "Post ##{post.id} - Title: #{post.title}"}
        
        puts "\nEnter the Post ID you would like to view."
        if (1..Post.all.size).include?(user_input.to_i)
            self.show_user_post
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
            puts "\n#{post.content}"
            self.menu
        else 
            puts "\nInvalid input. Please try again.".colorize(:light_red)
            self.list_user_posts
        end 
    end 

    def list_all_posts
        puts "\nHere are all of the posts in the database:"
        puts "\n"
        Post.all.each {|post| puts "Post ##{post.id} - #{post.title} - #{post.author.name}"}

        puts "\nEnter the Post ID you would like to view."
        if (1..Post.all.size).include?(user_input.to_i)
            self.show_all_posts
        else 
            puts "\nInvalid input. Please try again.".colorize(:light_red)
            self.list_all_posts
        end
    end

    def show_all_posts
        if post = Post.all.find_by(:id => last_input.to_i)
            puts "\n******************************************]\n"
            puts "\nPost ##{post.id}"
            puts "Title: #{post.title}"
            puts "By: #{post.author.name}"
            puts "\n#{post.content}"
            self.menu
        else 
            puts "\nInvalid input. Please try again.".colorize(:light_red)
            self.list_all_posts
        end 
    end 

end 