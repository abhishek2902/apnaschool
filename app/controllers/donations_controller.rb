# app/controllers/donations_controller.rb

class DonationsController < ApplicationController
  def new
  end

  def create
    payment = PayPal::SDK::REST::Payment.new({
      intent: "sale",
      payer: {
        payment_method: "paypal"
      },
      redirect_urls: {
        return_url: donate_execute_url,
        cancel_url: donate_cancel_url
      },
      transactions: [{
        item_list: {
          items: [{
            name: "Donation",
            sku: "donation",
            price: params[:amount],
            currency: "USD",
            quantity: 1
          }]
        },
        amount: {
          total: params[:amount],
          currency: "USD"
        },
        description: "Donation to School"
      }]
    })

    if payment.create
      redirect_url = payment.links.find { |v| v.rel == "approval_url" }.href
      redirect_to redirect_url, allow_other_host: true
    else
      render plain: payment.error.inspect
    end
  end

  def execute
    payment = PayPal::SDK::REST::Payment.find(params[:paymentId])
    if payment.execute(payer_id: params[:PayerID])
      # You can now save the donation info
      redirect_to donate_path, notice: "Thank you for your donation!"
    else
      render plain: payment.error.inspect
    end
  end

  def cancel
    redirect_to donate_path, alert: "Donation was cancelled."
  end
end
