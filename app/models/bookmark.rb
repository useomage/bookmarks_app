class Bookmark < ActiveRecord::Base
  belongs_to :domain
  belongs_to :user

	acts_as_taggable

	validates :name, 	presence: true
	validates :url,		presence: true, uniqueness: true, format: URI::regexp(%w(http https))

  
  def self.text_search(query)
    if query.present?
      search(query)
    else
      scoped
    end
  end


	# Returns a domain from the URL.
	def extract_domain
		parsed_url = URI.parse(url)
		return parsed_url.host
	end

	def to_s
		name
	end

	def update_domain
		ed = extract_domain

		if (Domain.find_by(domain: ed)).nil?
			Domain.create(domain: ed)
		end
		update(domain_id: Domain.find_by(domain: ed).id)
	end

	def generate_short_url
		surl = Googl.shorten(url, "78.10.85.139", "AIzaSyA44HqWr9nSSZARxSBsMNACobm1ntnZAuY").short_url
		update(shortened_url: surl)
	end
end
