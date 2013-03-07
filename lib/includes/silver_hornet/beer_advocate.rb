class SilverHornet::BeerAdvocate < Mechanize
  def entries
    get("http://beeradvocate.com/beer/style")
    #urls = agent.page.search(".menuLits .menuLits .menuLits a").map { |link| link.attributes["href"].text }
    urls = page.at("#baContent a").map{ |item| item.last }
    urls = [urls.first]
  end

  def visit(entry_url)
    get entry_url

    page.search("table tr").each do |row|
      begin
        transact do
          columns = row.search("td.hr_bottom_light");
          if columns && !columns.empty?
            name = columns[1].try(:text).try(:strip)
            beer = Beer.find_or_create_by_name(name)
            if beer.new_record?
              beer.alcohol = columns[3].try(:text)
            end

            link = columns[1].at("a")
            click link
            process(beer)
          end
        end
      rescue => e
        $stderr.puts "#{e.class}: #{e.message}"
      end
    end
  end

  def process(beer)
    begin
      beer.pic_url = "http://beeradvocate.com" + page.at("baContent table img").attributes["src"].try(:text)
      brand_name = page.at("h1 span").try(:text).try(:strip)
      brand = Brand.find_or_create_by_name(brand_name)
      beer.brand = brand
      beer.style = page.at("a:nth-child(15)").try(:text).try(:strip)
      beer.save
      p "saved beer #{beer.name}"
    rescue Exception => exc
      p beer.name
      p exc.message
      p exc.backtrace
    end
  end
end
