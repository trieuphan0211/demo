import express from "express";
import path from "path";
import { fileURLToPath } from "url";
import api from "./routes/api.js";

const app = express();
app.use(express.json());

// API
app.use("/api", api);

// Phục vụ React build cho production
const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);
const buildPath = path.join(__dirname, "../client/dist"); // Vite: dist ; CRA: build

app.use(express.static(buildPath));
app.get(/^\/(?!api).*/, (_req, res) => {
  res.sendFile(path.join(buildPath, "index.html"));
});

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => console.log(`Server running on ${PORT}`));
