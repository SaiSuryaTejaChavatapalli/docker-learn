const express = require("express");

const app = express();

const PORT = 8000;

app.get("/", (req, res) => {
  return res.json({ status: "Success", message: "Hello SST" });
});

app.listen(PORT, () => {
  console.log("App started on PORT", PORT);
});
