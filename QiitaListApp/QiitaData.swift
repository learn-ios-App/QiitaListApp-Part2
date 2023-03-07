//
//  QiitaData.swift
//  QiitaListApp
//
//  Created by 渡邊魁優 on 2023/03/06.
//

import Foundation

//List表示するための構造体
struct Article: Identifiable {
    let id = UUID()
    let title: String
    let url: URL
    let user: User
}

struct User: Decodable {
    let name: String
    let profileImageURL: URL
    
    enum CodingKeys: String, CodingKey {
        case name
        case profileImageURL = "profile_image_url"
    }
}

class QiitaData: ObservableObject {
    
    struct Item: Decodable {
        let title: String?
        let url: URL?
        let user: User?
        
        enum CodingKeys: String, CodingKey {
            case title
            case url
            case user
        }
    }
    @Published var articleList: [Article] = []
    var qiitaLink: URL?
    
    func getQiitaArticle()  {
        Task {
            await getAriticle()
        }
    }
    
    @MainActor
    private func getAriticle() async {
        guard let url = URL(string: "https://qiita.com/api/v2/items?page=1&per_page=20") else {
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let json = try JSONDecoder().decode([Item].self, from: data)
            
            for item in json {
                if let title = item.title,
                   let url = item.url,
                   let user = item.user {
                    //構造体作成
                    let article = Article(title: title, url: url, user: user)
                    articleList.append(article)
                }
            }
        } catch {
            print("エラー発生")
        }
    }
}
