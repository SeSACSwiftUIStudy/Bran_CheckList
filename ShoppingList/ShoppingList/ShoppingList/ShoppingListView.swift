//
//  ShoppingListView.swift
//  ShoppingList
//
//  Created by Bran on 2022/05/29.
//

import SwiftUI

struct ShoppingListView: View {
  @StateObject
  var viewModel: ShoppingListViewModel

  @State
  private var text: String = ""

  // TODO: - 다크모드 대응 필요
  @Environment(\.colorScheme)
  var colorScheme

  private let device = UIScreen.main.bounds

  init(_ viewModel: ShoppingListViewModel) {
    _viewModel = StateObject(wrappedValue: viewModel)
    UITableView.appearance().backgroundColor = colorScheme == .light ? .white : .black
    UITableView.appearance().separatorColor = .clear
  }

  var body: some View {
    NavigationView {
      VStack(spacing: 0) {
        HStack {
          TextField("구매할 상품을 입력하세요", text: $text)
            .onAppear(
              perform: UIApplication.shared.hideKeyboard
            )

          Button(
            action: {
              viewModel.addList(text)
              text = ""
            },
            label: {
              Text("추가")
                .foregroundColor(.black)
                .padding([.top, .bottom], 8)
                .padding([.leading, .trailing], 10)
                .background(Color(UIColor.systemGray3))
                .cornerRadius(15)
            }
          )
        }
        .padding()
        .frame(width: device.width * 0.9)
        .background(Color(UIColor.systemGray5))
        .cornerRadius(10)

        Spacer()

        List {
          ForEach(viewModel.shoppingList) { item in
            HStack {
              Button(
                action: {
                  viewModel.changeList(item, .checkBox)
                },
                label: {
                  if item.checkBox {
                    Image(systemName: "checkmark.square.fill")
                  } else {
                    Image(systemName: "checkmark.square")
                  }
                }
              )
              .buttonStyle(PlainButtonStyle())

              Text(item.name)
                .multilineTextAlignment(.leading)

              Spacer()

              Button(
                action: {
                  viewModel.changeList(item, .star)
                },
                label: {
                  if item.star {
                    Image(systemName: "star.fill")
                  } else {
                    Image(systemName: "star")
                  }
                }
              )
              .buttonStyle(PlainButtonStyle()) // TODO: - 기능파악하기
            }
            .padding()
//            .frame(width: device.width * 0.9)
            .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 8, trailing: 0))
            .background(
              Color(UIColor.systemGray5)
            )
            .cornerRadius(10)
          }
          .onDelete(perform: viewModel.deleteList(at:))
        }
      }
      .navigationTitle("쇼핑")
      .navigationBarTitleDisplayMode(.inline)
    }
  }
}


struct ShoppingListView_Previews: PreviewProvider {
  static var previews: some View {
    ShoppingListView(ShoppingListViewModel())
  }
}
