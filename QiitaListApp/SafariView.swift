//
//  SafariView.swift
//  QiitaListApp
//
//  Created by 渡邊魁優 on 2023/03/07.
//

import SwiftUI
//アプリ内部でsafariを起動させるためのフレームワーク
import SafariServices

struct SafariView: UIViewControllerRepresentable {
    //表示するURLを受け取るための変数
    let url: URL
    
    func makeUIViewController(context: Context) -> SFSafariViewController {
        //safariを起動
        return SFSafariViewController(url: url)
    }
    
    func updateUIViewController(_ uiViewController: SFSafariViewController, context: Context) {
        //Viewが更新された時に実行(今回は記述なし)
    }
}
