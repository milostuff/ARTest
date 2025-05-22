//
//  BrowseView.swift
//  ARTest
//
//  Created by Vian Martinez on 22/05/25.
//

import SwiftUI

struct BrowseView: View {
    
    @Binding var showBrowse: Bool
    
    var body: some View {
        
        NavigationView {
            ScrollView(showsIndicators: false) {
                ModelsByCategoryGrid()
            }
            .navigationBarTitle(Text("Browse"), displayMode: .large)
            .navigationBarItems(trailing:
                                    Button(action: {
                self.showBrowse.toggle()
            }) {
                Text("Done").bold()
            })
        }
        
    }
}

struct ModelsByCategoryGrid: View {
    let models = Models()
    
    var body: some View {
        VStack {
            ForEach(ModelCategory.allCases, id: \.self) { category in
                
                let modelsByCategory = models.get(category: category)
                                HorizontalGrid(title: category.label, items: modelsByCategory)
                
            }
        }
    }
}

struct HorizontalGrid: View {
    
    var title: String
    var items: [Model]
    
    private let gridItemLayout = [GridItem(.fixed(150))]
    var body: some View {
        VStack(alignment: .leading) {
            
            Text(title)
                .font(.title2).bold()
                .padding(.leading, 22)
                .padding(.top, 10)
            
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHGrid(rows: gridItemLayout, spacing: 30) {
                    ForEach(0..<items.count) { index in
                        
                        Color(UIColor.secondarySystemFill)
                            .frame(width: 150, height: 150)
                            .cornerRadius(9)
                    }
                }
                .padding(.horizontal, 22)
                .padding(.vertical, 10)
            }
        }
    }
}

