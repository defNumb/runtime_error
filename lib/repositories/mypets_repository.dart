// MY PETS REPOSITORY FOLLOWS THE SAME ACCESSING PATTERNS
// AS THE FAVORITES REPOSITORY, SO YOU CAN USE THE SAME
// LOGIC TO COMPLETE THE MY PETS REPOSITORY
// you can copy and paste the FavoriteRepository class and rename it to MyPetsRepository
// the pet model has already been created for you in lib\models\pet_model.dart
// the collection name is 'pets' and the document id is the pet id that you can get from the pet object
// when adding a new pet you need to create a new document with the pet id as the document id


// HOW TO CREATE A NEW DOCUMENT ID
// final petDoc = await usersRef.doc(uid).collection('pets');
// var randomDoc = petDoc.doc();
// from there you can access the randomly generated document id using randomDoc.id
// to pass that in when setting the data.
// setting data for a new pet example
// await petDoc.doc(randomDoc.id).set({
//  'id': randomDoc.id,
//  'name': pet.name,
//  'icon': pet.icon,
//  'species': pet.species,
//  'breed': pet.breed,
//  'breed2': pet.breed2,
//  'gender': pet.gender,
//  'birthDay': pet.birthDay,
//  'weight': pet.weight,
//  'healthConditions': pet.healthConditions,
//  'neutered': pet.neutered,
//  'backgroundImage': pet.backgroundImage,
//  'referenceId': uid,
//  },);