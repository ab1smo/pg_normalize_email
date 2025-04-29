# pg_normalize_email

A PostgreSQL extension for normalizing emails

## Installation

```bash
make install
```

## Usage

```sql
CREATE EXTENSION pg_normalize_email;
SELECT normalize_email('ExAmPle+spam@Gmail.com');
-- Output: example@gmail.com

SELECT normalize_email('User.Name+tag@GoogleMail.com');
-- Output: 'username@gmail.com'

SELECT normalize_email('foo@yaNdex.Ru');
-- Output: 'foo@ya.ru'

SELECT normalize_email('invalid@@example.com');
-- Output: ERROR:  Invalid email format "invalid@@example.com": expected exactly one "@", found 2
```
