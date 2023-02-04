package main

import (
	"fmt"

	"golang.org/x/tools/cover"
)

func main() {
	profilesA, err := cover.ParseProfiles("cover.out")
	if err != nil {
		panic(err)
	}

	// profilesB, err := cover.ParseProfiles("cover2.out")
	// if err != nil {
	// 	panic(err)
	// }

	for _, profile := range profilesA {
		for _, block := range profile.Blocks {
			fmt.Printf("%s %d %d\n", profile.FileName, block.NumStmt, block.Count)
		}
	}
}
