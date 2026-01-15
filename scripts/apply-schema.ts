import fs from 'fs';
import path from 'path';
import dotenv from 'dotenv';
import pg from 'pg';
import { fileURLToPath } from 'url';

dotenv.config();

const { Pool } = pg;

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

async function applySchema() {
  const connectionString = process.env.DATABASE_URL;

  if (!connectionString || connectionString.includes('your_supabase_url')) {
    console.error('❌ DATABASE_URL is not set or is still the default value in .env');
    console.log('👉 Please set DATABASE_URL in your .env file to your Supabase connection string.');
    process.exit(1);
  }

  const schemaPath = path.join(__dirname, '../supabase-schema.sql');

  if (!fs.existsSync(schemaPath)) {
    console.error(`❌ Schema file not found at ${schemaPath}`);
    process.exit(1);
  }

  const sql = fs.readFileSync(schemaPath, 'utf8');

  console.log('🔌 Connecting to database...');
  const pool = new Pool({ connectionString });

  try {
    const client = await pool.connect();
    console.log('📝 Applying schema...');

    // Begin transaction
    await client.query('BEGIN');

    try {
        await client.query(sql);
        await client.query('COMMIT');
        console.log('✅ Schema applied successfully!');
    } catch (e) {
        await client.query('ROLLBACK');
        throw e;
    }

    client.release();
    await pool.end();
    process.exit(0);
  } catch (err: any) {
    console.error('❌ Failed to apply schema:', err.message);
    process.exit(1);
  }
}

applySchema();
