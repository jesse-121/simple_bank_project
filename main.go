package main

import (
	"database/sql"
	"log"

	"github.com/jesse-121/simple_bank_project/api"
	db "github.com/jesse-121/simple_bank_project/db/sqlc"
	"github.com/jesse-121/simple_bank_project/utils"
	_ "github.com/lib/pq"
)

var testDB *sql.DB

func main() {
	config, err := utils.LoadConfig(".")
	if err != nil {
		log.Fatal("cannot load config:", err)
	}

	conn, err := sql.Open(config.DBDriver, config.DBSource)
	if err != nil {
		log.Fatal("cannot connect to db:", err)
	}

	store := db.NewStore(conn)
	server := api.NewServer(store)

	err = server.Start(config.ServerAddress)
	if err != nil {
		log.Fatal("cannot start server:", err)
	}
}
