//
//  Array+Only.swift
//  Memorize
//
//  Created by Darren Beukes on 25/1/21.
//

import Foundation

extension Array {
  var only: Element? {
    return self.count == 1 ? self.first : nil
  }
}

