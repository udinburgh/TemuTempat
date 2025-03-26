//
//  ModelData.swift
//  
//
//  Created by Akbar Febry on 26/03/25.
//

import Foundation

@Observable
class ModelData {
    var places: [Places] = load("placesData.json")
}

func load<T: Decodable>(_ filename: String) -> T {              // function loads data from a file and returns an object of type T
    var data: Data      // Data is swift type that holds raw bytes
    
    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)  // Bundle.main.url to get url of filename
    else {                                                                         // guard ensures the file is exists, if returns nil, else block executes
        fatalError("Couldn't find \(filename) in main bundle.")
    }
    
    do {
        data = try Data(contentsOf: file)       // Data(contentsof: file) trying to read the file's content from the URL into the data variable
    }
    catch {
        fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
    }
    
    do {
        let decoder = JSONDecoder()                         // this converts raw data into an object type T, decode JSON data to swift types
        return try decoder.decode(T.self, from: data)
    }
    catch {
        fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
    }
}
