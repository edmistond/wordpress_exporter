class Post
	attr_accessor :id, :title, :tags, :date, :link, :content, :comments, :markdown_content

	def initialize(id, title)
		@id = id
		@title = title
	end

    def comment_count
        return @comments.length unless comments == nil
        return 0
    end
end

class Comment
    attr_accessor :author_name, :content, :date, :markdown_content
end
