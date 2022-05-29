//
//  ShoppingListApp.swift
//  ShoppingList
//
//  Created by Bran on 2022/05/29.
//

import SwiftUI

@main
struct ShoppingListApp: App {
  var body: some Scene {
    WindowGroup {
      ShoppingListView(ShoppingListViewModel())
    }
  }
}
