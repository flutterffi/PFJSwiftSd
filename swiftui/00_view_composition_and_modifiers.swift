import SwiftUI

struct BadgeModifier: ViewModifier {
    let color: Color

    func body(content: Content) -> some View {
        content
            .font(.caption.weight(.semibold))
            .padding(.horizontal, 10)
            .padding(.vertical, 6)
            .background(color.opacity(0.14))
            .foregroundStyle(color)
            .clipShape(Capsule())
    }
}

extension View {
    func studyBadge(color: Color) -> some View {
        modifier(BadgeModifier(color: color))
    }
}

struct LessonHeroCard: View {
    let title: String
    let subtitle: String
    let progress: Int

    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            Text("Today")
                .studyBadge(color: .blue)

            Text(title)
                .font(.title2.bold())

            Text(subtitle)
                .foregroundStyle(.secondary)

            ProgressView(value: Double(progress), total: 100)

            Text("Progress: \(progress)%")
                .font(.footnote)
                .foregroundStyle(.secondary)
        }
        .padding(20)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill(Color.blue.opacity(0.08))
        )
        .padding()
    }
}

#Preview {
    LessonHeroCard(
        title: "SwiftUI Navigation",
        subtitle: "Build a route-driven study dashboard",
        progress: 68
    )
}
