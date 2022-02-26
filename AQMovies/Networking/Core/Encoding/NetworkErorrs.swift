//
//  NetworkErorrs.swift
//  Delivery Boy
//
//  Created by Ali on 12/5/21.
//

import Foundation

enum NetworkErrors : String , Error {
    case invalidURL = "This URL Created an invaild request"
    case unapleToComplete = "Unaple to complete your request, Check your internet connection"
    case invalidRespons = "Invalid response from the server"
    case invalidData = "The data recevied from the server was invalid"
    
}
