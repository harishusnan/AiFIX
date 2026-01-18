-- Enable pgvector extension
create extension if not exists vector;

-- Table for uploaded reference documents
create table if not exists documents (
  id uuid primary key default gen_random_uuid(),
  file_name text,
  content text,
  created_at timestamp default now()
);

-- Table for vector embeddings (Knowledge Base)
create table if not exists document_embeddings (
  id uuid primary key default gen_random_uuid(),
  document_id uuid references documents(id) on delete cascade,
  chunk_text text,
  embedding vector(1536),
  created_at timestamp default now()
);

-- Table for AI agent memory / workflow state
create table if not exists agent_memory (
  id uuid primary key default gen_random_uuid(),
  session_id text,
  role text,
  message text,
  created_at timestamp default now()
);
