class SliderModel {
  String _imagePath;
  String _title;
  String _description;

  SliderModel({String imagePath, String title, String description}) {
    this._imagePath = imagePath;
    this._title = title;
    this._description = title;
  }

  String get description => _description;

  setdescription(String value) {
    _description = value;
  }

  String get title => _title;

  settitle(String value) {
    _title = value;
  }

  String get imagePath => _imagePath;

  setimagePath(String value) {
    _imagePath = value;
  }
}

List<SliderModel> getSlides() {
  List<SliderModel> slides = new List<SliderModel>();

  SliderModel sliderModel = new SliderModel();

  sliderModel.setimagePath("assets/images/logo_white_background.jpg");
  sliderModel.settitle("Welcome to STARS Helper!");
  sliderModel.setdescription("~Description~");
  slides.add(sliderModel);

  sliderModel = new SliderModel();

  sliderModel.setimagePath("assets/images/Planner.jpg");
  sliderModel.settitle("Timetable Generator");
  sliderModel.setdescription("~Description~");
  slides.add(sliderModel);

  sliderModel = new SliderModel();

  sliderModel.setimagePath("assets/images/Swapping.png");
  sliderModel.settitle("Course Swapping");
  sliderModel.setdescription("~Description~");
  slides.add(sliderModel);

  sliderModel = new SliderModel();
  return slides;
}
