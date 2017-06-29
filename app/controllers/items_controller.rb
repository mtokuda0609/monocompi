class ItemsController < ApplicationController
  def index
    @items = Item.where(user_id: current_user)
  end

  def show
    @item = Item.find(params[:id])
  end

  def new
    @item = Item.new

    @rk_items = []
    @rk_keyword = params[:keyword]
    if @rk_keyword
      results = RakutenWebService::Ichiba::Item.search({
        keyword: @rk_keyword,
        hits: 20,
        imageFlag: 1,
      })
    
    results.each do |result|
        rk_item = Item.new(rk_read(result))
        @rk_items << rk_item
      end
    end
    
    @ys_items = []
    @ys_keyword = params[:keyword]
    if @ys_keyword
      @ys_items = Yahoo::Api.get(Yahoo::Api::Shopping::ItemSearch,{
        query: @ys_keyword
      })
    end
  end

  def create
    # 1. どの商品が選択されているかを判断する
    #Rails.logger.info(name)
    #binding.pry
    
    @item = Item.new(registration)

    if @item.save
      flash[:success] = "アイテムを追加しました。"
      redirect_to items_path
    else
      flash.now[:danger] = "アイテムを追加できませんでした。"
      render :new
    end
  end

  def destroy
    @item = Item.find(params[:id])
    @item.destroy
    flash[:success] = "アイテムを削除しました。"
    redirect_to items_url
  end

  private
  
  def rk_read(result)
    rk_code = result.code
    rk_name = result['itemName']
    rk_price = result['itemPrice']
    rk_url = result['itemUrl']
    rk_image_url = result['mediumImageUrls'].first['imageUrl'].gsub('?_ex=128x128', '')

    return {
      rk_code: rk_code,
      rk_name: rk_name,
      rk_price: rk_price,
      rk_url: rk_url,
      rk_image_url: rk_image_url,
    }
  end

  def registration
    name = params[:item][:name]    
    user_id = current_user[:id]
    rk_code = params[:item][:rk_code]
    ys_code = params[:item][:ys_code]

    rk_results = RakutenWebService::Ichiba::Item.search(itemCode: rk_code)
    rk_result = rk_results.first
    ys_result = Yahoo::Api.get(Yahoo::Api::Shopping::ItemLookup,{ itemcode: ys_code })

    rk_code = rk_result.code
    rk_name = rk_result['itemName']
    rk_price = rk_result['itemPrice']
    rk_url = rk_result['itemUrl']
    rk_image_url = rk_result['mediumImageUrls'].first['imageUrl'].gsub('?_ex=128x128', '')
    ys_code = ys_result['ResultSet']['0']['Result']['ItemCode']['0']['Code']
    ys_name = ys_result['ResultSet']['0']['Result']['0']['Name']
    ys_price = ys_result['ResultSet']['0']['Result']['0']['Price']['_value'].to_i
    ys_url = ys_result['ResultSet']['0']['Result']['0']['Url']
    ys_image_url = ys_result['ResultSet']['0']['Result']['0']['Image']['Small']
    benefit = (rk_price - ys_price).abs
    
    return {
      name: name,
      user_id: user_id,
      rk_code: rk_code,
      rk_name: rk_name,
      rk_price: rk_price,
      rk_url: rk_url,
      rk_image_url: rk_image_url,
      ys_code: ys_code,
      ys_name: ys_name,
      ys_price: ys_price,
      ys_url: ys_url,
      ys_image_url: ys_image_url,
      benefit: benefit,
    }
  end


  def item_params
    params.require(:item).permit(:name, :user_id, :benefit, :stock , :rk_code, :rk_name, :rk_price, :rk_url, :rk_image_url)
  end
  
end
