//
//  Box.swift
//  Moviestagram
//
//  Created by Mason Kim on 2023/02/06.
//

import Foundation

final class Observable<Value> {
    typealias Listener = (Value) -> Void
    var listener: Listener?

    var value: Value {
        didSet {
            listener?(value)
        }
    }

    init(_ value: Value) {
        self.value = value
    }

    func bind(listener: Listener?) {
        self.listener = listener
        listener?(value)
    }
}
