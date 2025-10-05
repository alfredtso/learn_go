package main

import "fmt"

func main() {
	i := 1
	// simple for loop
	for i <= 5 {
		fmt.Println(i)
		i++
	}

	fmt.Println("---")
	for j := 0; j < 5; j++ {
		fmt.Println(j)
	}

	fmt.Println("---")
	for i := range 6 {
		if i%2 == 0 {
			continue
		}
		fmt.Println("range", i)
	}

}
