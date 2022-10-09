//
//  Array.swift
//  Nitroless
//
//  Created by Paras KCD on 2022-10-09.
//

import Foundation

extension Array {
    func unique(selector:(Element,Element)->Bool) -> Array<Element> {
        return reduce(Array<Element>()){
            if let last = $0.last {
                return selector(last,$1) ? $0 : $0 + [$1]
            } else {
                return [$1]
            }
        }
    }
}
