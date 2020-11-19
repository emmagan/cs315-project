import scrapy
from first_scrapy.items import Product
from scrapy.shell import inspect_response

class ProductsSpider(scrapy.Spider):
    name = "products"

    start_urls = [
            'https://www.blackdiamondequipment.com/en_US/climbing-shoes/momentum-velcro-mens-BD570101_cfg.html#start=1'
        ]


    def parse(self, response):
        item = Product()
        item['product_url'] = response.xpath("//meta[@property='og:url']/@content").extract()[0].strip()
        item['price'] = response.xpath("//meta[@property='og:title']/@content").extract()[0].strip()
        item['title'] = response.xpath("//meta[@property='og:price:amount']/@content").extract()[0].strip()
        item['img_url'] = response.xpath("//meta[@property='og:image']/@content").extract()[0].strip()
        item['desc'] = response.xpath("//meta[@property='og:description']/@content").extract()[0].strip()
        return item
