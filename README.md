# R API

This is a simple API built using the library [plumber.R](https://www.rplumber.io/) that allows R code to be executed when http requests are made to the endpoints defined in routes.R.

## Getting Started

### Using the API

To use the API, simply call the API endpoints using the appropriate HTTP method. The API is hosted on ```https://freeman-lab-node-api.herokuapp.com/api```. For example, to reach the ```/test``` endpoint, access ```https://freeman-lab-node-api.herokuapp.com/api/test``` and you should receive a response of "hello world".

### Developing and Testing the API

To run this API locally for testing and development purposes, make a copy of this repository onto your local machine and initialize a local git repository. Please note that if you are making changes to the code and want to push changes, you may needed to be added to the repository as a contributor via GitHub. To run locally, you can run the start.sh file to get the server up.

## How to Build and Deploy

This code is built and deployed by Heroku using a Docker container - if you haven't already, download and install the [Heroku CLI](https://devcenter.heroku.com/articles/heroku-cli)

First, login to the freeman-lab-nyu Heroku account by using the Heroku CLI. In the CL of the project root, type the following and enter the credentials when prompted:
```
heroku login
```

To build, you need to push the Docker container:
```
heroku container:push web -a freeman-lab-r-api
```

Finally, release the container to deploy:
```
heroku container:release web --app freeman-lab-r-api
```

Find more on Docker Containers in Heroku [here](https://devcenter.heroku.com/articles/container-registry-and-runtime).

## API Endpoints

```
/maxdev
```
A POST endpoint that requires the path to a .mt file as a parameter and returns MAD (maximum deviation), AUC (area under curve), and RT (response time) for the mt data. Uses mousetrap.R library for data processing, see [here](https://pascalkieslich.github.io/mousetrap/reference/index.html) for further reference.

## Built with:
* [plumber.R](https://www.rplumber.io/) - R package that converts your existing R code to a web API
* [mousetrap.R](https://github.com/PascalKieslich/mousetrap) - R library for importing, preprocessing, analyzing, aggregating, and visualizing mouse-tracking data
* [Heroku](https://devcenter.heroku.com/) - service that builds, runs, operates applications in the cloud
* [Docker](https://docs.docker.com/)
