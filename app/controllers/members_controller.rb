class MembersController < ApplicationController
before_action:login_required
  #会員一覧
  def index
    @members=Member.order("number")
  end

  def search
    @members=Member.search(params[:q])#qには検索ワードが入る
    render "index"
  end
  def show
    @member=Member.find(params[:id])
  end

  #新規作成フォーム
  def new
    @member=Member.new(birthday:Date.new(1980,1,1))#初期値指定
  end

  #更新フォーム
  def edit
    @member=Member.find(params[:id])
  end

#会員の新規登録
  def create
    @member=Member.new(params[:member])#フォームからおくられたパラメーターを使ってモデルオブジェクト@member作成
    if @member.save
      redirect_to @member,notice:"会員を登録しました"#保存に成功した時＠memberが表すpathにリダイレクト
    else
      render"new"
    end
  end

  def update
    @member=Member.find(params[:id])
    @member.assign_attributes(params[:member])
    if @member.save
      redirect_to @member,notice:"会員情報を更新しました"
    else
      render"edit"
    end
  end

  def destory
    @member=Member.find(params[:id])
    @member.destroy
    redirect_to:members,notice:"会員を排除しました"
  end



end
