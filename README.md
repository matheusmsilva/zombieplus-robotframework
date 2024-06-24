![poster](https://raw.githubusercontent.com/qaxperience/thumbnails/main/playwright-zombie.png)

## 🤘 About

Repository for the automated testing project of the Zombie Plus system! 

## 💻 Technologies
- Python 
- Faker
- PostgreSQL
- Browser
- Database Library
- Requests
- Github Actions

## 💻 Prerequisites
These technologies are needed to be able to build the project correctly 
- Python
- Node.js

## 🤖 How to run

1. Clone the repository and install dependencies for application on folder **application/web** and **application/api**
```
npm install
```

2. Start the application locally. It is necessary to run this for Backend and Frontend Layer
```
npm run dev
```

3. Install Python dependencies
```
pip install -r requirements.txt
```

4. Run tests
```
robot -d ./logs tests
```

## Project architecture

This project uses Page Object Model Design pattern, which involves creating resources based on your application's pages. Each class is responsible for all methods and elements related to its page.
It is implemented to run on Github Actions by triggering manually.
