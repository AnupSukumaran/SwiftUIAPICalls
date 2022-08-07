//
//  ViewModel.swift
//  SwiftUIAPICalls
//
//  Created by sukumar.sukumaran on 07/08/2022.
//

import Foundation
import SwiftUI

struct Course: Hashable, Codable{
    let name: String
    let image: String
}

class ViewModel: ObservableObject{
    
    @Published var courses = [Course]()
    
    func fetch() {
        guard let url = URL(string: "https://iosacademy.io/api/v1/courses/index.php") else {return}
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard error == nil, let data = data  else {
                return
            }
            
            do {
                let courses = try JSONDecoder().decode([Course].self, from: data)
                
                DispatchQueue.main.async {
                    self?.courses = courses
                }
                
            } catch {
                print(error)
            }
        }
        
        task.resume()
    }
    
}
