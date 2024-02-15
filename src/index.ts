import * as express from 'express';

export const app = express();
const port = process.env.PORT || 3000;

const db_url = process.env.DB_URL
const db_password = process.env.DB_PASSWORD

app.get('/', (req, res) => {
  res.send('Hello, world!');
  res.send(`DB URL: ${db_url}`);
  res.send(`DB password: ${db_password}`);
});

export const server = app.listen(port, () => {
  console.log(`Server running at http://localhost:${port}`);
});
