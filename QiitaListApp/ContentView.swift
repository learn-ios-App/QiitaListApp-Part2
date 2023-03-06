//
//  ContentView.swift
//  QiitaListApp
//
//  Created by 渡邊魁優 on 2023/03/06.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = QiitaData()
    var body: some View {
        List {
            
        }
        .onAppear() {
            viewModel.getQiitaArticle()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
