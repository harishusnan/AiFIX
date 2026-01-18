# Supabase Schema

This folder contains the PostgreSQL schema used by AiFIX.

## Tables
- `documents` – stores uploaded reference materials
- `document_embeddings` – stores vector embeddings for RAG (pgvector)
- `agent_memory` – stores AI agent memory accessed via n8n Postgres node

## Notes
- Supabase PostgreSQL is used for both application data and AI agent memory
- Vector search is implemented using pgvector

(Please take note to update your table names accordingly, if you are using different table names)
