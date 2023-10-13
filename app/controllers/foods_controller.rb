class FoodsController < ApplicationController
  def index
    @user = current_user
    @foods = @user.foods.all
  end

  def new
    @food = Food.new
  end

  def create
    @user = current_user
    @food = @user.foods.build(post_food)
    if @food.save
      flash[:success] = 'Food successfully added.'
      redirect_to user_foods_path, notice: 'Food was successfully added.'
    else
      flash[:error] = 'error while adding food.'
      render :new
    end
  end

  def destroy
    @food = Food.find(params[:id])
    authorize! :destroy, @food
    if @food.destroy
      flash[:notice] = 'Food was successfully deleted.'
    else
      flash[:alert] = 'Failed to delete food.'
    end
    redirect_to user_foods_path, notice: 'Food was successfully deleted.'
  end

  private

  def post_food
    params.require(:food).permit(:name, :measurement_unit, :price, :quantity)
  end
end
