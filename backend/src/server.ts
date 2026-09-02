import 'dotenv/config';
import express from 'express';
import cors from 'cors';
import { Pool } from 'pg';

const app = express();
const pool = new Pool({ connectionString: process.env.DATABASE_URL });

app.use(cors());
app.use(express.json({ limit: '2mb' }));

app.get('/api/health', async (_req, res) => {
  try {
    await pool.query('SELECT 1');
    res.json({ ok: true, service: 'Ahmed Kim Mods API' });
  } catch {
    res.status(503).json({ ok: false, error: 'Database unavailable' });
  }
});

app.get('/api/mods', async (req, res) => {
  const platform = req.query.platform as string | undefined;
  const params: string[] = [];
  let where = "WHERE status = 'approved'";
  if (platform === 'bedrock' || platform === 'java') {
    params.push(platform);
    where += ` AND platform = $${params.length}`;
  }

  const result = await pool.query(
    `SELECT id, title, slug, description, platform, category,
            minecraft_versions, cover_url, downloads, average_rating
       FROM mods ${where}
      ORDER BY created_at DESC
      LIMIT 50`,
    params
  );
  res.json(result.rows);
});

app.post('/api/reports', async (req, res) => {
  const { modId, reporterId, type, description, evidenceUrl } = req.body;
  if (!modId || !reporterId || !type || !description) {
    return res.status(400).json({ error: 'Missing required report fields' });
  }

  const result = await pool.query(
    `INSERT INTO reports (mod_id, reporter_id, type, description, evidence_url)
     VALUES ($1, $2, $3, $4, $5)
     RETURNING id, status, created_at`,
    [modId, reporterId, type, description, evidenceUrl ?? null]
  );
  res.status(201).json(result.rows[0]);
});

const port = Number(process.env.PORT ?? 3000);
app.listen(port, () => console.log(`Ahmed Kim Mods API running on :${port}`));
