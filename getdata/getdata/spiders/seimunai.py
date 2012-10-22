from scrapy.spider import BaseSpider
from getdata.items import GetdataItem
from scrapy.selector import HtmlXPathSelector

class DmozSpider(BaseSpider):
    name = "lrs"
    allowed_domains = ["lrs.lt"]
    start_urls = [
        "http://www3.lrs.lt/pls/inter/w5_sale.bals?p_bals_id=-%s" % page for page in xrange(3030,14588)
    ]

    def parse(self, response):
	hxs = HtmlXPathSelector(response)
	
#	tbl = hxs.select('//table[@class="basic"]')[0]
	tbl = hxs.select('//table[@class="basic"]')[0]
	items = []
#	tmp = tbl.select('tr/td/a/@href').extract()
	tmp = tbl.select('tr')
        for t in tmp:
                item = GetdataItem()
		item['url_id'] = response.url.split('=-')[1]
		if(len(t.select('td'))>0):
			id = t.select('td')[0].select('a/@href').extract()[0]
        	        id = id.split('=')
			id = id[len(id)-1].split('.')[0]
	                item['seimunas'] = id#[len(t)-1]

			item['partija']=t.select('td/text()')[2].extract().encode('utf8')			
			if(t.select('td/text()')[3].extract().find('+')>0):
				item['balsas']=1
			elif(t.select('td/text()')[4].extract().find('+')>0):
				item['balsas']=-1
			else:
				item['balsas']=0

#               item['seimunas'] = t#.encode("windows-1257")

#               print(item['seimunas'])
        	        items.append(item)
        return items
	
