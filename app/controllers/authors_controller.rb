class AuthorsController < ApplicationController
    def home
        authors=Author.all
        response = authors.map do |author|
            {
              id: author.id,
              name: author.name,
              username: author.username,
              articles: author.article_ids,
              profile_views: author.views,
            }
        end
        render json: response
    end

    def details
        un = params.fetch(:username, "")
    
        if un!=""
            author = Author.find_by(username: un)
            unless author
                render json: {error: "No such author exists"}, status: :not_found
                return
            end
            if un!=current_user.username
                author.views+=1
            end
            response =
            {
            id: author.id,
            name: author.name,
            username: author.username,
            interests: author.interest,
            speciality: author.speciality,
            articles: author.article_ids,
            profile_views: author.views,
            created_at: author.created_at,
            updated_at: author.updated_at
            }
            author.save
            render json: response
        else
            response={}
            render json: response
        end
    end

    def profile
        unless current_user
            render json: {error: "Sign up or login"}, status: :not_found
            return
        end
        un=current_user.username
        author = Author.find_by(username: un)
        response =
            {
            id: author.id,
            name: author.name,
            username: author.username,
            interest: author.interest,
            speciality: author.speciality,
            articles: author.article_ids,
            profile_views: author.views,
            follows: author.following_ids,
            saved_posts: author.saved_ids,
            shared_lists: author.shared_lists,
            created_at: author.created_at,
            updated_at: author.updated_at
            }
        render json: response
    end

    def profile_edit
        unless current_user
            render json: {error: "Sign up or login"}, status: :not_found
            return
        end
        un=current_user.username
        author = Author.find_by(username: un)
        new_name=params.fetch(:name, "")
        new_interest=params.fetch(:interest, "")
        new_speciality=params.fetch(:speciality, "")
        if new_name!=""
            author.name=new_name
        end
        
        if new_interest!=""
            author.interest=new_interest
        end
        
        if new_speciality!=""
            author.speciality=new_speciality
        end
        

        author.save

        response =
            {
            id: author.id,
            name: author.name,
            username: author.username,
            interest: author.interest,
            speciality: author.speciality,
            articles: author.article_ids,
            profile_views: author.views,
            saved_posts: author.saved_ids,
            shared_lists: author.shared_lists,
            created_at: author.created_at,
            updated_at: author.updated_at,
            }
        render json: response
    end

    def my_posts
        unless current_user
            render json: {error: "Sign up or login"}, status: :not_found
            return
        end
        un=current_user.username
        author = Author.find_by(username: un)
        article_ids=author.article_ids
        l=article_ids.length()
        articles=[]
        ctr=0
        while ctr<l
            id=article_ids[ctr]
            curr_article=Article.find(id)
            if curr_article
                temp=
                {
                    id: curr_article.id,
                    title: curr_article.title,
                    topic: curr_article.topic,
                    text: curr_article.text,
                    image_url: curr_article.image.attached? ? url_for(curr_article.image) : nil,
                    likes: curr_article.likes.length(),
                    views: curr_article.views,
                    comments: curr_article.comments.length(),
                }
                articles << temp
            end
            ctr+=1
        end
        response =
            {
                "articles"=>articles
            }
        render json: response
    end

    def follow
        un = params.fetch(:username, "")
    
        if un!=""
            author = Author.find_by(username: un)
            unless author
                render json: {error: "No such author exists"}, status: :not_found
                return
            end
            this_author=Author.find_by(username: current_user.username)
            if un!=current_user.username
                unless this_author.following_ids.include?(un)
                    this_author.following_ids << un
                    this_author.save
                end
                render json: {message: "Author followed successfully"}, status: :ok
            else
                render json: {error: "Can not follow yourself"}, status: :unauthorized
            end
        else
            render json: {error: "Pass a username to follow"}, status: :unprocessable_entity
        end
    end

    def view_saved
        unless current_user
            render json: {error: "Sign up or log in"}, status: :unauthorized
            return
        end

        un=current_user.username
        saved_ids=Author.find_by(username: un).saved_ids

        l=saved_ids.length()
        articles=[]
        ctr=0
        while ctr<l
            id=saved_ids[ctr]
            curr_article=Article.find(id)
            if curr_article
                temp=
                {
                    id: curr_article.id,
                    title: curr_article.title,
                    topic: curr_article.topic,
                    likes: curr_article.likes.length(),
                    views: curr_article.views,
                    comments: curr_article.comments.length(),
                }
                articles << temp
            end
            ctr+=1
        end
        response =
            {
                "articles"=>articles
            }
        render json: response
    end

end
