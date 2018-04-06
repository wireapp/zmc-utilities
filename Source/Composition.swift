//
// Wire
// Copyright (C) 2018 Wire Swiss GmbH
//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with this program. If not, see http://www.gnu.org/licenses/.
//

import Foundation

/// Function composition operator: (f1 ∘ f2)(x) = f1(f2(x))
infix operator >>> : AdditionPrecedence
public func >>> <A, B, C>(f: @escaping (B) -> C, g: @escaping (A) -> B) -> (A) -> C {
    return { x in f(g(x)) }
}

// Direct promise version.
public func >>> <A, B, C>(f: @escaping (B) -> C, g: @escaping (A) -> Promise<B>) -> (A) -> Promise<C> {
    return { x in
        let resultPromise = Promise<C>()
        g(x).whenDone { resultPromise.fulfill(with: $0.map(f)) }
        return resultPromise
    }
}

// Indirect promise version with g having a second parameter callback returning B.
public func >>> <A, B, C>(f: @escaping (B) -> C, g: @escaping (A, @escaping (B) -> Void) -> Void) -> (A) -> Promise<C> {
    return { x in
        let resultPromise = Promise<C>()
        let completion: (B)->() = {
            resultPromise.fulfill(with: Result<C>.success(f($0)))
        }
        g(x, completion)
        return resultPromise
    }
}

// Indirect promise version with g having a second parameter callback returning B.
public func >>> <A, B, C>(f: @escaping (B) -> C, g: @escaping (A, @escaping (Result<B>) -> Void) -> Void) -> (A) -> Promise<C> {
    return { x in
        let resultPromise = Promise<C>()
        let completion: (Result<B>)->() = {
            switch $0 {
            case .success(let result):
                resultPromise.fulfill(with: Result<C>.success(f(result)))
            case .failure(let error):
                resultPromise.fulfill(with: Result<C>.failure(error))
            }
        }
        g(x, completion)
        return resultPromise
    }
}

public func >>> <A, B, C>(f: @escaping (B, @escaping (C) -> Void) -> Void, g: @escaping (A) -> (B)) -> (A) -> Promise<C> {
    return { x in
        let resultPromise = Promise<C>()
        let completion: (C)->() = {
            resultPromise.fulfill(with: Result<C>.success($0))
        }
        f(g(x), completion)
        return resultPromise
    }
}
