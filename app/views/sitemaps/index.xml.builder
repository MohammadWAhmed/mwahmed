base_url = "http://#{request.host_with_port}"
xml.instruct! :xml, :version=>'1.0'
xml.tag! 'urlset', 'xmlns' => 'http://www.sitemaps.org/schemas/sitemap/0.9' do
  xml.url{
      xml.loc("http://mwahmed.com")
      xml.changefreq("daily")
      xml.priority(1.0)
  }
  xml.url{
      xml.loc("http://mwahmed.com/photography")
      xml.changefreq("daily")
      xml.priority(0.9)
  }
  xml.url{
      xml.loc("http://mwahmed.com/map")
      xml.changefreq("daily")
      xml.priority(0.9)
  }
  xml.url{
      xml.loc("http://mwahmed.com/contact")
      xml.changefreq("daily")
      xml.priority(0.9)
  }
end