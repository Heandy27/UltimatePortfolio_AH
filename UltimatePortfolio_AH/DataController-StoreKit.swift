//
//  DataController-StoreKit.swift
//  UltimatePortfolio_AH
//
//  Created by Andy Heredia on 22/9/25.
//

import Foundation
import StoreKit

extension DataController {
    /// The product ID ffor our premium unlock.
    static let unlockPremiumProductID = "com.ravecodesolutions.UltimatePortfolioAH.premiumUnlock"
    
    /// Loads and saves whether our premium unlock has been purchased.
    var fullVersionUnlocked: Bool {
        get {
            defaults.bool(forKey: "fullVersionUnlocked")
        }
        
        set {
           defaults.set(newValue, forKey: "fullVersionUnlocked")
        }
    }
    
    func monitorTransactions() async {
        // Check for previos purchases.
        for await entintlement in Transaction.currentEntitlements {
            if case let .verified(transaction) = entintlement {
                await finalize(transaction)
            }
        }
        
        // Watch for future transactions coming in.
        for await update in Transaction.updates {
            if let transaction = try? update.payloadValue {
                await finalize(transaction)
            }
        }
    }
    
    func purchase(_ product: Product) async throws {
        let result = try await product.purchase()
        
        if case let .success(validation) = result {
            try await finalize(validation.payloadValue)
        }
    }
    
    @MainActor
    func finalize(_ transaction: Transaction) async {
        if transaction.productID == Self.unlockPremiumProductID {
            objectWillChange.send()
            fullVersionUnlocked = transaction.revocationDate == nil
            await transaction.finish()
        }
    }
    
    
    @MainActor
    func loadProducts() async throws {
        guard products.isEmpty else { return }
        
        try await Task.sleep(for: .seconds(0.2))
        products = try await Product.products(for: [Self.unlockPremiumProductID])
    }
    
}
