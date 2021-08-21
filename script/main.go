package main

import (
	"fmt"
	"io/ioutil"
	"log"

	_ "github.com/go-sql-driver/mysql"
	"github.com/jmoiron/sqlx"
)

var (
	db                  *sqlx.DB
	mySQLConnectoinData *MySQLConnectionEnv
)

type MySQLConnectionEnv struct {
	Host     string
	Port     string
	User     string
	DBName   string
	Password string
}

type Isu struct {
	//ID         int       `db:"id" json:"id"`
	JIAIsuUUID string `db:"jia_isu_uuid" json:"jia_isu_uuid"`
	//Name       string    `db:"name" json:"name"`
	Image []byte `db:"image" json:"-"`
	//Character  string    `db:"character" json:"character"`
	//JIAUserID  string    `db:"jia_user_id" json:"-"`
	//CreatedAt  time.Time `db:"created_at" json:"-"`
	//UpdatedAt  time.Time `db:"updated_at" json:"-"`
}

func main() {

	mySQLConnectionData := NewMySQLConnectionEnv()

	db, err := mySQLConnectionData.ConnectDB()
	if err != nil {
		log.Fatal(err)
	}
	db.SetMaxOpenConns(10)
	defer db.Close()

	rows, err := db.Queryx("select jia_isu_uuid, image from isu")
	if err != nil {
		log.Fatal(err)
	}

	var image Isu
	for rows.Next() {
		if err := rows.StructScan(&image); err != nil {
			log.Fatal(err)
		}

		if err := ioutil.WriteFile(image.JIAIsuUUID+".jpg", image.Image, 0644); err != nil {
			log.Fatal(err)
		}
	}
}

func NewMySQLConnectionEnv() *MySQLConnectionEnv {
	return &MySQLConnectionEnv{
		Host:     "127.0.0.1",
		Port:     "3306",
		User:     "isucon",
		DBName:   "isucondition",
		Password: "isucon",
	}
}

func (mc *MySQLConnectionEnv) ConnectDB() (*sqlx.DB, error) {
	dsn := fmt.Sprintf("%v:%v@tcp(%v:%v)/%v?parseTime=true&loc=Asia%%2FTokyo", mc.User, mc.Password, mc.Host, mc.Port, mc.DBName)
	return sqlx.Open("mysql", dsn)
}
