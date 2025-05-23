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
                ModelsByCategoryGrid(showBrowse: $showBrowse)
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
    
    @Binding var showBrowse: Bool
    
    var body: some View {
        VStack {
            ForEach(ModelCategory.allCases, id: \.self) { category in
                
                let modelsByCategory = models.get(category: category)
                HorizontalGrid(title: category.label, items: modelsByCategory, showBrowse: $showBrowse)
                
            }
        }
    }
}

struct HorizontalGrid: View {
    
    var title: String
    var items: [Model]
    
    @Binding var showBrowse: Bool
    
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
                        
                        let model = items[index]
                        
                        itemButton(model: model) {
                            model.asyncLoadModelEntity()
                            //TODO: select model for placement
                            print("BrowseView: selected \(model.name)")
                            self.showBrowse = false
                        }
                        
                    }
                }
                .padding(.horizontal, 22)
                .padding(.vertical, 10)
            }
        }
    }
}

struct itemButton: View {
    let model: Model
    let action: () -> Void
    
    var body: some View {
        Button(action: {
            self.action()
        }) {
            Image(uiImage: self.model.thumbnail)
                .resizable()
                .frame(height: 150)
                .aspectRatio(1/1, contentMode: .fit)
                .background(Color(UIColor.secondarySystemFill))
                .cornerRadius(8.0)
        }
    }
}

struct Separator: View {
    var body: some View {
        Divider()
            .padding(.horizontal, 20)
            .padding(.vertical, 10)
    }
}

