//
//  ParameterEncoderProtocol.swift
//  GifChallenge
//
//  Created by Mikalai on 10.03.2022.
//

import Foundation

public typealias Parameters = [String: Any]

public protocol ParameterEncoder {
    static func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws
}
