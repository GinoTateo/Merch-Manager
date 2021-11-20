//
//  DataFactory.swift
//  Merch Manager
//
//  Created by Gino Tateo on 11/12/21.
//

import Foundation

struct store: Identifiable{
   
    var chainName: String = ""
    var storeNumber: String = ""
    var city: String = ""
    var backStock: String = ""
    var id = UUID()
    


    init(raw: [String]){
        chainName = raw[0]
        //newStore.name = raw[0]
        storeNumber = raw[1]
        //newStore.city =  raw[1]
        city = raw[2]
        //newStore.city = raw[2]
        backStock =  raw[3]
        //newStore.backStock = raw[3]
    }
    
}

func loadCSV(from csvName: String)->[store]{
    var csvToStruct = [store]()
    
    //Locate the CSV file
    guard let filepath = Bundle.main.path(forResource: csvName, ofType: "csv") else {
        print("Not opening the file")
        return[]
    }
    
    var data = ""
    do{
        data = try String(contentsOfFile: filepath)
    }catch {
        print(error)
        return[]
    }
    
    // Split the string into an array of rows
    var rows = data.components(separatedBy: "\n")   //\n means new line. Therefore we can split up eachline this way
    
    
    let columnCount = rows.first?.components(separatedBy: "\n").count
    
    // Remove header rows
    rows.removeFirst()
    
    // Now loop around the rows and split each into a column
    for row in rows {
        let csvColumns = row.components(separatedBy: ",")
        if csvColumns.count == columnCount{
            let storeStruct = store.init(raw: csvColumns)
            csvToStruct.append(storeStruct)
        }
    }
    
    return csvToStruct
}
