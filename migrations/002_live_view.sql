-- Live view: sliding segments ranked by conversion at risk
-- Trigger: scheduled scoring pipeline updates slide_signal_score;
--          view auto-refreshes on app load (system-triggered > user-triggered)

CREATE OR REPLACE VIEW app.v_sliding_ranked AS
SELECT
    segment_id,
    cohort,
    platform,
    mau,
    conversion_rate,
    conversion_drop,
    conversion_at_risk_usd,
    has_matching_experiment,
    matching_experiment_id,
    matching_experiment_lift,
    neighbor_flag_key
FROM app.open_sliding
ORDER BY conversion_at_risk_usd DESC;
