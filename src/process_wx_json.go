// Process a JSON file and return a map of the data
// Write the results to a csv file
//
// Usage: process_json.go <filename.json>
// Example: process_json.go 1692416726.json
//

// Pass in file name as argument
// Check if file exists
// If file exists

// Open file
// Read file
// Parse file
// Write to csv file

package main

import (
	"encoding/csv"
	"encoding/json"
	"fmt"
	"io"
	"os"
	"strings"
)

func main() {

	json_filename := os.Args[1]
	var filename string

	// Open our jsonFile
	jsonFile, err := os.Open(json_filename) // "1692416726.json")
	// if we os.Open returns an error then handle it
	if err != nil {
		fmt.Println(err)
		os.Exit(1)
	}
	fmt.Printf("Successfully Opened %s", json_filename)

	filename = strings.TrimSuffix(json_filename, ".json")

	fmt.Println(filename)

	// defer the closing of our jsonFile so that we can parse it later on
	defer jsonFile.Close()
	// read our opened xmlFile as a byte array.
	byteValue, _ := io.ReadAll(jsonFile)

	// Open the csv file for writing
	csv_filename := filename + ".csv"
	fmt.Println(csv_filename)
	csv_file, err := os.Create(csv_filename)
	if err != nil {
		panic(err)
	}
	defer csv_file.Close()

	// Create a csv writer
	csv_writer := csv.NewWriter(csv_file)
	defer csv_writer.Flush()

	// Write Headers
	csv_writer.Write([]string{"obsTime", "Temp", "Dewpt", "Wspd", "Wdir", "Cover", "Visib", "Fltcat", "Altim", "Slp", "RawOb"})

	type Property struct {
		Data    string  `json:"data"`
		Id      string  `json:"id"`
		Site    string  `json:"site"`
		ObsTime string  `json:"obsTime"`
		Temp    float64 `json:"temp"`
		Dewpt   string  `json:"dewpt"`
		Wspd    int     `json:"wspd"`
		Wdir    int     `json:"wdir"`
		Cover   string  `json:"cover"`
		Visib   float64 `json:"visib"`
		Fltcat  string  `json:"fltcat"`
		Altim   float64 `json:"altim"`
		Slp     float64 `json:"slp"`
		RawOb   string  `json:"rawOb"`
	}

	type Feature struct {
		Type       string   `json:"type"`
		Properties Property `json:"properties"`
	}

	type Weather struct {
		Type     string    `json:"type"`
		Features []Feature `json:"features"`
	}

	// we initialize our Users array
	//var users Users
	//

	data := Weather{}

	// we unmarshal our byteArray which contains our
	// jsonFile's content into 'users' which we defined above
	err = json.Unmarshal(byteValue, &data)
	if err != nil {
		fmt.Println(err)
	}
	// we iterate through every user within our users array and
	// print out the user Type, their name, and their facebook url
	// as just an example
	//
	fmt.Println("Start")

	property := data.Features[1].Properties
	obsTime := property.ObsTime
	temp := fmt.Sprintf("%f", property.Temp)
	dewpt := property.Dewpt
	wspd := fmt.Sprintf("%d", property.Wspd)
	wdir := fmt.Sprintf("%d", property.Wdir)
	cover := property.Cover
	visib := fmt.Sprintf("%f", property.Visib)
	fltcat := property.Fltcat
	altim := fmt.Sprintf("%f", property.Altim)
	slp := fmt.Sprintf("%f", property.Slp)
	rawOb := property.RawOb

	// timestamp := fmt.Sprintf("%f", data.Now)
	// lat := fmt.Sprintf("%f", data.Aircraft[i].Lat)
	// lon := fmt.Sprintf("%f", data.Aircraft[i].Lon)
	// alt := fmt.Sprintf("%d", data.Aircraft[i].Alt)
	// track := fmt.Sprintf("%f", data.Aircraft[i].Track)
	// speed := fmt.Sprintf("%d", data.Aircraft[i].Speed)
	// messages := fmt.Sprintf("%d", data.Aircraft[i].Messages)
	// groundspeed := fmt.Sprintf("%f", data.Aircraft[i].Groundspeed)
	// altitude := fmt.Sprintf("%d", data.Aircraft[i].Altitude)
	// rate_of_climb := fmt.Sprintf("%d", data.Aircraft[i].Rate_of_climb)

	csv_writer.Write([]string{obsTime, temp, dewpt, wspd, wdir, cover, visib, fltcat, altim, slp, rawOb})
	// Write to csv file
	// csv_writer.Write([]string{"Now", "Hex", "Flight", "Lat", "Lon", "Alt", "Track", "Speed", "Squawk", "Radar", "Messages", "Groundspeed", "Altitude", "Rate_of_climb", "Category"})
	//
	// csv_writer.Write([]string{timestamp, data.Aircraft[i].Hex, data.Aircraft[i].Flight, lat, lon, alt, track, speed, data.Aircraft[i].Squawk, data.Aircraft[i].Radar, messages, groundspeed, altitude, rate_of_climb, data.Aircraft[i].Category})
	//

	fmt.Println("End")
}
