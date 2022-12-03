//
//  AppState.swift
//  pet-client
//
//  Created by 김지수 on 2022/12/03.
//

import Foundation

final class AppState: ObservableObject {
  @Published var contentViewId = UUID()

  func refreshContentView() {
    contentViewId = UUID()
  }
}
