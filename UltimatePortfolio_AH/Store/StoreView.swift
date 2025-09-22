//
//  StoreView.swift
//  UltimatePortfolio_AH
//
//  Created by Andy Heredia on 22/9/25.
//

import SwiftUI
import StoreKit

struct StoreView: View {
    @EnvironmentObject var dataController: DataController
    @Environment(\.dismiss) var dismiss
    @State private var products = [Product]()
    
    
    var body: some View {
        NavigationStack {
            if let product = products.first {
                VStack(alignment: .leading) {
                    Text(product.displayName)
                        .font(.title)
                    
                    Text(product.description)
                    
                    Button("Buy Now") {
                        // Handle purchasing
                        purhcase(product)
                    }
                }
            }
        }
        .onChange(of: dataController.fullVersionUnlocked) { _, _ in
            checkForPurchase()
        }
        .task {
            await load()
        }
    }
    
    func checkForPurchase() {
        if dataController.fullVersionUnlocked {
            dismiss()
        }
    }
    
    func purhcase(_ product: Product) {
        Task { @MainActor in
            try await dataController.purchase(product)
        }
    }
    
    func load() async {
        do {
            products = try await Product.products(for: [DataController.unlockPremiumProductID])
        } catch {
            print("Falied to load productos: \(error.localizedDescription)")
        }
    }
}

#Preview {
    StoreView()
}
