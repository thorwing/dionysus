class SilverHornet::WhiskyBase < Mechanize
  def entries
    get("http://whiskybase.com")
    #urls = agent.page.search(".menuLits .menuLits .menuLits a").map { |link| link.attributes["href"].text }
    urls = ["http://whiskybase.com/distillery.php?merkid=29"]
  end

  def visit(entry_url)
    get entry_url

    page.search(".list_name a").each do |link|
      begin
        transact do
          click link
          process
        end
      rescue => e
        $stderr.puts "#{e.class}: #{e.message}"
      end
    end
  end

  def process
    begin
      name = page.at("#whiskyview_whiskyname").try(:text).try(:strip)
      whisky = Whisky.find_or_create_by_name(name) do |w|
        picture_url = page.at("#whiskyview_left img").attributes["src"].try(:text)
        w.pic_url = picture_url unless picture_url == "http://www.whiskybase.com/images/whiskies/00.png"
        brand_name = page.at("#whiskyview_whiskyname a").try(:text).try(:strip)
        brand = Brand.find_or_create_by_name(brand_name)
        w.brand = brand

        page.search("table.whiskydetails tr").each do |row|
          case row.at("td.whiskydetaillinks").try(:text).try(:strip)
            when "Category"
              w.style = row.at("td.whiskydetailrechts").text.delete("from").strip
            when "District"
              region_name = row.at("td.whiskydetailrechts").text
              region = Region.find_or_create_by_name(region_name)
              w.region = region
            when "Bottler"
              w.bottler = row.at("td.whiskydetailrechts").text
            when "Strength"
              w.alcohol = row.at("td.whiskydetailrechts").text #.match(/\d*.*\d/, '')[0]
            when "Bottle size"
              w.volume = row.at("td.whiskydetailrechts").text #.gsub(/[ml]/, '').strip
            when "Vintage"
              w.vintage = row.at("td.whiskydetailrechts").text
            when "Age"
              w.age = row.at("td.whiskydetailrechts").text
            when "Cask type"
              w.barrel_cask = row.at("td.whiskydetailrechts").text
              #distillation_method
          end
        end
      end
    rescue Exception => exc
      p name
      p exc.message
      p exc.backtrace
    end
  end
end
