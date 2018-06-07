package main

import (
    "fmt"
    "net/http"
    "io/ioutil"
)

var data string

func handler(w http.ResponseWriter, r *http.Request) {
	fmt.Fprint(w, data)
}

func main() {
	contents, _ := ioutil.ReadFile("mockdata.json")

	data = string(contents)

	http.HandleFunc("/", handler)
	http.ListenAndServe(":8080", nil)
}
