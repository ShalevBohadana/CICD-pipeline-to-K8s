FROM node:18-alpine         # lightweight Node image
WORKDIR /usr/src/app        # set working directory

# Install dependencies
COPY package.json ./
RUN npm install --production

# Copy source code
COPY src ./src

EXPOSE 3000                 # container port
CMD ["npm", "start"]        # start command