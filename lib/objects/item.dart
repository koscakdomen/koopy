class Item {
  String name, description;
  int quantity, userBoughtID, userAddedID;
  DateTime dateAdded, dateBought;
  bool checked;

  Item(name, description, quantity, dateAdded, dateBought, userAddedID,
      userBoughtID) {
    this.name = name;
    this.description = description;
    this.quantity = quantity;
    this.dateAdded = dateAdded;
    this.dateBought = dateBought;
    this.userAddedID = userAddedID;
    this.userBoughtID = userBoughtID;
    this.checked = false;
  }
}
