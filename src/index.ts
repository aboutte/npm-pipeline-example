import * as express from 'express';

export const app = express();
const port = process.env.PORT || 3000;

app.get('/', (req, res) => {
  res.send('Hello, world! this is a demo, I made a new commit, changed the docker deployment to new commit without first triggers container build');
});

export const server = app.listen(port, () => {
  console.log(`Server running at http://localhost:${port}`);
});
