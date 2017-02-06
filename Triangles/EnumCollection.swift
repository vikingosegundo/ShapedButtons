//
//  EnumCollection+allValues.swift
//  HearingTest
//
//  Created by Manuel Meyer on 25.01.17.
//  Copyright © 2017 Mimi Hearing Technologies GmbH. All rights reserved.
//


// refer: https://theswiftdev.com/2017/01/05/18-swift-gist-generic-allvalues-for-enums/

import Foundation


protocol EnumCollection: RawRepresentable, Hashable {
    static var allValues: [Self] { get }
}

extension EnumCollection where RawValue: Integer {
    static var allValues: [Self] {
        var index: Self.RawValue = 0
        let increment: Self.RawValue = 1
        
        return Array(AnyIterator {
            let id: Self.RawValue = index
            index += increment
            return Self(rawValue: id)
        })
    }
}

extension EnumCollection {
    
    static func cases() -> AnySequence<Self> {
        typealias SelfType = Self
        return AnySequence { () -> AnyIterator<SelfType> in
            var raw = 0
            return AnyIterator {
                let current: Self = withUnsafePointer(to: &raw) { $0.withMemoryRebound(to: SelfType.self, capacity: 1) { $0.pointee } }
                guard current.hashValue == raw else {
                    return nil
                }
                raw += 1
                return current
            }
        }
    }
    
    static var allValues: [Self] {
        return Array(self.cases())
    }
}
