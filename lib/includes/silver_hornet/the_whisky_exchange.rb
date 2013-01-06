class SilverHornet::TheWhiskyExchange
  attr_accessor :agent

  def initialize(agent)
    self.agent = agent
  end

  def entries
    agent.get("http://www.thewhiskyexchange.com/Producers.aspx")
    urls = agent.page.search("#pcontent a").map { |link| "http://www.thewhiskyexchange.com/#{link.attributes["href"].text}" }
  end

  def visit(entry_url)
    agent.get(entry_url)
    begin
      agent.page.search("#plist .item").each do |item|
        parse(item)
      end
      next_link = agent.page.link_with(text: "Next")
      if next_link
        agent.click(next_link)
      end
    end while next_link.present?
  end

  def parse(html_block)
    begin
      name = html_block.at(".title a").try(:text).try(:strip)
      whisky = Whisky.find_or_create_by_name(name) do |w|
        w.pic_url = html_block.at("img").attributes["src"].try(:text)
        brand_name = html_block.at(".bottling").try(:text).try(:strip)
        brand = Brand.find_or_create_by_name(brand_name)
        w.brand = brand

        vol_and_alc_string = html_block.at(".size").try(:text).try(:strip)
        if vol_and_alc_string.present?
          w.volume = vol_and_alc_string.split('/')[0].try(:gsub, /[cl]/, '')
          w.alcohol = vol_and_alc_string.split('/')[1].try(:gsub, /[%]/, '')
        end
      end

      Product.create! do |p|
        p.title = name
        p.description = html_block.at(".text").try(:text)
        p.price = html_block.at("b").try(:text)
        p.source = "www.thewhiskyexchange.com"
        p.source_url = html_block.at(".title a").attributes["href"].try(:text)
        p.beverage_id = whisky.id
      end
    rescue Exception => exc
      p name
      p exc.message
      #p exc.backtrace
    end
  end
end
