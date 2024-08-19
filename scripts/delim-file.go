///usr/bin/true; exec /usr/bin/env go run "$0" "$@"
package main
import (
    "fmt"
    "strings"
    "io"
    "os"
    "bufio"
)

func DelimitFile(sourcePath string) error {
    destPath := strings.Replace(sourcePath, " ", "-", -1)
    inputFile, err := os.Open(sourcePath)
    if err != nil {
        return fmt.Errorf("Couldn't open source file: %v", err)
    }
    defer inputFile.Close()

    
    if _, err := os.Stat(destPath); err == nil {
        fmt.Printf("Dest file %s exists, do you want to replace (Y/N)\n", destPath)
        reader := bufio.NewReader(os.Stdin)
        // ReadString will block until the delimiter is entered
        input, _ := reader.ReadString('\n')
        if strings.ToLower(input) == "n\n"{
            fmt.Print("Cancelling")
            return nil
        }
        if strings.ToLower(input) != "y\n" {
            fmt.Printf("%s", input)
            return fmt.Errorf("Invalid choice")
        }
        fmt.Print("Replacing")
    } else {
        fmt.Printf("Error %v", err)
        return fmt.Errorf("Couldn't open dest file: %v", err)
    }
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
    err := DelimitFile(os.Args[1])
    if err != nil {
        fmt.Printf("Error: %v", err)
    }
}
