//
//  Array+Only.swift
//  Memorize
//
//  Created by Darren Beukes on 25/1/21.
//

import Foundation

extension Array {
  var only: Element? {
    return count == 1 ? first : nil
  }
}
