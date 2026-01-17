import 'dotenv/config';
import pkg from 'pg';

const { Client } = pkg;

async function testConnection() {
  const connectionString = process.env.DATABASE_URL;

  if (!connectionString) {
    console.error('DATABASE_URL is not set in .env file');
    process.exit(1);
  }

  const client = new Client({
    connectionString,
    ssl: {
      rejectUnauthorized: false,
    },
  });

  try {
    await client.connect();
    console.log('Successfully connected to the database!');

    const res = await client.query('SELECT NOW()');
    console.log('Current database time:', res.rows[0].now);

  } catch (err) {
    console.error('Connection error:', err);
    process.exit(1);
  } finally {
    await client.end();
  }
}

testConnection();
