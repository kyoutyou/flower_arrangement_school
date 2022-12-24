class HomesController < ApplicationController
  def top
  end

  def about
  end

  def productions
    @productions = Production.all
  end

  def course
  end

  def calendar
  end
end
