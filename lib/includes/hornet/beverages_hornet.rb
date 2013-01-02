#coding: utf-8

class Hornet::BeveragesHornet

  def config
    @config ||= lambda do
      filename = "#{Rails.root}/config/hornet/.yml"
      file = File.open(filename)
      yaml = YAML.load(file)
      return yaml
    end.call
    @config
  end

  def fetch
    agent = Mechanize.new
    agent.get("http://www.masterofmalt.com/country-style/scotch/blended-malt-whisky")
    agent.page.search(".ctrl_PBW_Mid_Title a").each do |link|
      begin
        agent.click(link)
        name = agent.page.at("#ctl00_ContentPlaceHolder1_pageH1").text.strip
        whisky = Whisky.find_by_en_name(name)
        if whisky.blank?
          whisky = Whisky.create! do |w|
            w.en_name = name
            #w.region = Region.find_by_en_name(agent.page.at("#ctl00_ContentPlaceHolder1_ctl01_ctl01_wdRegion a").text.strip)
            w.pic_url = agent.page.at("#ctl00_ContentPlaceHolder1_ctl01_imgProductBig").attributes["src"].text
            brand_name = agent.page.at("#ctl00_ContentPlaceHolder1_ctl01_ctl01_wdBottler span:nth-child(2)").text.strip
            brand = Brand.find_or_initialize_by_en_name(brand_name)
            brand.save! if brand.new_record?
            w.brand = brand
            vol_and_alc_string = agent.page.at("#ctl00_ContentPlaceHolder1_pageH1ClAbv").text.strip
            w.volume = vol_and_alc_string.split(',')[0].gsub("^[0-9]", '')
            w.alcohol = vol_and_alc_string.split(',')[1].gsub("^[0-9]", '')
          end
        end

        Product.create! do |p|
          p.title = name
          p.description = agent.page.at("#productDesc span").text.strip
          p.price = agent.page.at("#ctl00_ContentPlaceHolder1_ctl01_buyBlock span").text.strip
          p.source = "masterofmalt"
          p.source_url = agent.page.uri
          p.beverage_id = whisky.id
        end
      rescue Exception => exc
        p name
        p exc.message
        p exc.backtrace
      end
    end
  end
end