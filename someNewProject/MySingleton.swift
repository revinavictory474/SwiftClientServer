//
//  MySingleton.swift
//  someNewProject
//
//  Created by Юрий Султанов on 17.05.2021.
//

class MySingleton {
    static let instance = MySingleton()
    
    var userName: String = ""
    var userSurname: String = "Surname"
    
    private init() { }
}
