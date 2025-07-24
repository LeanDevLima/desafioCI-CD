package main

import (
	"fmt"
	"net/http"
	"math/rand"
	"time"
)

func main() {
	rand.Seed(time.Now().UnixNano())
	
	http.HandleFunc("/saudacao", func(w http.ResponseWriter, r *http.Request) {
		saudacoes := []string{
			"Olá, mundo!",
			"Bem-vindo!",
			"Oi, tudo bem?",
			"Saudações!",
			"Hey there!",
		}
		fmt.Fprintf(w, saudacoes[rand.Intn(len(saudacoes))])
	})

	http.ListenAndServe(":8080", nil)
}