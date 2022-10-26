import Foundation
import SwiftUI
import Firebase

struct Dog: Identifiable{
    var id: String
    var breed: String
}

class DataManager: ObservableObject {
    @Published var dogs: [Dog] = []
    
    func fetchDogs(){
        dogs.removeAll()
        let db = Firestore.firestore()
        let ref = db.collection ("Dogs")
        ref.getDocuments { snapshot, error in
            guard error == nil else
            {
                print (error! .localizedDescription)
                return
            }
            if let snapshot = snapshot
            {
                for document in snapshot.documents {
                    let data = document.data()
                    let id = data["id"] as? String ?? ""
                    let breed = data["breed"] as? String ?? ""
                    let dog = Dog(id: id, breed: breed)
                    self.dogs.append (dog)
                }
                
            }
        }
    }
}
