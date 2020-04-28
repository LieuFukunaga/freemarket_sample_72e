class CardController < ApplicationController
  # フォーク前のバージョン
  # before_action :set_card, only: [:show, :destroy]
  # require "payjp"

  # def new
  #   @card = Card.new
  #   card = Card.where(user_id: current_user.id)
  #   if card.exists?
  #     redirect_to card_path(card[0].id)
  #   end
  # end

  # def create
  #   Payjp.api_key = ENV['PAYJP_PRIVATE_KEY']
  #   if params['payjpToken'].blank?
  #     redirect_to action: "new"
  #   else
  #     customer = Payjp::Customer.create(card: params['payjpToken'])
  #     card = Card.new(user_id: current_user.id, customer_id: customer.id, card_id: customer.default_card)
  #     card.save!
  #     if card.save!
  #       redirect_to card_path(card)
  #     else
  #       redirect_to action: "new"
  #     end
  #   end
  # end

  # def show
  #   card = Card.where(user_id: current_user.id).first
  #   if card.blank?
  #     redirect_to action: "create"
  #   else
  #   Payjp.api_key = ENV['PAYJP_PRIVATE_KEY']
  #   customer = Payjp::Customer.retrieve(card.customer_id)
  #   @default_card_information = Payjp::Customer.retrieve(card.customer_id).cards.data[0]
  #   end
  # end

  # def destroy
  #   if @card.destroy
  #     redirect_to root_path
  #   else
  #     redirect_to card_path(@card)
  #   end
  # end

  # private

  # def set_card
  #   @card = Card.find(params[:id])
  # end



  # フォーク後
  require "payjp"

  # 現在ログインしているユーザーに紐付いたカードがあれば個別ページに遷移
  def new
    card = Card.where(user_id: current_user.id)
    redirect_to action: "show" if card.exists?
  end

  #payjpとCardのデータベース作成を実施します。
  def pay
    # binding.pry
    Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
    if params['payjp-token'].blank?
      redirect_to action: "new"
    else
      customer = Payjp::Customer.create(
        # description: '登録テスト',
        # email: current_user.email,
        card: params['payjp-token'],
        metadata: {user_id: current_user.id},
      )
      @card = Card.new(user_id: current_user.id, customer_id: customer.id, card_id: customer.default_card)
      if @card.save
        redirect_to action: "show"
      else
        redirect_to action: "pay"
      end
    end
  end

  #PayjpとCardデータベースを削除します
  def delete
    card = Card.where(user_id: current_user.id).first
    if card.blank?
    else
      Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
      customer = Payjp::Customer.retrieve(card.customer_id)
      customer.delete
      card.delete
    end
      redirect_to action: "new"
  end

  #Cardのデータpayjpに送り情報を取り出します
  def show
    card = Card.where(user_id: current_user.id).first
    if card.blank?
      redirect_to action: "new"
    else
      Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
      customer = Payjp::Customer.retrieve(card.customer_id)
      @default_card_information = customer.cards.retrieve(card.card_id)
    end
  end

end
