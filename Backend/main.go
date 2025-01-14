package main

import (
	"encoding/json"
	"net/http"
	"time"
)

func main() {
	http.HandleFunc("/hello", func(w http.ResponseWriter, r *http.Request) {
		w.Write([]byte("Hello, World!"))
	})

	http.HandleFunc("/time", func(w http.ResponseWriter, r *http.Request) {
		w.Header().Set("Content-Type", "application/json")
		currentTime := time.Now().Format("2006-01-02 15:04:05")
		response := map[string]string{"time": currentTime}
		json.NewEncoder(w).Encode(response)
	})

	http.HandleFunc("/up", func(w http.ResponseWriter, r *http.Request) {
		w.Header().Set("Content-Type", "application/json")
		response := map[string]string{"status": "up"}
		json.NewEncoder(w).Encode(response)
	})

	http.ListenAndServe(":8080", nil)
}
