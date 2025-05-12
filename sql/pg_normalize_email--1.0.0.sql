CREATE OR REPLACE FUNCTION normalize_email(email TEXT)
RETURNS TEXT
LANGUAGE plpgsql
IMMUTABLE
AS $$
DECLARE
  lower_email         TEXT;
  username            TEXT;
  domain              TEXT;
  at_count            INT;
  normalized_username TEXT;
  normalized_domain   TEXT;
BEGIN
  IF email IS NULL THEN
    RAISE EXCEPTION
      USING MESSAGE = 'Email is null, cannot normalize',
            ERRCODE  = 'P0001';
  END IF;

  lower_email := lower(email);

  at_count := length(lower_email)
              - length(replace(lower_email, '@', ''));
  IF at_count <> 1 THEN
    RAISE EXCEPTION
      USING MESSAGE = format(
        'Invalid email format "%": expected exactly one "@", found %',
        email, at_count
      ),
      ERRCODE = 'P0001';
  END IF;

  username := split_part(lower_email, '@', 1);
  domain   := split_part(lower_email, '@', 2);

  normalized_username := username;
  normalized_domain   := domain;

  IF domain = 'googlemail.com' THEN
    normalized_domain := 'gmail.com';
  ELSIF domain = 'yandex.ru' THEN
    normalized_domain := 'ya.ru';
  END IF;

  IF normalized_domain IN ('gmail.com', 'live.com') THEN
    normalized_username := regexp_replace(
      normalized_username,
      '\.|(\+.*)', '', 'g'
    );
  ELSIF normalized_domain IN ('ya.ru', 'hotmail.com', 'outlook.com') THEN
    normalized_username := regexp_replace(
      normalized_username,
      '\+.*', '', 'g'
    );
  END IF;

  RETURN normalized_username || '@' || normalized_domain;
END;
$$;
