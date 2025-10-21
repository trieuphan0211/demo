import { Router } from "express";
const router = Router();

router.get("/health", (_req, res) => res.json({ status: "ok" }));
router.get("/hello", (_req, res) => res.json({ message: "Hi from API" }));

export default router;
