ALTER TABLE IF EXISTS "accounts" DROP CONSTRAINT if EXISTS "owner_currency_key";
ALTER TABLE IF EXISTS "accounts" DROP CONSTRAINT if EXISTS "accounts_owner_fkey";

DROP TABLE IF EXISTS users;  