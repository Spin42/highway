class CallsController < ApplicationController
  protect_from_forgery except: :create
  layout nil

  def index
    if Silo.any?
      @message = Silo.all.inject("") do |message, silo|
        message << "For #{silo.name} press #{silo.number},"
        message
      end
      @response = Twilio::TwiML::Response.new do |r|
        r.Gather numDigits: "1", action: create do |g|
          g.Say @message, voice: 'alice', language: 'en-GB', loop: 3
        end
      end
    else
      @response = Twilio::TwiML::Response.new do |r|
        r.Say "No callers, please configure your options.", voice: "alice"
      end
    end
    render text: @response.text
  end

  def create
    user_selection = params[:Digits]
    if user_selection.present?
      @silo = Silo.where(number: user_selection.to_i).first
      response = Twilio::TwiML::Response.new do |r|
        r.Say "Calling #{@silo.name}", voice: 'alice'
        r.Dial callerId: "+3278481723" do |d|
          @silo.contact_people.each do |person|
            d.Number person.phone_number
          end
        end
      end
      render text: response.text
    end
  end
end
