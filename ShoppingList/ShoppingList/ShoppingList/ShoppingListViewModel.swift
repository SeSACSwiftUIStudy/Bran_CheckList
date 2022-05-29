//
//  ShoppingListViewModel.swift
//  ShoppingList
//
//  Created by Bran on 2022/05/29.
//

import Foundation
import SwiftUI

// TODO: - AppStorage 적용 후 커스텀한 프로퍼티래퍼 적용해보기!
class ShoppingListViewModel: ObservableObject {
  private let userDefaultsKey = "ShoppingList"
  private let userDefaults = UserDefaults.standard

  enum ChangeMode {
    case checkBox
    case star
  }

  @Published
  var shoppingList: [ShoppingListItem] = []

  init() {
    loadList()
  }

  // MARK: - New Value
  func addList(_ text: String) {
    let item = ShoppingListItem(
      checkBox: false,
      star: false,
      name: text
    )
    addList(item)
  }

  func addList(_ item: ShoppingListItem) {
    if shoppingList.contains(item) { return }
    shoppingList.append(item)
    userDefaults.setValue(try? PropertyListEncoder().encode(shoppingList), forKey: userDefaultsKey)
  }

  // MARK: - Modify Value
  func changeList(
    _ item: ShoppingListItem,
    _ mode: ChangeMode
  ) {
    guard
      let index = shoppingList.firstIndex(where: { $0.id == item.id })
    else {
      print("Modify Value Fail")
      return
    }
    var changeitem = item
    switch mode {
    case .checkBox:
      changeitem.checkBox.toggle()
    case .star:
      changeitem.star.toggle()
    }
    self.shoppingList[index] = changeitem
    userDefaults.setValue(try? PropertyListEncoder().encode(shoppingList), forKey: userDefaultsKey)
  }

  // MARK: - Delete Value
  func deleteList(at offsets: IndexSet) {
    shoppingList.remove(atOffsets: offsets)
    userDefaults.setValue(try? PropertyListEncoder().encode(shoppingList), forKey: userDefaultsKey)
  }

  func deleteList(_ item: ShoppingListItem) {
    guard
      let index = shoppingList.firstIndex(where: { $0.id == item.id })
    else {
      print("Cannot Find the ID")
      return
    }
    shoppingList.remove(at: index)
    userDefaults.setValue(try? PropertyListEncoder().encode(shoppingList), forKey: userDefaultsKey)
  }

  // MARK: - Init value
  private func loadList() {
    guard
      let list = userDefaults.value(forKey: userDefaultsKey) as? Data,
      let decodeList = try? PropertyListDecoder().decode(Array<ShoppingListItem>.self, from: list)
    else {
      print("Load UserDefaults Error")
      return
    }
    self.shoppingList = decodeList
  }
}
