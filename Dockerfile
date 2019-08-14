# This is the production-level dockerfile
# this wil be a mlti step 

# AS will tag the result of FROM to a given name that we 
# can refer to in the script

FROM node:alpine as builder 

WORKDIR '/app'
COPY package.json .
RUN npm install 
COPY . . 

RUN npm run build

# The second FROM will assume that the previous block has completed
FROM nginx 
COPY --from=builder /app/build /usr/share/nginx/html
