package main

import "fmt"

func main() {
	var a = "initial"
	fmt.Println(a)

	var b, c int = 1, 2
	fmt.Println(b, c)

	var d = false
	fmt.Println(d)

	// Declare a variable without a value
	// Depends on the type, zero value is assigned
	var e float64
	fmt.Println(e, "is the zero value for float64")

	f := "organge"
	fmt.Println(f)
}
