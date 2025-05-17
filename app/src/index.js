const express = require('express');
const app = express();
const port = process.env.PORT || 3000;

// Define a single route
app.get('/', (req, res) => {
  res.send('Hello, CI/CD to Kubernetes!');
});

// Start the server
app.listen(port, () => {
  console.log(`App listening on port ${port}`);
});
