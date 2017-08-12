class RefundsController < ApplicationController
  def new
  end

  def create

    Stripe.api_key = Rails.configuration.stripe[:secret_key]

    refund = Stripe::Refund.create(
      charge: current_user.charge
    )

    if refund
      current_user.charge = "refund id = #{refund.id}"
      current_user.role = :standard
      current_user.save!

      wikis = Wiki.created_by(current_user).limited_access
      wikis.each do |wiki|
        wiki.private = false
        if wiki.save!
          flash[:alert] = "All private wikis are now public"
        end
      end

    else
      flash[:alert] = "Refund did not go through. Please contact support  to process your refund."
    end
  end
end
