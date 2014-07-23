module RewindBBS
  module Resource
    class Posts < Grape::API
      content_type :json, 'application/json'
      content_type :hal_json, 'application/hal+json'
      formatter :hal_json, lambda { |obj, env| obj.to_json }

      desc 'Post a new post'
      params do
        requires :subject, type: String, desc: 'Subject'
        requires :content, type: String, desc: 'Content'
      end
      post do
        post = Model::Post.new(
            subject: params[:subject],
            content: params[:content]
        )
        Model::PostRepresenter.new(post)
      end
    end
  end
end
