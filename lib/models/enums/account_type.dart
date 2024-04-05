enum AccountType { undefined, propertyOwner, client }

AccountType getAccountType(String selectedValue) {
  switch (selectedValue) {
    case 'client':
      return AccountType.client;
    case 'propertyOwner':
      return AccountType.propertyOwner;
    default:
      return AccountType.undefined;
  }
}
