-- Writeback: human-in-the-loop feature decisions with approval flow
-- Closed loop: approved decisions reflected on next read (segment exits open_sliding)

CREATE TABLE IF NOT EXISTS app.feature_decisions_app (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    segment_id TEXT NOT NULL,
    action_type TEXT NOT NULL,
    target_experiment_id TEXT,
    flag_key TEXT,
    variant TEXT,
    rollout_pct INTEGER,
    drafted_note TEXT,
    predicted_conversion_lift DOUBLE PRECISION,
    status TEXT DEFAULT 'proposed',  -- proposed, approved, rejected
    approved_by TEXT,
    audit_trail JSONB DEFAULT '[]',
    created_at TIMESTAMPTZ DEFAULT now(),
    decided_at TIMESTAMPTZ
);

-- Index for efficient lookup by segment and status
CREATE INDEX idx_decisions_segment ON app.feature_decisions_app(segment_id);
CREATE INDEX idx_decisions_status ON app.feature_decisions_app(status);
