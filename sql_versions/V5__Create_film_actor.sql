CREATE TABLE film_actor (
  actor_id INT UNSIGNED NOT NULL,
  film_id INT UNSIGNED NOT NULL,
  last_update TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY  (actor_id,film_id)
);