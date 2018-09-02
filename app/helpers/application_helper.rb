module ApplicationHelper

require "uri"

def text_url_to_link text

  URI.extract(text, ['http', 'https']).uniq.each do |url|
    sub_text = ""
    sub_text << "<a href=" << url << " target=\"_blank\" class=\"post-link\">" << url << "</a>"
    text.gsub!(url, sub_text)
  end

  return text
end

end
