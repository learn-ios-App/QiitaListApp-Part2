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
    let createdAt: String
    let user: User
    
    struct User {
        let name: String
        let image: URL
    }
}

class QiitaData: ObservableObject {
    
    struct Item: Decodable {
        let title: String?
        let createdAt: String?
        let user: User?
        
        enum CodingKeys: String, CodingKey {
            case title
            case createdAt = "created_at"
            case user
        }
        struct User: Decodable {
            let name: String?
            let profileImageURL: URL?
            
            enum CodingKeys: String, CodingKey {
                case name
                case profileImageURL = "profile_image_url"
            }
        }
    }
    @Published var articleList: [Article] = []
    
    func getQiitaArticle()  {
        Task {
            await getAriticle()
        }
    }
    
    @MainActor
    private func getAriticle() async {
        guard let url = URL(string: "https://qiita.com/api/v2/items?page=1&per_page=10") else {
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let json = try JSONDecoder().decode([Item].self, from: data)
//            let text = String(data: data, encoding: .utf8)!
//            print(text)
            
            for item in json {
                if let title = item.title,
                   let createdAt = item.createdAt,
                   let user = item.user {
                    //構造体作成
                    let article = Article(title: title, createdAt: createdAt, user: user)
                }
            }
        } catch {
            print("エラー発生")
        }
    }
}
