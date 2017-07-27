

import Foundation
import UIKit

class Recipe: NSObject {
    var nombre: String!
    var imagen: UIImage!
    var tiempo: Int!
    var ingredientes: [String]!
    var pasos: [String]!
    //var isFavourite: Bool = false
    var rating : String = "rating"
    
    init(name: String, image: UIImage, time: Int, ingredient: [String], step: [String]) {
        self.nombre = name
        self.imagen = image
        self.tiempo = time
        self.ingredientes = ingredient
        self.pasos = step
    }
    
}
