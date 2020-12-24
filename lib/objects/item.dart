class Item {
  String name, description, listName, userAddedID;
  int quantity, userBoughtID, id;
  DateTime dateAdded, dateBought;
  bool checked;

  Item(id, name, description, quantity, dateAdded, dateBought, userAddedID,
      userBoughtID, listName) {
    this.id = id;
    this.name = name;
    this.description = description;
    this.quantity = quantity;
    this.dateAdded = dateAdded;
    this.dateBought = dateBought;
    this.userAddedID = userAddedID;
    this.userBoughtID = userBoughtID;
    this.checked = false;
    this.listName = listName;
  }
}

List<Item> itemsAll = new List();
