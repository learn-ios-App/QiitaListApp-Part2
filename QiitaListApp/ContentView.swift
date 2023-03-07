//
//  ContentView.swift
//  QiitaListApp
//
//  Created by 渡邊魁優 on 2023/03/06.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = QiitaData()
    @State var showSafari = false
    var body: some View {
        List {
            ForEach(viewModel.articleList) { element in
                Button(action: {
                    viewModel.qiitaLink = element.url
                    showSafari = true
                }) {
                    HStack {
                        AsyncImage(url: element.user.profileImageURL) { image in
                            image
                                .resizable()
                                .scaledToFit()
                                .frame(height: 40)
                        } placeholder: {
                            ProgressView()
                        }
                        Text(element.title)
                            .foregroundColor(.black)
                    }
                }
            }
        }
        .onAppear(perform: viewModel.getQiitaArticle)
        .sheet(isPresented: $showSafari) {
            SafariView(url: viewModel.qiitaLink!)
                .ignoresSafeArea()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
