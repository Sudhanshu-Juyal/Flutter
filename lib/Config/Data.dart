
class Data {
  List<String> datta ;
  List<String> degreeList ;

  Data() {
   datta = new List();
   degreeList = new List();
  }
  List<String> dataList()
  {
    datta.add("Today");
    datta.add("Monday");
    datta.add("Tuesday");
    datta.add("Wednesday");
    datta.add("Thursday");
    datta.add("Friday");
    datta.add("Saturday");
    return datta;
  }
  List<String> degreeListing()
  {

    degreeList.add("25°");
    degreeList.add("25°");
    degreeList.add("25°");
    degreeList.add("25°");
    degreeList.add("25°");
    degreeList.add("25°");
    degreeList.add("25°");
    return degreeList;
  }

}