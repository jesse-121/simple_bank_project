postgres:
	docker run --name postgres17 -p 5432:5432 --network bank-network -e POSTGRES_USER=root -e POSTGRES_PASSWORD=secret -d postgres

createdb:
	docker exec -it postgres17 createdb --username=root --owner=root simple_bank

dropdb:
	docker exec -it postgres17 dropdb simple_bank

migrationcreate:
	migrate create -ext sql -dir db/migration -seq init_schema

migrateup:
	migrate -path db/migration -database "postgresql://root:secret@localhost:5432/simple_bank?sslmode=disable" -verbose up

migrateup1:
	migrate -path db/migration -database "postgresql://root:secret@localhost:5432/simple_bank?sslmode=disable" -verbose up 1

migratedown:
	migrate -path db/migration -database "postgresql://root:secret@localhost:5432/simple_bank?sslmode=disable" -verbose down

migratedown1:
	migrate -path db/migration -database "postgresql://root:secret@localhost:5432/simple_bank?sslmode=disable" -verbose down 1

sqlc:
	sqlc generate

test:
	go test -v -cover ./...

server:
	go run main.go

runcontainer: 
	docker run --name simplebank -p 8080:8080 --network bank-network -e GIN_MODE=release -e DB_SOURCE="postgresql://root:secret@postgres17:5432/simple_bank?sslmode=disable"  simplebank:latest

mock: 
	mockgen -package mockdb -destination db/mock/store.go github.com/jesse-121/simple_bank_project/db/sqlc Store   

.PHONY: postgres createdb dropdb migrationcreate migrateup migrateup1 migratedown migratedown1 sqlc test server mock

# docker exec -it postgres17 psql -U root -d simple_bank
