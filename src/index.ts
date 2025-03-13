// app1-service-a
import express, { Request, Response } from 'express';
import axios from 'axios';
import { instrumentWithAxon } from 'cortex-axon-js';

const app = express();

app.use(instrumentWithAxon("app1"));

axios.defaults.proxy = {
  host: 'envoy',
  port: 8080
};

app.get('/getresult', async (req: Request, res: Response) => {
  try {
    const response = await axios.get(`http://localhost/app1/service-b/getresult/`);
    return res.status(response.status).json(["A=35", ...response.data]);
  } catch (err: any) {
    console.error("Error calling /b/getresult:", err.message);
    return res.status(500).json({ error: "Something went wrong" });
  }
});

app.listen(80, () => {
  console.log('service-a listening on port 80');
});
