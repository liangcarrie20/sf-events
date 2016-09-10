require 'open-uri'
require 'nokogiri'

helpers do
  def nokogiri_parse(site)
    nokogiri_doc(clean_html(html(site)))
  end

  def html(site)
    open(site, &:read)
  end

  def clean_html(html)
    clean_html = HTMLWhitespaceCleaner(html)
  end

  def nokogiri_doc(clean_html)
    Nokogiri.parse(clean_html)
  end

end


