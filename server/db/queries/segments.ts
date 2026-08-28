/**
 * Lakebase Search — retrieves from the same synced UC tables in Lakebase Postgres.
 *
 * The Build 1 search uses ILIKE text matching directly against the synced
 * experiment catalog and segment_summary fields in Lakebase. No separate
 * vector store — the search index IS the Lakebase table itself.
 *
 * Tables searched:
 *   - app.experiments (experiment_name, description) — synced from UC
 *   - app.segment_position (segment_summary) — synced from UC
 */

import { eq, desc, or, ilike } from 'drizzle-orm';
import type { AppDb } from '../index.js';
import {
  openSliding,
  actionRecommendations,
  experiments,
  segmentPosition,
} from '../schema.js';

/**
 * Search the experiment catalog using Lakebase text search (ILIKE).
 * Retrieves from the Build 1 synced UC table — NOT a separate store.
 *
 * This is the `search_experiments` tool the agent calls when it needs
 * to find relevant experiments for a sliding segment.
 */
export async function searchExperiments(
  db: AppDb,
  query: string,
): Promise<ExperimentResult[]> {
  const pattern = `%${query}%`;
  const rows = await db
    .select({
      experiment_id: experiments.experimentId,
      experiment_name: experiments.experimentName,
      variant: experiments.variant,
      feature_area: experiments.featureArea,
      tested_cohort: experiments.testedCohort,
      tested_platform: experiments.testedPlatform,
      won: experiments.won,
      observed_lift: experiments.observedLift,
      description: experiments.description,
    })
    .from(experiments)
    .where(
      or(
        ilike(experiments.experimentName, pattern),
        ilike(experiments.description, pattern),
      ),
    )
    .limit(10);
  return rows;
}

/**
 * Search segment summaries using Lakebase text search.
 * The segment_summary field is a synced TEXT column from the UC gold table.
 */
export async function searchSegmentSummary(
  db: AppDb,
  query: string,
): Promise<{ segment_id: string; cohort: string; platform: string; segment_summary: string }[]> {
  const pattern = `%${query}%`;
  const rows = await db
    .select({
      segment_id: segmentPosition.segmentId,
      cohort: segmentPosition.cohort,
      platform: segmentPosition.platform,
      segment_summary: segmentPosition.segmentSummary,
    })
    .from(segmentPosition)
    .where(ilike(segmentPosition.segmentSummary, pattern))
    .limit(10);
  return rows;
}
