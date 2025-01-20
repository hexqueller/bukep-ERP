package main

import (
	"encoding/json"
	"log"
	"net/http"
)

func main() {
	http.HandleFunc("/up", func(w http.ResponseWriter, r *http.Request) {
		w.Header().Set("Content-Type", "application/json")
		response := map[string]string{"status": "up"}
		json.NewEncoder(w).Encode(response)
	})

	log.Println("Server started on :8080")

	if err := http.ListenAndServe(":8080", nil); err != nil {
		log.Fatalf("Error when starting server: %v", err)
	}
}
