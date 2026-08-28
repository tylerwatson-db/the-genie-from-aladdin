-- Synced UC tables (read-only in Postgres, managed by Lakehouse Sync)
-- Source: solution_builder.nimbus

CREATE TABLE IF NOT EXISTS app.segment_position (
    id TEXT PRIMARY KEY,
    segment_id TEXT NOT NULL,
    cohort TEXT,
    platform TEXT,
    region TEXT,
    mau INTEGER,
    segment_summary TEXT,  -- searchable text field
    conversion_rate DOUBLE PRECISION,
    conversion_rate_3w_ago DOUBLE PRECISION,
    conversion_drop DOUBLE PRECISION,
    sessions INTEGER,
    slide_signal_score DOUBLE PRECISION,
    conversion_at_risk_usd DOUBLE PRECISION,
    conv_band TEXT
);

CREATE TABLE IF NOT EXISTS app.experiments (
    id TEXT PRIMARY KEY,
    experiment_id TEXT NOT NULL,
    experiment_name TEXT,
    variant TEXT,
    feature_area TEXT,
    tested_cohort TEXT,
    tested_platform TEXT,
    won BOOLEAN,
    observed_lift DOUBLE PRECISION,
    description TEXT,  -- searchable text field
    is_active BOOLEAN
);

CREATE TABLE IF NOT EXISTS app.open_sliding (
    id TEXT PRIMARY KEY,
    segment_id TEXT NOT NULL,
    cohort TEXT,
    platform TEXT,
    mau INTEGER,
    conversion_rate DOUBLE PRECISION,
    conversion_drop DOUBLE PRECISION,
    conversion_at_risk_usd DOUBLE PRECISION,
    has_matching_experiment BOOLEAN,
    matching_experiment_id TEXT,
    matching_experiment_lift DOUBLE PRECISION,
    neighbor_flag_key TEXT
);

CREATE TABLE IF NOT EXISTS app.action_recommendations (
    id TEXT PRIMARY KEY,
    segment_id TEXT NOT NULL,
    recommended_action TEXT,
    predicted_conversion_lift DOUBLE PRECISION,
    predicted_net_value_usd DOUBLE PRECISION,
    action_ranking JSONB,
    scored_at TIMESTAMPTZ
);
