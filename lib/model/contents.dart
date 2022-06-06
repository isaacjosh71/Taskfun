

class Content{
  String image;
  String text;
  String description;

  Content({required this.image, required this.description, required this.text});
}

List<Content> contents = [
  Content(
    image:'assets/images/on1.jfif',
    text: 'Create a space for your daily workflow',
    description: 'Daily tasks never gets easier. Create, stay updated and execute your those bulky tasks all in one app',
  ),

  Content(
    image: 'assets/images/on3.jfif',
    description: 'Stay updated with notifications and progress reports',
    text: 'Track your tasks progress',),

  Content(
      image: 'assets/images/on2.png',
      description: 'Get all task completed on time and leave none behind',
      text: 'Complete tasks easily'),
];