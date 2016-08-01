class SessionsController < ApplicationController
  def create
    # get access_token
    resp = Faraday.post("https://github.com/login/oauth/access_token") do |req|
      req.headers['Accept'] = 'application/json'     
      req.params['client_id'] = ENV['GITHUB_CLIENT_ID']
      req.params['client_secret'] = ENV['GITHUB_CLIENT_SECRET']
      req.params['redirect_uri'] = "http://localhost:3000/auth"
      req.params['scope'] = "user repo"
      req.params['code'] = params[:code]
    end
    body = JSON.parse(resp.body)
    session[:token] = body["access_token"]

    redirect_to root_path
  end
end
