require 'open-uri'
require 'nokogiri'

cities 			= ['newyork', 'chicago']
search_terms 	= ['ruby']



cities.each do |city|
	search_terms.each do |search_term|

		url 			= "https://#{city}.craigslist.org/search/cpg?query=#{search_term}&is_paid=all"

		document 		= open(url)
		content 		= document.read
		parsed_content 	= Nokogiri::HTML(content)

		puts '================================================='
		puts '-                                               -'
		puts "	           #{city} - #{search_term}             "
		puts '-                                               -'
		puts '================================================='
		
		parsed_content.css('.content').css('.result-row').each do |row|
			title		 	= row.css('.hdrlnk').inner_text
			link			= row.css('.hdrlnk').first.attributes["href"].value
			posted_at	 	= row.css('time').first.attributes["datetime"].value
			neighb_element	= row.css('.result-meta').css('.result-hood')

			if neighb_element.any?
				neighborhood = neighb_element.inner_text.strip
			else
				neighborhood = ''
			end



			puts "#{title} #{neighborhood}"
			puts "Link: #{link}"
			puts "Posted at #{posted_at}"
			puts '---------------------------------------------'
		end


	end
end


