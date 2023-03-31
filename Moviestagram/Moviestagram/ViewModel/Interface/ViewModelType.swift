//
//  ViewModelType.swift
//  Moviestagram
//
//  Created by Mason Kim on 2023/03/29.
//

import Foundation
import Combine

protocol ViewModelType {
    associatedtype Input
    associatedtype Output

    var bag: Set<AnyCancellable> { get set }
    var input: Input { get }
    var output: Output { get }
}
