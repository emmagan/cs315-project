import scrapy
#from first_scrapy.items import Product
from scrapy.spiders import CrawlSpider, Rule
from scrapy.linkextractors import LinkExtractor
from scrapy.shell import inspect_response
import re
import json

class ProductsSpider(scrapy.Spider):
    name = "products"
    allowed_domains = ['moonboard.com']
    start_urls = ['https://www.moonboard.com/Problems/']
    rules = (
        Rule(LinkExtractor(allow=('View', )), callback='parse'),
    )


    def parse(self, response):
        data = response.xpath("//script[contains(., 'var problem')]").extract()[0]
        value = re.search('var problem = JSON.parse\(\'(.*?)\'\);', data).group(1)
        return json.loads(value)