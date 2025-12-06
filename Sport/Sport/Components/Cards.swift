import SwiftUI

struct CoachCard: View {
    var coach: Coach

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Rectangle()
                .fill(coach.accent.opacity(0.8))
                .frame(width: 150, height: 190)
                .overlay(
                    Image(systemName: "person.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50)
                        .foregroundColor(.white)
                )
                .cornerRadius(8)

            HStack(spacing: 4) {
                Text("評價")
                    .foregroundColor(.white)
                    .font(.system(size: 12))
                ForEach(0..<5) { idx in
                    Image(systemName: idx < coach.rating ? "star.fill" : "star")
                        .foregroundColor(.yellow)
                        .font(.system(size: 12))
                }
            }

            Text("姓名  \(coach.name)")
                .foregroundColor(.white)
                .font(.system(size: 13))
            Text("經歷  \(coach.experience)")
                .foregroundColor(.white)
                .font(.system(size: 13))
        }
        .frame(width: 150, alignment: .leading)
    }
}

struct GroupClassCard: View {
    var index: Int

    var body: some View {
        ZStack(alignment: .topTrailing) {
            Rectangle()
                .fill(Color.orange.opacity(0.8 - Double(index) * 0.1))
                .frame(width: 104, height: 106)
                .cornerRadius(10)
            Image(systemName: "heart")
                .foregroundColor(.white)
                .padding(8)
        }
    }
}
