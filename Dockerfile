FROM rocker/tidyverse
MAINTAINER Julia Ha <julia.ha@nyu.edu>

RUN apt-get update -qq && apt-get install -y \ 
    git-core \ 
    libssl-dev \ 
    libcurl4-gnutls-dev \
    python \
    python-pip

COPY ./api/ /usr/local/src/r-api
WORKDIR /usr/local/src/r-api

RUN chmod 700 start.sh

# Install R packages / setup R api.
RUN R -e "install.packages('plumber')"
RUN R -e "install.packages('jsonlite')"
RUN R -e "install.packages('devtools')"
RUN R -e "install.packages('mousetrap')"

# Port 8000 for local usage, not used on Heroku.
EXPOSE 8000

ENTRYPOINT ["/usr/local/src/r-api/start.sh"]
CMD ["routes.R"]