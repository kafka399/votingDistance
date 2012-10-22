# Define here the models for your scraped items
#
# See documentation in:
# http://doc.scrapy.org/topics/items.html

from scrapy.item import Item, Field

class GetdataItem(Item):
    # define the fields for your item here like:
    partija = Field()
    balsas = Field()
    seimunas = Field()
    url_id = Field()
    pavarde = Field()
    pass
