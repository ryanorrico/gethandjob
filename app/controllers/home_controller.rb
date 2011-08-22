class Company
  attr_accessor :name, :email, :website, :address, :city, :state, :ilk, :phone_number, :job
end

class HomeController < ApplicationController
  def index

  end

  def shake


    user = User.where(uid: session[:uid]).first

    # get your api keys at https://www.linkedin.com/secure/developer
    client = LinkedIn::Client.new('heue86hmveky', 'h1aewkKShIUwxfnL')
    rtoken = client.request_token.token
    rsecret = client.request_token.secret



    # or authorize from previously fetched access keys
    client.authorize_from_access(user.token, user.secret)

    @client = client.profile

  end

  def activate

    user = User.where(uid: session[:uid]).first

    # get your api keys at https://www.linkedin.com/secure/developer
    client = LinkedIn::Client.new('heue86hmveky', 'h1aewkKShIUwxfnL')
    rtoken = client.request_token.token
    rsecret = client.request_token.secret


   # url = 'http://api.factual.com/v2/tables/s4OOB4/read?APIKey=SxG7RRVBGk9qdK7TjcXRLTPEe1K0qxovMGfvQoYsi38speij3ifWSFIQXDVovh2U&filters={"postcode":{"$bw":"90401"}}&sort={"email":1}'
    
     url = 'http://api.factual.com/v2/tables/s4OOB4/read?APIKey=SxG7RRVBGk9qdK7TjcXRLTPEe1K0qxovMGfvQoYsi38speij3ifWSFIQXDVovh2U'
    
    uri = URI.escape(url)
    jobs = ["Software Developer", "Administrative Assistant", "Project Manager", "CEO", "CTO", "CIO", "COO", "Custodian", "Artist", "Guru", "President", "Executive Administrative Assistant", "Barber", "CFO", "Market Manager", "Product Design", "Brofessional"]
    
    @companies = own_factual(uri, jobs)
    
    # Shortcut

    # or authorize from previously fetched access keys
    client.authorize_from_access(user.token, user.secret)

    @connections = client.connections

    # connections["all"].each do |connection|
    # p connection["first_name"]
    # p connection["first_name"]
    # p connection["industry"]
    # p connection["picture_url"]
    # end


    p @connections

  end

  private
    def own_factual(url, jobs)
       
       resp = Net::HTTP.get_response(URI.parse(url))


      #puts resp.body
      parsed_json = JSON.parse(resp.body)
      puts parsed_json
      companies = []
      parsed_json["response"]["data"].each do |longUrl|
         
        company = Company.new
        company.name = longUrl[2]
        company.email = longUrl[13]
        company.address = longUrl[3]
        company.city = longUrl[6]
        company.state = longUrl[7]
        company.phone_number = longUrl[9]
        company.ilk = longUrl[11]
        company.website = longUrl[12]
        company.job = jobs[Random.rand(16)]

        companies << company
      end
      
      p companies
      return companies
    end
end
