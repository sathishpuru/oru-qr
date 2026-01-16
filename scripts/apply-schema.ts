import { Client } from 'pg';
import dotenv from 'dotenv';
import fs from 'fs';
import path from 'path';

dotenv.config({ path: path.resolve(process.cwd(), '.env') });

const client = new Client({
  connectionString: process.env.DATABASE_URL,
});

async function applySchema() {
  if (!process.env.DATABASE_URL || process.env.DATABASE_URL.includes('your_')) {
    console.error('❌ DATABASE_URL is not defined or is a placeholder in .env');
    console.log('ℹ️  Please update .env with your Supabase connection string.');
    process.exit(1);
  }

  try {
    console.log('🔌 Connecting to database...');
    await client.connect();

    const schemaPath = path.resolve(process.cwd(), 'supabase-schema.sql');
    if (!fs.existsSync(schemaPath)) {
        console.error(`❌ Schema file not found at ${schemaPath}`);
        process.exit(1);
    }

    const schemaSql = fs.readFileSync(schemaPath, 'utf8');

    console.log('🚀 Applying schema...');
    await client.query(schemaSql);

    console.log('✅ Schema applied successfully!');
    await client.end();
  } catch (err) {
    console.error('❌ Failed to apply schema:', err);
    process.exit(1);
  }
}

applySchema();
