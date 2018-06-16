# codius-hello-world

This is an example app that executes on the [Codius](https://codius.org/) platform.

The app is a sample node.js application, which will launch a web server, displaying a simple hello world page.

Scripts are provided to:

- Build the app into a docker image
- Upload the docker image to Docker Hub
- Create a Codius manifest file
- Run the manifest file against a Codius server

## Requirements

Do not install these items on the Codius server. Do it on another machine.

- node.js version 8 or 10.
- [Docker](https://www.docker.com/get-docker) installed locally. The latest CE version is fine.
- A [docker hub](https://hub.docker.com/) account

## Installation

### Install codius globally

`npm i codius -g`

### Install the package modules

`npm i`

## Commands

Run with `npm run <command>`.

Where `<command>` is one of the following:

- `docker:build` - Builds the app into a docker image
- `docker:publish` - Uploads the docker image to Docker Hub and generates a `codius-manifest.json` file, using the
`codius-manifest-template.json` as a template
- `codius:upload` - Uploads the `codius-manifest.json` file to a specified host, eg `https://codius.theogravity.com`

## Sample run

- For the build/publish steps, I ran them locally on my machine (eg NOT on the Codius server directly).
- For the upload step, I copied the manifest over to the Codius server and executed the upload command there
(I did not have the proper setup on my local machine to do it).

```bash
$ npm i
npm WARN codius-hello-world@1.0.0 No repository field.

added 50 packages from 47 contributors and audited 119 packages in 1.457s
found 0 vulnerabilities

# Build the image
$ npm run docker:build

> codius-hello-world@1.0.0 docker:build /Users/theo/projects/codius-hello-world
> scripts/build.sh

Your docker hub username: *****
Sending build context to Docker daemon  2.143MB
Step 1/7 : FROM node:8
8: Pulling from library/node
3d77ce4481b1: Pull complete 
7d2f32934963: Pull complete 
0c5cf711b890: Pull complete 
9593dc852d6b: Pull complete 
4b16c2786be5: Pull complete 
5fcdaabfa451: Pull complete 
5c8b2b2e4dd1: Pull complete 
bf1ffaa6c385: Pull complete 
Digest: sha256:37c74cbf7e5e7f4d5393c76fdf33d825ac4b978b566a401eb3709a2f8be75b6f
Status: Downloaded newer image for node:8
 ---> f46f0c9a300b
Step 2/7 : WORKDIR /app
Removing intermediate container 307c69323a26
 ---> f8f7e13be605
Step 3/7 : COPY package*.json ./
 ---> 15bd91d4f2be
Step 4/7 : COPY ./src/index.js ./src/index.js
 ---> cd00a9f42e97
Step 5/7 : RUN npm install --only=production
 ---> Running in f3d3be2555da
npm WARN codius-hello-world@1.0.0 No repository field.

added 50 packages in 1.276s
Removing intermediate container f3d3be2555da
 ---> 22ad47a4eb1a
Step 6/7 : EXPOSE 3000
 ---> Running in 1b6a4caa71bd
Removing intermediate container 1b6a4caa71bd
 ---> 055e7d5fff5a
Step 7/7 : CMD [ "npm", "start" ]
 ---> Running in 067d2d65daa0
Removing intermediate container 067d2d65daa0
 ---> 0e89db193e73
Successfully built 0e89db193e73
Successfully tagged *****/codius-hello-world:latest

# Publish the image and generate the codius manifest file
$ npm run docker:publish

> codius-hello-world@1.0.0 docker:publish /Users/theo/projects/codius-hello-world
> scripts/publish.sh

Your docker hub username: *****
Generating codius-manifest.json
Publishing image to docker
Executing: 'docker push *****/codius-hello-world:latest'
Stamping codius-manifest.json with the docker image hash
codius-manifest.json generated

# Run the manifest file
$ npm run codius:upload

Codius host URL: https://codius.theogravity.com

...

# It died here on my local machine because I didn't have a proper moneyd setup I think
# What I did instead was:
# - copy the contents of the codius-manifest.json file
# - logged into the Codius server as non-root
# - Installed a local copy of node.js using nvm
# - Installed a local global copy of codius, eg `npm i codius -g`
# - Created a codius-manifest.json file and copied the contents from step 1 into it and saved
# - Ran DEBUG=* codius upload codius-manifest.json --host ${CODIUS_HOST} --duration 200
# - Replace ${CODIUS_HOST} with the target host, eg https://codius.theogravity.com
# - For some reason, it always takes two attempts to work
```

If you succeed, you'll get something like:

```
Successfully Uploaded Pods to:
[ { url:
     'https://2owdxaa6b7liz4o25w7a752belrma7hqug24rgdxekp7ea2tvh2a.codius.theogravity.com/',
    manifestHash: '2owdxaa6b7liz4o25w7a752belrma7hqug24rgdxekp7ea2tvh2a',
    host: 'https://codius.theogravity.com',
    expiry: '2018-06-16T09:46:05.832Z',
    expirationDate: '06-16-2018 5:46:05 -0400',
    expires: 'in 10 minutes',
    pricePaid: '2282' } ]
  codius-cli:uploadHandler Saving successful uploaded pods to CliDB +3s
  codius-cli:cli-db Value not found for key: 2owdxaa6b7liz4o25w7a752belrma7hqug24rgdxekp7ea2tvh2a +4s
  codius-cli:uploadHandler Saving to cli-db Hosts: {
  codius-cli:uploadHandler   "https://codius.theogravity.com": {
  codius-cli:uploadHandler     "expiry": "2018-06-16T09:46:05.832Z"
  codius-cli:uploadHandler   }
  codius-cli:uploadHandler } +2ms
```

You can then paste the URL into a browser and see it run (the URL above is expired by this posting):

![codius-app](https://github.com/theogravity/codius-hello-world/blob/master/codius.png?raw=true)



