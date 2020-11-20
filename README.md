# Climbing database

The [moonboard](https://www.moonboard.com) is a climbing training tool.  We aim to replicate the moonboard database but add more tables and a more robust user interface.

## Tasks and layout of the code
- We used this [scraper notebook](https://nbviewer.jupyter.org/github/luke321321/portfolio/blob/master/climbing/Scraper.ipynb) to get raw data from the moonboard website.  The data found in the /data folder was from 2 years ago, so now there are over double the number of climbs, which is why we wanted to get a fresh scrape.
- We used this [Data-cleaning-and-analysis notebook](https://nbviewer.jupyter.org/github/luke321321/portfolio/blob/master/climbing/Data-cleaning-and-analysis.ipynb) from the same person to clean the data and analyze it.  TODO: Add database connection details in this file after separating into more tables.
- TODO: User interface / web design