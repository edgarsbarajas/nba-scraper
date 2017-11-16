class RosterController < ApplicationController
  require 'nokogiri'
  require 'open-uri'

  def index
    team = params[:team]
    roster = []

    response = Nokogiri::HTML(open("http://www.nba.com/#{team}/roster"))

    response.css(".roster__player").each_with_index do |player, index|
      full_name = player.css(".roster__player__header__heading").text
      pic_url = player.css(".roster__player__bust").attr("src").value[2..-1]
      position = player.css(".roster__player__header_position").text.split(" ")[0]
      jersey_number = player.css(".roster__player__header_jnumber").text

      height = player.css(".roster__player__info__bio__height").first.next_element.text
      weight = player.css(".roster__player__info__bio__weight").first.next_element.text
      dob = player.css(".roster__player__info__bio__dob").first.next_element.text
      prior_to_nba = player.css(".roster__player__info__bio__prio").first.next_element.text
      country = player.css(".roster__player__info__bio__country").first.next_element.text
      years_pro = player.css(".roster__player__info__bio__years").first.next_element.text

      games_played = player.css(".roster__player__info__stats__games").first.next_element.text
      ppg = player.css(".roster__player__info__stats__ppg").first.next_element.text
      rpg = player.css(".roster__player__info__stats__rpg").first.next_element.text
      apg = player.css(".roster__player__info__stats__apg").first.next_element.text


      roster.push({id: index, name: full_name, jersey_number: jersey_number, pic_url: pic_url, position: position, height: height, weight: weight, dob: dob, prior_to_nba: prior_to_nba, country: country, years_pro: years_pro, games_played: games_played, ppg: ppg, rpg: rpg, apg: apg})
    end

    render :json => roster
  end
end
