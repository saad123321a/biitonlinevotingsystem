import SwiftUI

struct DeepBlueThemeView: View {
    var body: some View {
        ZStack {
            Color.white.edgesIgnoringSafeArea(.all) // Background color
            
            VStack {
                Text("Voting App")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(Color("DeepBlue")) // Use the deep blue color for text
                
                Image(systemName: "ballot")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 100)
                    .foregroundColor(Color("DeepBlue")) // Use the deep blue color for the image
                
                Text("Trust, Reliability, Professionalism")
                    .font(.headline)
                    .foregroundColor(Color.gray)
                    .padding()
                
                Button(action: {
                    // Action here
                }) {
                    Text("Start Voting")
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color("DeepBlue")) // Use the deep blue color for the button
                        .cornerRadius(10)
                }
                .padding()
            }
        }
    }
}

struct DeepBlueThemeView_Previews: PreviewProvider {
    static var previews: some View {
        DeepBlueThemeView()
            .previewDevice("iPhone 12")
            .preferredColorScheme(.light)
    }
}
