//
//  DateModelController.swift
//  Merch Manager
//
//  Created by Gino Tateo on 5/21/22.
//

import Foundation

class DateModelController: ObservableObject {
    @Published private(set) var listOfValidDates: [DateModel] = []
    @Published private(set) var selectedDate = ""
    @Published private(set) var selectedDateFormatted = ""
    
    init() {
        getDates()
    }
    
    func toggleIsSelected(date: DateModel) {
        guard let oldIndex = self.listOfValidDates.firstIndex(where: {$0.isSelected}) else { return }
        listOfValidDates[oldIndex].isSelected = false
        guard let index = self.listOfValidDates.firstIndex(of: date) else { return }
        listOfValidDates[index].isSelected.toggle()
        selectedDate = listOfValidDates[index].monthAsString + " " + "\(listOfValidDates[index].day)"
        selectedDateFormatted = listOfValidDates[index].monthAsString + " \(listOfValidDates[index].day) " + listOfValidDates[index].year
    }
    
    private func getDates() {
        let currentDate = Date()
        
        //guard let minDate = Calendar.current.date(byAdding: .day, value: -5, to: currentDate) else { return }
        let minDate = Date()
        guard let maxDate = Calendar.current.date(byAdding: .day, value: 5, to: currentDate) else { return }
        let delta = Calendar.current.dateComponents([.day], from: minDate, to: maxDate).day!
        
        var counter = 0
        
        while counter <= delta {
            guard let newDate = Calendar.current.date(byAdding: .day, value: counter, to: minDate) else { return }
            var objectToAddInDate = DateModel()
            let day = Calendar.current.component(.day, from: newDate)
            objectToAddInDate.day = day
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "LLL"
            
            let yearFormatter = DateFormatter()
            yearFormatter.dateFormat = "yyyy"
            let yearString = yearFormatter.string(from: newDate)
            
            let month = dateFormatter.string(from: newDate)
            objectToAddInDate.monthAsInt = Calendar.current.component(.month, from: newDate)
            objectToAddInDate.monthAsString = month
            objectToAddInDate.year = Calendar.current.component(.year, from: newDate).description
            
            counter = counter + 1
            
            if (day == Calendar.current.component(.day, from: Date()) && month == dateFormatter.string(from: Date())) {
                objectToAddInDate.isSelected = true
            }
            let todayDate = Calendar.current.component(.day, from: Date())
            let todayMonth = dateFormatter.string(from: Date())
            self.selectedDate = todayMonth + " " + "\(todayDate)"
            self.selectedDateFormatted = todayMonth + " \(todayDate) " + yearString
            self.listOfValidDates.append(objectToAddInDate)
        }
        
        //update UI
    }
}

