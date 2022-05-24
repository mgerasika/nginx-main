# Using Node:10 Image Since it contains all 
# the necessary build tools required for dependencies with native build (node-gyp, python, gcc, g++, make)
# First Stage : to install and build dependences

# FROM node:alpine as builder TODO invistigate error:0308010C:digital envelope routines::unsupported
FROM node:16.13.0 as builder

# Should comming from CI/CD
ARG REACT_APP_GIT_COMMIT_HASH
ARG REACT_APP_NEWRELIC_AGENT_ID

# Should comming from CI/CD value should be 'dev' or 'stage' or 'prod'
ARG REACT_APP_ENV 

COPY . /app/

WORKDIR /app
RUN yarn
# RUN yarn validate
# TODO Check syntax
RUN yarn run build-site-${REACT_APP_ENV}

FROM nginx:latest
ENV PORT=8080
COPY nginx.conf /etc/nginx/templates/default.conf.template
COPY cert/oddbox.crt /etc/ssl/oddbox.crt
COPY cert/oddbox.key /etc/ssl/oddbox.key
COPY --from=builder /app/build /var/www/dist
