                                               ?column?                                               
------------------------------------------------------------------------------------------------------
 ALTER TABLE "public"."artist" DROP CONSTRAINT "artist_area_fkey" CASCADE;
 ALTER TABLE "public"."artist" DROP CONSTRAINT "artist_gender_fkey" CASCADE;
 ALTER TABLE "public"."artist" DROP CONSTRAINT "artist_type_fkey" CASCADE;
 ALTER TABLE "public"."release" DROP CONSTRAINT "release_status_fkey" CASCADE;
 ALTER TABLE "public"."release_country" DROP CONSTRAINT "release_country_release_fkey" CASCADE;
 ALTER TABLE "public"."release_has_artist" DROP CONSTRAINT "release_has_artist_artist_fkey" CASCADE;
 ALTER TABLE "public"."release_has_artist" DROP CONSTRAINT "release_has_artist_release_fkey" CASCADE;
 ALTER TABLE "public"."track" DROP CONSTRAINT "track_release_fkey" CASCADE;
 ALTER TABLE "public"."track_has_artist" DROP CONSTRAINT "track_has_artist_artist_fkey" CASCADE;
 ALTER TABLE "public"."track_has_artist" DROP CONSTRAINT "track_has_artist_track_fkey" CASCADE;
 ALTER TABLE "public"."artist" DROP CONSTRAINT "artist_check" CASCADE;
 ALTER TABLE "public"."artist" DROP CONSTRAINT "artist_check1" CASCADE;
 ALTER TABLE "public"."artist" DROP CONSTRAINT "artist_check2" CASCADE;
 ALTER TABLE "public"."artist" DROP CONSTRAINT "artist_check3" CASCADE;
 ALTER TABLE "public"."artist" DROP CONSTRAINT "artist_check4" CASCADE;
 ALTER TABLE "public"."artist" DROP CONSTRAINT "artist_check5" CASCADE;
 ALTER TABLE "public"."artist" DROP CONSTRAINT "artist_check6" CASCADE;
 ALTER TABLE "public"."artist" DROP CONSTRAINT "artist_check7" CASCADE;
 ALTER TABLE "public"."release_country" DROP CONSTRAINT "release_country_check" CASCADE;
 ALTER TABLE "public"."release_country" DROP CONSTRAINT "release_country_check1" CASCADE;
 ALTER TABLE "public"."release_country" DROP CONSTRAINT "release_country_check2" CASCADE;
 ALTER TABLE "public"."release_country" DROP CONSTRAINT "release_country_check3" CASCADE;
 ALTER TABLE "public"."release_status" DROP CONSTRAINT "release_status_name_check" CASCADE;
 ALTER TABLE "public"."artist" DROP CONSTRAINT "artist_pkey" CASCADE;
 ALTER TABLE "public"."artist_type" DROP CONSTRAINT "artist_type_pkey" CASCADE;
 ALTER TABLE "public"."country" DROP CONSTRAINT "country_pkey" CASCADE;
 ALTER TABLE "public"."gender" DROP CONSTRAINT "gender_pkey" CASCADE;
 ALTER TABLE "public"."release" DROP CONSTRAINT "release_pkey" CASCADE;
 ALTER TABLE "public"."release_country" DROP CONSTRAINT "release_country_pkey" CASCADE;
 ALTER TABLE "public"."release_has_artist" DROP CONSTRAINT "release_has_artist_pkey" CASCADE;
 ALTER TABLE "public"."release_status" DROP CONSTRAINT "release_status_pkey" CASCADE;
 ALTER TABLE "public"."track" DROP CONSTRAINT "track_pkey" CASCADE;
 ALTER TABLE "public"."track_has_artist" DROP CONSTRAINT "track_has_artist_pkey" CASCADE;
(33 rows)

