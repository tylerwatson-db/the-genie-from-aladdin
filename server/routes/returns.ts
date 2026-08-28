/**
 * Returns-by-city stub route.
 *
 * The operations page map widget calls GET /api/returns/by-city expecting
 * GeoJSON-like city data. This use case (nimbus growth desk) doesn't track
 * product returns, so we return an empty array to satisfy the UI contract
 * and prevent the 404.
 */
import type { Application } from 'express';

export function registerReturnsRoutes(
  app: Application,
  _deps: { db: unknown },
): void {
  app.get('/api/returns/by-city', (_req, res) => {
    res.json({ data: [], message: 'No returns data — growth desk use case' });
  });
}
