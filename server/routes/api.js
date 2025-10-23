import { Router } from "express";
const router = Router();

router.get("/health", (_req, res) => res.json({ status: "ok" }));
router.get("/hello", (_req, res) => res.json({ message: "Just Demo" }));

export default router;
