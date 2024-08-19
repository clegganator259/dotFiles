///usr/bin/true; exec /usr/bin/env go run "$0" "$@"
package main
import (
    "fmt"
    "strings"
    "io"
    "os"
)

func DelimitFile(sourcePath string) error {
    destPath := strings.Replace(sourcePath, " ", "-", -1)
    inputFile, err := os.Open(sourcePath)
    if err != nil {
        return fmt.Errorf("Couldn't open source file: %v", err)
    }
    defer inputFile.Close()

    outputFile, err := os.Create(destPath)
    if err != nil {
        return fmt.Errorf("Couldn't open dest file: %v", err)
    }
    defer outputFile.Close()

    _, err = io.Copy(outputFile, inputFile)
    if err != nil {
        return fmt.Errorf("Couldn't copy to dest from source: %v", err)
    }

    inputFile.Close() // for Windows, close before trying to remove: https://stackoverflow.com/a/64943554/246801

    err = os.Remove(sourcePath)
    if err != nil {
        return fmt.Errorf("Couldn't remove source file: %v", err)
    }
    return nil
}

func main() {
    DelimitFile(os.Args[1])
}
