import * as express from 'express';

export const app = express();
const port = process.env.PORT || 3000;

const db_url = process.env.DB_URL
const db_username = process.env.DB_USERNAME
const db_password = process.env.DB_PASSWORD

const contents = `
DB URL: ${db_url}
DB username: ${db_username}
DB password: ${db_password}
`;

app.get('/', (req, res) => {
  res.send(contents);
});

export const server = app.listen(port, () => {
  console.log(`Server running at http://localhost:${port}`);
});
