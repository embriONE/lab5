module Comments
    def connection(routes)
      if routes.nil?
        puts "No route matches for #{self}"
        return
      end
  
      loop do
        print 'Choose verb to interact with comments (SHOW/ADD) / q to exit: '
        verb = gets.chomp
        break if verb == 'q'
        if (verb != "ADD" && verb != "SHOW")
          puts "Wrong verb!" 
          next
        end
  
        action = nil
  
  
        action.nil? ? routes[verb].call : routes[verb][action].call
      end
    end
  end
  
  
  
  
  module Resource
    def connection(routes)
      if routes.nil?
        puts "No route matches for #{self}"
        return
      end
  
      loop do
        print 'Choose verb to interact with resources (GET/POST/PUT/DELETE) / q to exit: '
        verb = gets.chomp
        break if verb == 'q'
        if (verb != "GET" && verb != "POST" && verb != "PUT" && verb != "DELETE")
          puts "Wrong verb!" 
          next
        end
  
        action = nil
  
        if verb == 'GET'
          print 'Choose action (index/show) / q to exit: '
          action = gets.chomp
          break if action == 'q'
          if (action != "index" && action != "show")
            puts "Wrong verb!" 
            next
          end
        end
  
        action.nil? ? routes[verb].call : routes[verb][action].call
      end
    end
  end
  
  class CommentsController
    extend Comments
    def initialize
      $comments = []
    end
  
    
  
    def show
  
      if $posts.empty? 
        puts "No posts"
        return
      end
      
      
      
      puts "Enter post ID to see its comms"
      id = gets.to_i 
      if $comments[id-1].empty? 
        puts "no comments bro...."
        return
      end
      puts "Posts ID #{id}: "
      puts $posts[id-1]
      puts "Comments: "
      $comments[id-1].each.with_index do |string, index|
        puts "#{index+1}:     #{string}"
      end
    end
  
    
    def add
      if $posts.empty? 
        puts "No posts"
        return
      end
      puts "Enter post ID to see its comms"
      id = gets.to_i
      puts "Posts ID #{id}: "
      puts $posts[id-1]
      puts "Enter your comment, brother: "
      string = gets.chomp
      $comments[id-1].push(string) 
      puts "Finished"
    end
    
  end
  
  
  class PostsController
    extend Resource
    
  
  
    
    def initialize
      $posts = []
    end
  
    def index
      if $posts.empty? 
        puts "No posts"
        return
      end
      $posts.each.with_index do |string, index|  
        puts "Index: #{index+1} post: #{string}"
      end
    end
  
    def show
      puts "Enter post ID to find it: "
      id = gets.to_i
      while !id.integer? do
        puts "Brother, you need to type in the number, not letter"
        id = gets.to_i
      end
      $posts.each.with_index do |string, index|
        if (index+1).eql?(id)
          puts "Here it is, brother: #{string}"
        end
      end
    end
  
    def create
      commentsList = []
      puts "Enter the post, brother: "
      string = gets.chomp
      $posts.push(string)
      $comments.push(commentsList)
      puts "Brother, your post added. Its ID is #{$posts.size}"
    end
  
    def update
      puts "Do you think this lil kid will be offended? Enter the ID and we will fix this, brother: "
      id = gets.to_i
      puts "Enter something. Softly: "
      str = gets.chomp
      $posts.each.with_index do |string, index|
        if index.eql? id
          string = str
        end
      end
    end
  
    def destroy
      puts "He still angry? He called his mom? Enter ID and you may think that nothing happened, brother: "
      id = gets.to_i
      list = []
      commentsList = []
      $posts.each.with_index do |string, index|
        if index != id-1
          commentsList.push($comments[index])
          list.push(string)
        end
      end
        if list.empty?
          puts 'No posts with such ID'
        else 
          puts 'Done. Sleep calm.'
          $posts = list
          $comments = commentsList
        end
    end
  end
  
  class Router
    def initialize
      @routes = {}
    end
  
    def init
      resources(PostsController, CommentsController, 'posts')
  
      loop do
        print 'Choose resource you want to interact (1 - Posts, 2 - Comments, q - Exit): '
        choise = gets.chomp
  
        PostsController.connection(@routes['posts']) if choise == '1'
        CommentsController.connection(@routes['posts']) if choise == '2'
        break if choise == 'q'
      end
  
      puts 'Good bye!'
    end
  
    def resources(klass1, klass2, keyword)
      postsController = klass1.new
      commentsController = klass2.new
      @routes[keyword] = {
        'SHOW' => commentsController.method(:show),
        'ADD' => commentsController.method(:add),
        'GET' => {
          'index' => postsController.method(:index),
          'show' => postsController.method(:show)
        },
        'POST' => postsController.method(:create),
        'PUT' => postsController.method(:update),
        'DELETE' => postsController.method(:destroy)
      }
    end
  end
  
  router = Router.new
  
  router.init