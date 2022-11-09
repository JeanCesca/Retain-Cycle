//
//  ViewController.swift
//  Strong.Weak.ARC
//
//  Created by Jean Ricardo Cesca on 09/11/22.
//

import Foundation
import UIKit

class Person {
    let name: String
    var macbook: Macbook?
    
    init(name: String, macbook: Macbook?) {
        self.name = name
        self.macbook = macbook
    }
    
    //Deinit só é chamado quando o objeto é retirado da memória, ou seja, quando NÃO há retain cycle.
    deinit {
        print("\(name) is being deinitialized.")
    }
}

class Macbook {
    let name : String
    weak var owner: Person?
    
    init(name: String, owner: Person?) {
        self.name = name
        self.owner = owner
    }
    
    deinit {
        print("Macbook named \(name) is being deinitialized.")
    }
}

class ViewController: UIViewController {
    
    var sean: Person?
    var matilda: Macbook?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createObjects()
        assignProperties()
    }
    
    func createObjects() {
        sean = Person(name: "Sean", macbook: nil) //SEAN tem UMA strong reference a PERSON
        matilda = Macbook(name: "Matilda", owner: nil) //MATILDA tem UMA strong reference a MACBOOK
        
        //se eu atribuo NIL aos objetos, tenho:
        //        sean = nil //Sean is being deinitialized.
        //        matilda = nil //Macbook named Matilda is being deinitialized.
    }
    
    func assignProperties() {
        sean?.macbook = matilda
        matilda?.owner = sean
        
        //Aqui tenho reference de Sean a Matilda, e Matilda a Sean
        
        //se eu atribuo NIL aos objetos, não tenho ARC igual a zero, pois ainda tenho Sean apontado para Matilda e Matilda a Sean
        sean = nil
        matilda = nil
        
    }
}
