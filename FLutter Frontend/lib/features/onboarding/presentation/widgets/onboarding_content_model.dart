class UnbordingContent {
  String image;
  String title;
  String description;

  UnbordingContent({
    required this.image,
    required this.title,
    required this.description,
  });
}

List<UnbordingContent> contents = [
  UnbordingContent(
      title: 'Design Your Idea',
      image: 'assets/images/onboard1.png',
      description:
          "Bring your idea to life. Design your own t-shirts and wear them with pride. Let your creativity shine!"),
  UnbordingContent(
      title: 'Submit Your Art',
      image: 'assets/images/onboard2.png',
      description:
          "Art you an artist. Submit your own art for others to choose from. Share your unique style with the world!"),
  UnbordingContent(
      title: 'Earn Royalty',
      image: 'assets/images/onboard3.png',
      description:
          "Earn money every time your art is printed. Turn your passion into profit!"),
];
