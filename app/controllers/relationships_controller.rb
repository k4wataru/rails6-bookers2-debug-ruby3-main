class RelationshipsController < ApplicationController
  def follow(user)   # フォローするとき
    relationships.create(followed_id: user.id)
  end
  
  def unfollow(user)   # フォローを外すとき
    relationships.find_by(followed_id: user.id).destroy
  end

  def following?(user)   # フォローしているか確認するとき
    following.include?(user)
  end
  
  def create   # フォロー追加機能
    user = User.find(params[:user_id])
    current_user.follow(user)
    redirect_to request.referer
  end
  
  def destroy   # フォロー削除機能
    user = User.find(params[:user_id])
    current_user.unfollow(user)
    redirect_to request.referer
  end
   
  def followers   # フォロワー一覧表示
    user = User.find(params[:user_id])
    @users = user.followers
  end

  def following   # フォロー一覧表示
    user = User.find(params[:user_id])
    @users = user.following
  end
end
