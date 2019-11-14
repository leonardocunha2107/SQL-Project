SELECT rc_after.release, rc_after.country
FROM release_country rc_before, release_country rc_after
WHERE (rc_before.release = rc_after.release 
      AND (rc_before.year < rc_after.year
      OR (rc_before.year = rc_after.year AND rc_before.month < rc_after.month)
      OR (rc_before.year = rc_after.year AND rc_before.month = rc_after.month AND rc_before.day < rc_after.day)));
