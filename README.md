# Intial Setup

    docker-compose build
    docker-compose up mariadb
    # Once mariadb says it's ready for connections, you can use ctrl + c to stop it
    docker-compose run short-app rails db:migrate
    docker-compose -f docker-compose-test.yml build

# To run migrations

    docker-compose run short-app rails db:migrate
    docker-compose -f docker-compose-test.yml run short-app-rspec rails db:test:prepare

# To run the specs

    docker-compose -f docker-compose-test.yml run short-app-rspec

# Run the web server

    docker-compose up

# Adding a URL

    curl -X POST -d "full_url=https://google.com" http://localhost:3000/

# Getting the top 100

    curl localhost:3000

# Checking your short URL redirect

    curl -I localhost:3000/abc

# Solution for generating the Short Code

    Generating short code to represent URL is the basis of lots of web pages nowdays. A great example is Youtube, where they generate an 11 character code with Base64 for each video that is uploaded to there database.

    This allows them to have little to no chance of running out of unique IDS. In my case, I'm using a Base62 and could easily just add another another character to expand my chances.

    I decided to make every code 3 characters long, so I can have 238,328 unique IDS. Which, given the nature of the application, is more than enough. And in the case that an expansion is needed, you would just have to increase  the lenght by one and gain 14,538,008 more unique IDS.

    Another solution could have been taking in account the amount of rows register in the database, so I could start with one character and increase the lenght if I'm geting close to running out of IDS. But, in my opinion, fixing the lenght to 3 does the job. 