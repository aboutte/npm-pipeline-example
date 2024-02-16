import * as express from 'express';

export const app = express();
const port = process.env.PORT || 3000;

const db_url = process.env.DB_URL
const db_username = process.env.DB_USERNAME
const db_password = process.env.DB_PASSWORD

const contents = `
DB URL: ${db_url} \n
DB username: ${db_username} \n
DB password: ${db_password}
`;

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
        <p>This is a multi-line string example.</p>
        <p>This is a multi-line string example.</p>
        <p>This is a multi-line string example.</p>
      </body>
    </html>
  `;

  res.end(multiLineString);
});

export const server = app.listen(port, () => {
  console.log(`Server running at http://localhost:${port}`);
});

