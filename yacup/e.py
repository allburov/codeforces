CATEGORY = 0
OFFER = 1


def read_input():
    with open("input.txt") as input_:
        line = input_.readline().strip("\n")
        if line == "categories:":
            line = input_.readline().strip("\n")
            while line != "offers:":
                id = line.split(":", 1)[1]
                line = input_.readline().strip("\n")
                name = line.split(":", 1)[1]
                yield CATEGORY, (id, name)
                line = input_.readline().strip("\n")

            line = input_.readline().strip("\n")
            while line:
                id = line.split(":", 1)[1]
                line = input_.readline().strip("\n")
                categoryId = line.split(":", 1)[1]
                line = input_.readline().strip("\n")
                name = line.split(":", 1)[1]
                line = input_.readline().strip("\n")
                description = line.split(":", 1)[1]
                line = input_.readline().strip("\n")
                price = line.split(":", 1)[1]
                yield OFFER, (id, categoryId, name, description, price)
                line = input_.readline().strip("\n")


class Solver:
    def __init__(self):
        self.categories = {}

    def category(self, category):
        id, name = category
        id = int(id)
        self.categories[id] = dict(
            id=id, name=name,
            minOffer=dict(price=2 ** 33),
            maxOffer=dict(price=-1),
        )

    def offer(self, offer):
        id, categoryId, name, description, price = offer
        id = int(id)
        categoryId = int(categoryId)
        price = int(price)

        if self.categories[categoryId]['minOffer']['price'] > price:
            self.categories[categoryId]['minOffer'] = dict(
                id=id, categoryId=categoryId, name=name, description=description, price=price,
            )
        if self.categories[categoryId]['maxOffer']['price'] < price:
            self.categories[categoryId]['maxOffer'] = dict(
                id=id, categoryId=categoryId, name=name, description=description, price=price,
            )

    def result(self):
        return self.categories

def printCategory(category):
    return f"""- id: {category['id']}
  name: {category['name']}
  minOffer: 
    id: {category['minOffer']['id']}
    name: {category['minOffer']['name']}
    description: {category['minOffer']['description']}
    price: {category['minOffer']['price']}
  maxOffer: 
    id: {category['maxOffer']['id']}
    name: {category['maxOffer']['name']}
    description: {category['maxOffer']['description']}
    price: {category['maxOffer']['price']}"""

def main():
    iterator = read_input()
    solver = Solver()
    for type, data in iterator:
        if type == CATEGORY:
            solver.category(data)
        else:
            solver.offer(data)

    res = solver.result()
    for category in res.values():
        if category['maxOffer']['price'] == -1:
            continue
        print(printCategory(category))


if __name__ == "__main__":
    main()
