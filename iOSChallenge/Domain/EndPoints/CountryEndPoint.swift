//
//  CountryEndPoint.swift
//  iOSChallenge
//
//  Created by ahmed maher on 11/01/2025.
//

import Foundation
struct CountryEndPoint: Endpoint {

   var urlPrefix: String = ""
   var service: EndpointService = .countries
   var method: EndpointMethod = .get
   var encoding: EndpointEncoding = .query
   var parameters: [String: Any] = [:]
   var headers: [String: String] = [:]

}
