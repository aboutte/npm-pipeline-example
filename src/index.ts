import * as express from 'express';
const fs = require('fs');

export const app = express();
const port = process.env.PORT || 3000;

var fileContents = ''

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
        
      </body>
    </html>
  `;

  res.end(multiLineString);
});

export const server = app.listen(port, () => {
  console.log(`Server running at http://localhost:${port}`);
});

