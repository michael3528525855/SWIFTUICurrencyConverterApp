//"$", "€", "£"





import SwiftUI

struct ContentView: View {
    @State private var selection: String = "$"
    let filterOptions: [String] = ["$", "€", "£"]
    
    @State private var concurrencyAmount: String = ""
    @State private var exchangedAmount: String = ""
    @State private var errorMessage: String? = nil
    
    // Exchange rates dictionary for better scalability
    let exchangeRates: [String: Double] = [
        "$": 1.0,
        "€": 0.85,
        "£": 0.75
    ]
    
    var body: some View {
        VStack {
            Text("Currency Converter")
                .font(.largeTitle)
                .padding()
            
            // Input amount section
            VStack(alignment: .leading) {
                Text("Amount in $:")
                    .font(.headline)
                TextField("Enter amount in $...", text: $concurrencyAmount)
                    .keyboardType(.decimalPad)
                    .padding()
                    .background(Color.gray.opacity(0.3).cornerRadius(10))
                    .font(.headline)
                    .onChange(of: concurrencyAmount) { _ in
                        errorMessage = nil // Reset error message on input change
                    }
                
                if let errorMessage = errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .font(.caption)
                        .padding([.leading, .top])
                }
            }
            .padding(.horizontal)
            
            // Picker for currency selection
            Picker("Select Currency", selection: $selection) {
                ForEach(filterOptions, id: \.self) { currency in
                    Text(currency)
                        .tag(currency)
                }
            }
            .pickerStyle(WheelPickerStyle())
            .padding(.horizontal)
            
            // Button to perform conversion
            Button(action: calculateConversion) {
                Text("Convert")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
                    .foregroundColor(.white)
                    .font(.headline)
            }
            .padding(.horizontal)
            .padding(.top)
            
            // Conversion result
            HStack {
                Text("Converted Amount:")
                Text(exchangedAmount)
                Text(selection)
            }
            .padding()
            .frame(width: 350)
            .background(Color.gray.opacity(0.3).cornerRadius(10))
            .foregroundColor(.blue)
            .font(.headline)
            .padding(.top)
            
            Spacer()
        }
        .padding()
    }
    
    // Function to calculate the converted amount
    func calculateConversion() {
        guard let amount = Double(concurrencyAmount) else {
            errorMessage = "Please enter a valid number."
            exchangedAmount = ""
            return
        }
        
        if let exchangeRate = exchangeRates[selection] {
            let convertedAmount = amount * exchangeRate
            exchangedAmount = String(format: "%.2f", convertedAmount)
        } else {
            exchangedAmount = "Error"
        }
    }
}

#Preview {
    ContentView()
}
