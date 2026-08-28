-- Assistant layer: conversations + messages
-- Tools: find_sliding_segment, rank_actions, ask_data (Lakebase Search)

CREATE TABLE IF NOT EXISTS app.conversations (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    user_email TEXT NOT NULL,
    title TEXT,
    kind TEXT DEFAULT 'default',
    created_at TIMESTAMPTZ DEFAULT now(),
    updated_at TIMESTAMPTZ DEFAULT now()
);

CREATE TABLE IF NOT EXISTS app.messages (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    conversation_id UUID REFERENCES app.conversations(id),
    role TEXT NOT NULL,  -- 'user' or 'assistant'
    content TEXT,
    position INTEGER,
    trace_id TEXT,
    thinking JSONB DEFAULT '[]',
    error TEXT,
    canceled BOOLEAN DEFAULT false,
    created_at TIMESTAMPTZ DEFAULT now()
);

CREATE TABLE IF NOT EXISTS app.feedback (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    message_id UUID REFERENCES app.messages(id),
    user_email TEXT,
    value TEXT,
    rationale TEXT,
    trace_id TEXT,
    mlflow_assessment_id TEXT,
    created_at TIMESTAMPTZ DEFAULT now()
);
