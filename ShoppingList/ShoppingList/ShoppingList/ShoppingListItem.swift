//
//  ShoppingListItem.swift
//  ShoppingList
//
//  Created by Bran on 2022/05/29.
//

import Foundation

public struct ShoppingListItem: Identifiable, Codable {
  public var id: UUID
  var checkBox: Bool
  var star: Bool
  var name: String

  public init(
    id: UUID = UUID(),
    checkBox: Bool,
    star: Bool,
    name: String
  ) {
    self.id = id
    self.checkBox = checkBox
    self.star = star
    self.name = name
  }
}

extension ShoppingListItem: Hashable {
  public func hash(into hasher: inout Hasher) {
    hasher.combine(id)
  }
}

extension ShoppingListItem: Equatable {
  public static func ==(lhs: Self, rhs: Self) -> Bool {
    return lhs.id == rhs.id
  }
}
