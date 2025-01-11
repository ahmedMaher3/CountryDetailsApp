//
//  EndPoint.swift
//  iOSChallenge
//
//  Created by ahmed maher on 11/01/2025.
//


import Foundation

protocol Endpoint {
    var service: EndpointService {get set}
    var urlPrefix: String {get set}
    var method: EndpointMethod {get set}
    var parameters: [String: Any] {get set}
    var encoding: EndpointEncoding {get set}
    var headers: [String: String] {get set}
}

enum EndpointEncoding {
    case json
    case query
}



enum EndpointMethod: String {
    case get
    case post
    case put
    case delete
    case patch
}

enum EndpointService {

    case countries

    var url: URL {
        switch self {
        case .countries :
            return URL(string: "\(baseUrl)all")!

        }
    }
}


extension EndpointService {

    var baseUrl: String{
        return "https://restcountries.com/v2/"
    }
}

func generateURLWithParams(params: [String: Any]?) -> String {
    if (params != nil && !(params!.isEmpty)) {
        var api = "?"

        params?.forEach { key, value in
            if let val = value as? CustomStringConvertible {
                api += "\(key)=\(val)&"
            }
        }

        if api.contains("&") {
            api = String(api.dropLast())
        }

        return api
    }
    else {
        return ""
    }
}
func convertModelToDictionary<T>(model: T) -> [String: Any] {
    let mirror = Mirror(reflecting: model)
    var dictionary = [String: Any]()

    for case let (label?, value) in mirror.children {
        dictionary[label] = value
    }

    return dictionary
}

