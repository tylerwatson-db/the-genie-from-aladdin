-- Observability: workflow state captures trigger events and recorded decisions

CREATE TABLE IF NOT EXISTS app.workflow_state (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    event_type TEXT NOT NULL,  -- slide_detected, assist_triggered, action_ranked, decision_proposed, decision_approved
    segment_id TEXT,
    trigger_source TEXT,       -- scheduled_scoring, user_inquiry, model_scoring, assistant, human_approval
    payload JSONB,
    decision_id UUID,
    created_at TIMESTAMPTZ DEFAULT now()
);

CREATE INDEX idx_workflow_segment ON app.workflow_state(segment_id);
CREATE INDEX idx_workflow_event ON app.workflow_state(event_type);
