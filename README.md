# AiFIX — AI Financial Expert & Wealth Management (RAG)

AiFIX is a financial insight app that combines:
- Lovable frontend (dashboard + data vault + knowledge base)
- n8n workflow automation (API/webhooks, ingestion, RAG pipeline)
- Supabase DB + Supabase Vector Store (pgvector) for retrieval
- Ollama local LLM for generation
- Docker to run n8n locally

## Features
- Upload financial data (CSV/XLSX) → stored in Supabase
- Upload reference materials (KB) → chunk + embed → stored in Supabase Vector Store
- Ask questions in the app → n8n runs RAG → Ollama generates answer

## Tech Stack
- Frontend: Lovable (exported React app)
- Orchestration: n8n (Docker, localhost)
- Database & Vector Store: Supabase (PostgreSQL + pgvector)
- Workflow Data & AI Agent Memory: PostgreSQL (accessed via n8n Postgres node, using Supabase Postgres)
- LLM runtime: Ollama (local Mac terminal)


## Repo Structure
- `/n8n-workflows` — exported n8n workflows (JSON)
- `/supabase` — PostgreSQL schema and vector store definition
- `/sample-data` — synthetic sample data for testing
- `/docs/screenshots` — application and workflow screenshots


## Prerequisites
- Lovable account
- n8n account
- Docker Desktop
- Supabase account
- Ollama installed locally

## 1) Supabase Setup (DB + Vector Store)

1. Create a new Supabase project
2. Open SQL Editor and run:
   - `supabase/schema.sql`
3. Ensure pgvector is enabled (Supabase supports this by default)

## 2) Ollama Setup (Local LLM)

1. Install Ollama model from https://ollama.com
2. Open your Terminal (if you are using Macbook). For Windows user, kindly refer to other references on google
3. Run
   ```bash
   ollama run llama3.1:latest
   ```
5. You may replace 'llama3.1:latest' with your preferred model

## 3) Run n8n (Docker – docker run)

n8n is started using a direct Docker command (no docker-compose).

1. Create a Docker volume for n8n persistence:
```bash
docker volume create n8n_data

2. Run n8n:
docker run -it --rm \
  --name n8n \
  -p 5678:5678 \
  -e GENERIC_TIMEZONE="<YOUR_TIMEZONE>" \
  -e TZ="<YOUR_TIMEZONE>" \
  -e N8N_ENFORCE_SETTINGS_FILE_PERMISSIONS=true \
  -e N8N_RUNNERS_ENABLED=true \
  -v n8n_data:/home/node/.n8n \
  docker.n8n.io/n8nio/n8n


3. Open n8n:
http://localhost:5678

4. Import workflows:
n8n UI → Import → select files from n8n/workflows/
```
## 4) Run Lovable

1. Open your browser (Google Chrome, Safari, Microsoft Edge)
2. Go to https://lovable.dev/
3. Sign in to your lovable account. You need to sign up first if you don't have a lovable account
4. Run your query and start designing


## 5) Quick Test (Sample Data)

- Upload your financial data in Data Vault
- Upload a reference document in Knowledge Base
- Ask a financial question in Analytics / Wealth Goals

Expected:

- Data appears correctly
- AI returns a friendly answer (not raw JSON)


Environment Variables:

Create .env based on .env.example.


Required variables:

1. Supabase URL
2. Supabase keys
3. n8n webhook URLs
4. Ollama base URL

Troubleshooting:

1. Ensure n8n is running on port 5678 (or on the right port)
2. Ensure each of n8n node setup is align with your expected output
3. Ensure Ollama is running on port 11434 (or on the right port)
4. Ensure Supabase tables match workflow inserts
5. Ensure all the connections of the tools are successfully in n8n

## Frontend (Not Included)

The Lovable frontend used in the original AiFIX prototype is not included in this public repository.

This repository focuses on the core AiFIX functions (RAG pipeline, workflows, database schema, and local LLM).  
You can build your own UI (Lovable, React, Vue, etc.) as long as it calls the provided n8n webhook endpoints with the same payload structure.

