import os
from dotenv import load_dotenv

load_dotenv()

WEB_URL=os.getenv('WEB_URL')
BROWSER=os.getenv('BROWSER')
HEADLESS=os.getenv('HEADLESS')