import * as express from 'express';
const fs = require('fs');

export const app = express();
const port = process.env.PORT || 3000;

const db_url = process.env.DB_URL
const db_username = process.env.DB_USERNAME
const db_password = process.env.DB_PASSWORD

var fileContents = ''

fs.readFile('/data/foo', 'utf8', (err, data) => {
  if (err) {
    console.error('Error reading file:', err);
    return;
  }
  fileContents = data;
});

app.get('/', (req, res) => {
  // res.send(contents);
  res.writeHead(200, {'Content-Type': 'text/html'}); // Set the Content-Type to HTML
  const multiLineString = `
    <html>
      <head>
        <title>Multi-line String Example</title>
      </head>
      <body>
        <h1>Hello, World!</h1>
        <p></p>
        <p>Here are examples of reading environment variables that came from k8s secrets:</p>
        <p>DB URL: ${db_url}</p>
        <p>DB username: ${db_username}</p>
        <p>DB password: ${db_password}</p>

        <p></p>
        <p>Here are examples of reading from a config map:</p>
        <p>/data/foo: ${fileContents}</p>
      </body>
    </html>
  `;

  res.end(multiLineString);
});

export const server = app.listen(port, () => {
  console.log(`Server running at http://localhost:${port}`);
});

