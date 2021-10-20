//
//  LoginModel.swift
//  MassageRobot
//
//  Created by Sumit Sharma on 24/02/21.
//

import Foundation
struct LogionModel:Codable{
    var email:String?,
            firstname: String?,
            lastlogin: String?,
            lastname: String?,
            password: String?,
            registerdate:String?,
            role: String?,
            thumbnail:String?,
            userid:String?
    enum  CodingKeys:String,CodingKey{
        case email,firstname,lastlogin,lastname,password,registerdate,role,thumbnail,userid
    }
    
    func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(email, forKey: .email)
            try container.encode(firstname, forKey: .firstname)
            try container.encode(lastlogin, forKey: .lastlogin)
            try container.encode(lastname, forKey: .lastname)
            try container.encode(password, forKey: .password)
        try container.encode(registerdate, forKey: .registerdate)
        try container.encode(role, forKey: .role)
        try container.encode(thumbnail, forKey: .thumbnail)
        try container.encode(userid, forKey: .userid)
        }
}
