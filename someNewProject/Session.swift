//
//  Session.swift
//  someNewProject
//
//  Created by nanoman on 23.05.2021.
//

class Session {
  static let instance = Session()
  
  private init() {}
  
  var token: String = ""
  var userId: Int = 0
}
