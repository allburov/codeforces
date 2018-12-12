def book(count):
    current = 4
    current_count = 0
    while True:
        current_count += len(str(current))
        if current_count >= count:
            break
        current += 1
    return current


assert book(1) == 4
assert book(2) == 5
assert book(3) == 6
assert book(10) == 11
print(book(10000))
